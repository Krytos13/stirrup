# Stirrup memory bank

Barn management app (Care-to-Cash) on homelab Kubernetes tenant `stirrup`.

## Core files

| File | Purpose |
|------|---------|
| [active-context.md](active-context.md) | Current focus and links |
| [progress.md](progress.md) | Operator snapshot — truth, next work, risks |
| [plans.md](plans.md) | Mini-plan index with status |
| [platform-context.md](platform-context.md) | Stack, homelab integration, deployment |
| [stirrup-barn-manager-master-plan.md](stirrup-barn-manager-master-plan.md) | **Master plan** — phases, pitfalls, decisions, deferral |

## How to use

1. Start every session with `active-context.md` → `progress.md` → `plans.md`.
2. Spin off work from the master plan as mini-plans; record each in `plans.md`.
3. On phase completion, update `progress.md` first, then `plans.md`, then `active-context.md`.

## Platform repo

Tenant GitOps, CI kit, Vault: [k3s-homelab-platform](https://github.com/Krytos13/k3s-homelab-platform) — `tenants/templates/`, k3s-onboarding.
