FROM oryd/hydra:v2.2.0
USER root
ADD https://github.com/krallin/tini/releases/download/v0.19.0/tini-static-amd64 /usr/bin/tini
RUN chmod +x /usr/bin/tini
RUN mkdir -p /data
ENV DSN=sqlite:///data/hydra.sqlite?_fk=true
ENV SECRETS_SYSTEM=a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4
ENV URLS_SELF_ISSUER=https://relaxed-weasel-hydra.cloud.nexlayer.ai/
ENV OIDC_SUBJECT_IDENTIFIERS_SUPPORTED_TYPES=public
ENV OIDC_SUBJECT_IDENTIFIERS_PAIRWISE_SALT=a1b2c3d4e5f6a1b2
COPY hydra-entrypoint.sh /hydra-entrypoint.sh
RUN chmod +x /hydra-entrypoint.sh
ENTRYPOINT ["/usr/bin/tini", "-g", "--", "/hydra-entrypoint.sh"]
