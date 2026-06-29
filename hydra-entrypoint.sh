#!/bin/sh
set -e
until hydra migrate sql -e --yes; do echo "waiting for db..."; sleep 3; done
exec hydra serve all --dev
