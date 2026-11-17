
FROM docker:cli

RUN apk add --no-cache git

WORKDIR /app

COPY builder.sh .

RUN sed -i 's/\r$//' builder.sh && chmod +x builder.sh

ENTRYPOINT ["sh", "/app/builder.sh"]
