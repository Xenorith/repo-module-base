#!/usr/bin/env bash

set -euo pipefail

# load commands
###############

. "$(dirname "$0")/cmd/client.sh"
. "$(dirname "$0")/cmd/server.sh"

# run main function
###################

main "$@"
