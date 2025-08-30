#!/bin/bash

set -x

if [ -z "$1" ]; then
    echo "Usage: $0 <path/to/dir>"
    exit 1
fi

if [ ! -d "$1" ]; then
    echo "$1 is not a directory"
    exit 2
fi

ERROR_LOG=$(mktemp)
exec 2>>"$ERROR_LOG"

process_file() {
    local file="$1"
    local input_value="$2"

    if [[ -f "$file" ]]; then
        echo "File '$file' is a file." >&2
    else
        echo "Error: File '$file' is not a file." >&2
        return 1
    fi

    local result=$((input_value * 2))
    echo "$result"
}

input_value=1

for FILE in "$1"/*; do
    FILE=$(realpath "$FILE")

    result=$(process_file "$FILE" "$input_value") || continue
    input_value=$result

    echo "File: $FILE checked. | Result: $result"
done

echo "Errors logged to: $ERROR_LOG"

