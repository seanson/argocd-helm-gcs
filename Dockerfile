FROM argoproj/argocd:v1.3.0

USER root

# Install tools needed for your repo-server to retrieve & decrypt secrets, render manifests
# (e.g. curl, awscli, gpg, sops)
RUN apt-get update && \
    apt-get install -y \
    gpg \
    curl && \
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | \
    tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
    APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 \
    apt-key --keyring /usr/share/keyrings/cloud.google.gpg add && \
    apt-get update && \
    apt-get install -y \
    google-cloud-sdk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Switch back to non-root user
USER argocd

RUN helm init --client-only && \
    helm plugin install https://github.com/viglesiasce/helm-gcs.git --version v0.2.0
