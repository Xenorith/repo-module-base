#!/usr/bin/env bash

set -euo pipefail

# arrays to store common information about commands
# the set of defined arrays can be treated as the set of fields defined for a simple object or struct where each field type is a primitive type
# ex. the following defines a command struct that is analogous to
# object Command {
#   String function
#   String usageHelp
# }
declare -A commandFunctions
declare -a commandUsageHelp

function appendCommand {
  if [[ $# -ne 3 ]]; then
    echo "appendCommand takes in 3 arguments for name, function name, and help text"
    exit 1
  fi
  commandFunctions[$1]="$2"
  commandUsageHelp+=("$3")  # lists usage help text in the order the commands are registered
}

# define main function
#######################

function printUsage {
  echo "Usage: COMMAND [COMMAND_ARGS]"
  echo
  echo "COMMAND is one of:"
  for commandHelp in "${commandUsageHelp[@]}"; do
    echo -e "${commandHelp}"
  done
}

function main {
  if [[ $# == 0 ]]; then
    echo "DEBUG: no args, so printing usage and existing"
    printUsage
    exit 1
  fi

  COMMAND=$1
  shift

  if [[ ! ${commandFunctions[${COMMAND}]+exists} ]]; then
    echo "Unsupported command ${COMMAND}" >&2
    printUsage
    exit 1
  fi

  local -r cmd=${commandFunctions[$COMMAND]}
  eval "${cmd}" "$@"
}
