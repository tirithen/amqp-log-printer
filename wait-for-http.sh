#!/bin/bash

set -e

host="$1"
shift
expected_exit_code="$1"
shift
cmd="$@"

function curl_returns_expected_exit_code {
    $(curl --output /dev/null --silent --head --fail $host)
    local status=$?
    if [ $status -ne $expected_exit_code ]; then
        return 1
    fi
    return 0
}

until $(curl_returns_expected_exit_code); do
  >&2 echo "service at $host is unavailable - sleeping"
  sleep 1
done

echo $cmd
>&2 echo "service at $host is up - executing command to start the service"
exec $cmd
