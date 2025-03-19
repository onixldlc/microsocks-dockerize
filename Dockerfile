FROM alpine:3.18 AS build

RUN apk update && apk upgrade --update --no-cache

WORKDIR /microsocks
COPY . .

RUN apk add --no-cache \
    dumb-init \
    build-base \
    make 

RUN make

FROM alpine:3.18 AS runner
COPY --from=build /microsocks/microsocks /bin/microsocks
ENTRYPOINT ["/bin/microsocks"]