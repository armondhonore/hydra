FROM oryd/hydra:v2.2.0
USER root
COPY hydra-entrypoint.sh /hydra-entrypoint.sh
ENTRYPOINT ["/hydra-entrypoint.sh"]
