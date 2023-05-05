#!/usr/bin/env bash

set -euo pipefail

. "$(dirname "$0")/cmd/command.sh"

ROOT=$(cd "$( dirname "$( readlink "$0" || echo "$0" )" )/.."; pwd)
. "${ROOT}/conf/version.sh"

PID_FILE="${ROOT}/run/server.pid"
OUT_FILE="${ROOT}/run/server.out"

function startServer {
  echo "Starting server"
  mkdir -p "${ROOT}/run"
  local -r SERVER_CMD="java -jar ${ROOT}/server/target/base-server-${VERSION}.jar"
  nohup ${SERVER_CMD} > "${OUT_FILE}" 2>&1 & echo $! > "${PID_FILE}"
  local -r PID=$(cat "${PID_FILE}")
  echo "Server started with pid ${PID}"
}
appendCommand "startServer" "startServer" "  startServer \t Starts the grpc server"

function stopServer {
  echo "Stopping server"
  local -r PID=$(cat "${PID_FILE}")
  echo "Found pid ${PID}"
  kill "${PID}"
  echo "Server stopped"
}
appendCommand "stopServer" "stopServer" "  startServer \t Stop the grpc server"
