# argocd-helm-gcs

This is a customised version of the ArgoCD image with the following installed:

- [Helm GCS Plugin](https://github.com/viglesiasce/helm-gcs)
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/downloads-apt-get)

It's primary intent is to build an image where the ArgoCD Repo Server can use the Google Storage backend for Helm charts.
