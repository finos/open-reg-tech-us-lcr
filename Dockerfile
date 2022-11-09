# FROM node:16.1-alpine3.11
FROM node:16.18.1-alpine3.16

LABEL author="finos"

ENV NODE_ENV=production
ENV PORT=80
ENV MORPHIR_USER=morphir
ENV PROJECT_MODEL_DIR=src/Regulation/US/LCR

# Add Non Root User
RUN adduser --system --uid=7357 --no-create-home $MORPHIR_USER

#Directory of Docker Container
WORKDIR /var/morphir

COPY $PROJECT_MODEL_DIR ./
COPY morphir.json ./

RUN npm install -g morphir-elm
RUN morphir-elm make

EXPOSE $PORT

USER $MORPHIR_USER

ENTRYPOINT ["morphir-elm","develop"]