#!/usr/bin/env bash

set -euo pipefail

. "$(dirname "$0")/cmd/command.sh"

ROOT=$(cd "$( dirname "$( readlink "$0" || echo "$0" )" )/.."; pwd)
. "${ROOT}/conf/version.sh"

function runClient {
  echo "Running client"
  java -jar "${ROOT}/base/client/target/base-client-${VERSION}.jar"

}
appendCommand "runClient" "runClient" "  runClient \t Runs a client to make a request to the grpc server"
