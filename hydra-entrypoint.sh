#!/bin/sh
export DSN="sqlite:///data/hydra.sqlite?_fk=true"
export SECRETS_SYSTEM="a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4"
export URLS_SELF_ISSUER="https://relaxed-weasel-hydra.cloud.nexlayer.ai/"
export OIDC_SUBJECT_IDENTIFIERS_SUPPORTED_TYPES="public"
export OIDC_SUBJECT_IDENTIFIERS_PAIRWISE_SALT="a1b2c3d4e5f6a1b2"
until hydra migrate sql -e --yes; do echo "migrate retry..."; sleep 2; done
exec hydra serve all --dev
