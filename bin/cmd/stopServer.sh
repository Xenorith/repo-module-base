#!/usr/bin/env bash

set -euo pipefail

. "$(dirname "$0")/cmd/command.sh"
. "$(dirname "$0")/cmd/serverConstants.sh"

function stopServer {
  echo "Stopping server"
  local -r PID=$(cat "${PID_FILE}")
  echo "Found pid ${PID}"
  kill "${PID}"
  echo "Server stopped"
}
appendCommand "stopServer" "stopServer" "  stopServer \t Stop the grpc server"
