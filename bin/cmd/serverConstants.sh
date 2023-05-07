#!/usr/bin/env bash

set -euo pipefail

. "$(dirname "$0")/cmd/command.sh"

ROOT=$(cd "$( dirname "$( readlink "$0" || echo "$0" )" )/.."; pwd)
. "${ROOT}/conf/version.sh"

PID_FILE="${ROOT}/run/server.pid"
OUT_FILE="${ROOT}/run/server.out"

