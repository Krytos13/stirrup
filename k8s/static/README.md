# Splash artwork

Add **`splash.png`** here (full-page image), or upload on k3s-onboarding **grant** when seeding the tenant repo (written as **`<repoPath>/static/splash.png`**). Baked into the container image on CI build — not served from a ConfigMap (Argo annotation size limit). Operator path: [k8s template README](../README.md) · [cluster-deploy §7](../../../../apps/k3s-onboarding/documentation/cluster-deploy.md).

After replacing the image, commit and push `main` to rebuild `ghcr.io/<owner>/<repo>:latest`.
