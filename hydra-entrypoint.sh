#!/bin/sh
echo "DSN=$DSN"
until hydra migrate sql -e --yes; do echo "migrate retry..."; sleep 2; done
exec hydra serve all --dev
