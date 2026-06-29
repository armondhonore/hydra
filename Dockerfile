FROM oryd/hydra:v2.2.0
USER root
ADD https://github.com/krallin/tini/releases/download/v0.19.0/tini-static-amd64 /usr/bin/tini
RUN chmod +x /usr/bin/tini
COPY hydra-entrypoint.sh /hydra-entrypoint.sh
RUN chmod +x /hydra-entrypoint.sh
ENTRYPOINT ["/usr/bin/tini", "-g", "--", "/hydra-entrypoint.sh"]
