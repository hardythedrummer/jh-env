#!/usr/bin/env bash
set -euo pipefail

service="${1:?Usage: get-key.sh <service> <account>}"
account="${2:?Usage: get-key.sh <service> <account>}"

security find-generic-password -a "$account" -s "$service" -w
