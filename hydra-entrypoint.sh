#!/bin/sh
export DSN="sqlite:///data/hydra.sqlite?_fk=true"
until hydra migrate sql -e --yes; do echo "migrate retry..."; sleep 2; done
exec hydra serve all --dev
