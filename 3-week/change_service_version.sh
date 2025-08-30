#!/bin/bash

# ====== Настройка логгирования ======
LOG_FILE="log.txt"

# tee на stderr: лог пишется и на экран, и в файл
log() {
  echo "[INFO] $1" | tee -a "$LOG_FILE" >&1
}

error() {
  echo "[ERROR] $1" | tee -a "$LOG_FILE" >&2
}

# ====== Переменные ======
INPUT_FILE="services.txt"
OUTPUT_FILE="services_updated.json"

# ====== Проверка аргументов ======
validate_args() {
  log "Validating input arguments..."
  if [[ -z "$SERVICE_NAME" || -z "$NEW_VERSION" ]]; then
    error "Usage: $0 <service-name> <new-version>"
    exit 1
  fi
  log "Service name: $SERVICE_NAME"
  log "New version: $NEW_VERSION"
}

# ====== Проверка наличия сервиса ======
check_service_exists() {
  log "Checking if service '$SERVICE_NAME' exists in $INPUT_FILE..."
  MATCHES=($(grep -n "\"name\": \"$SERVICE_NAME\"" "$INPUT_FILE"))
  if [ ${#MATCHES[@]} -eq 0 ]; then
    error "Service '$SERVICE_NAME' not found."
    exit 1
  fi
  log "Found ${#MATCHES[@]} occurrence(s) of '$SERVICE_NAME'"
}

# ====== Обновление версии ======
update_version() {
  log "Updating version of service '$SERVICE_NAME' to '$NEW_VERSION'..."
  sed -E ':a;N;$!ba;s/("name": "'"$SERVICE_NAME"'",[^}]*?"version": *")[^"]+(")/\1'"$NEW_VERSION"'\2/' "$INPUT_FILE" > "$OUTPUT_FILE"
  log "Version updated and saved to $OUTPUT_FILE"
}

# ====== Проверка результата ======
verify_update() {
  log "Verifying updated version..."
  UPDATED_LINE=$(grep -A 2 "\"name\": \"$SERVICE_NAME\"" "$OUTPUT_FILE" | grep '"version"')
  if echo "$UPDATED_LINE" | grep -q "\"version\": \"$NEW_VERSION\""; then
    log "✅ Version successfully updated to $NEW_VERSION for $SERVICE_NAME"
  else
    error "❌ Version update failed"
    exit 1
  fi
}

# ====== Главная функция ======
main() {
  SERVICE_NAME="$1"
  NEW_VERSION="$2"

  validate_args
  check_service_exists
  update_version
  verify_update
}

# ====== Запуск ======
main "$@"

