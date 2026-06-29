Use the committed root Dockerfile as-is. Do NOT regenerate it, do NOT change the pod image, and
do NOT run language auto-detection (this repo is the Ory Hydra Go monorepo and must NOT be built
from source). The Dockerfile wraps the prebuilt oryd/hydra:v2.2.0 with tini PID-1 and an entrypoint
that runs `hydra migrate sql` then `hydra serve all --dev` (plain HTTP on :4444) against a local
SQLite database at /data. Single pod, no external database. Keep nexlayer.yaml's app image as the
pipeline-built image — never revert it to mirror.gcr.io/oryd/hydra.
