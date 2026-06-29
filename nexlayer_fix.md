Use the committed root Dockerfile as-is. Do NOT regenerate it or run language auto-detection.
The Dockerfile wraps the prebuilt oryd/hydra:v2.2.0 image with an entrypoint that runs
`hydra migrate sql` then `hydra serve all --dev` (plain HTTP on :4444). Build by copying the
entrypoint onto the base image only — there is no Go source build.
