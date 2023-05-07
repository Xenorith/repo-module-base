#!/usr/bin/env bash

set -euo pipefail

. "$(dirname "$0")/cmd/command.sh"
. "${dirname "$0")/cmd/serverConstants.sh"
. "${ROOT}/conf/version.sh"

function startServer {
  echo "Starting server"
  mkdir -p "${ROOT}/run"
  local -r SERVER_CMD="java -jar ${ROOT}/base/server/target/base-server-${VERSION}.jar"
  nohup ${SERVER_CMD} > "${OUT_FILE}" 2>&1 & echo $! > "${PID_FILE}"
  local -r PID=$(cat "${PID_FILE}")
  echo "Server started with pid ${PID}"
}
appendCommand "startServer" "startServer" "  startServer \t Starts the grpc server"

