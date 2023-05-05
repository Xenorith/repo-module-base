#!/usr/bin/env bash

SCRIPT_DIR=$(cd "$( dirname "$( readlink "$0" || echo "$0" )" )"; pwd)

(cd ${SCRIPT_DIR}/src/github.com/xenorith/ && GO111MODULE=on go build -o buildTarball "build/main.go")

${SCRIPT_DIR}/src/github.com/xenorith/buildTarball $@

rm ${SCRIPT_DIR}/src/github.com/xenorith/buildTarball
