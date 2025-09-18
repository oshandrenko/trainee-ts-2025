FROM alpine:3.21 AS build

RUN apk add --no-cache \
    git \
    cmake \
    make \
    g++ \
    sdl2-dev \
    openal-soft-dev \
    curl-dev \
    patchelf

RUN adduser -D -u 1000 -s /bin/nologin dhewm3user

RUN git clone https://github.com/dhewm/dhewm3.git /src

RUN cd /src && \
    mkdir build && \
    cd build && \
    cmake \
        -DDEDICATED=ON \
        -DCMAKE_C_FLAGS="-D_LARGEFILE64_SOURCE" \
        -DCMAKE_CXX_FLAGS="-D_LARGEFILE64_SOURCE" \
        ../neo/ && \
    make -j$(nproc)

RUN mkdir -p /app/lib && \
    cp /src/build/dhewm3ded /app/dhewm3ded && \
    patchelf --set-interpreter /lib/ld-musl-x86_64.so.1 /app/dhewm3ded && \
    cp /lib/ld-musl-x86_64.so.1 /app/lib/ && \
    for lib in $(ldd /app/dhewm3ded | grep "=> /" | awk '{print $3}'); do \
        cp "$lib" /app/lib/; \
    done


FROM scratch

COPY --from=build /etc/passwd /etc/passwd
COPY --from=build /etc/group /etc/group

COPY --from=build /app /

ENV SDL_VIDEODRIVER=dummy

USER dhewm3user

ENTRYPOINT ["/dhewm3ded", "+set", "fs_basepath", "/game"]
