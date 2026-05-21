# Ingress splash (tenant repo template)

Full-screen splash image behind **nginx** Ingress — validated on [brosdoodoo](https://github.com/Krytos13/brosdoodoo). Copy into a **tenant GitHub repo** when onboarding with k3s-onboarding (Argo path usually **`k8s`**).

## Copy layout

| From this template | To tenant repo |
|--------------------|----------------|
| `deployment.yaml`, `service.yaml`, `ingress.yaml`, `kustomization.yaml`, `static/` | **`k8s/`** (match `repoPath` in the onboarding job / `Application` spec) |
| `Dockerfile` | repo root |
| `../repo-ci/.github/workflows/tenant-image.yaml` | **`.github/workflows/tenant-image.yaml`** |
| `../repo-ci/` (workflows, `scripts/render-manifests.sh`, `policy/`, contract) | **Required for all repos** — see [repo-ci/README.md](../repo-ci/README.md) |

## Replace placeholders

Search/replace before the first commit (slug = namespace / Argo app name, e.g. `wedge-app`):

| Placeholder | Example | Notes |
|-------------|---------|--------|
| `stirrup` | `wedge-app` | Resource names, labels, hostname |
| `krytos13` | `krytos13` | GitHub user/org for `deployment.yaml` `image:` (**must be lowercase** — matches `${GITHUB_REPOSITORY,,}` in tenant-image CI) |
| `stirrup.reeves.racing` | (derived) | Ingress host + TLS; add to [Pi-hole `FTLCONF_dns_hosts`](../../../apps/managed/pihole/deployment.yaml) → **192.168.1.15** |

**Artwork:** add **`k8s/static/splash.png`** (or upload via k3s-onboarding grant when seeding the tenant repo — committed as `<repoPath>/static/splash.png`), then push `main` so CI publishes the image. Omit upload to add artwork manually later.

Set `deployment.yaml` `image:` to match the tenant repo’s GHCR package (`ghcr.io/<owner>/<repo>:latest`). The workflow tags **`ghcr.io/${{ github.repository }}`** (lowercase) automatically.

## Why a container image

Do **not** use a ConfigMap for the PNG. Argo CD tracking annotations are capped at 256 KiB; large manifests fail sync and pods see `configmap ... not found`.

## Cluster checklist (operator)

1. Onboarding job merged → `tenants/bundles/<slug>/` + tenant `Application` path `k8s`.
2. Pi-hole: `<slug>.reeves.racing` on ingress VIP **192.168.1.15** ([pihole.md §7](../../../apps/managed/pihole/pihole.md)).
3. PSA row in [psa-namespaces.csv](../../../platform/deploy/security/psa-namespaces.csv) (manual today; worker automation backlog).
4. Push tenant repo → **tenant-image** workflow → Argo sync **`Application/<slug>`**.

## Reference

Live example: [Krytos13/brosdoodoo](https://github.com/Krytos13/brosdoodoo) · Platform bundle: `tenants/bundles/<slug>/`.
