# Progress

**Snapshot:** Master plan v1.1 deepened (mobile ↔ Kubernetes); implementation not started.

## Truth

- **Repo:** [stirrup](https://github.com/Krytos13/stirrup) — working tree empty; prior splash tenant scaffolding in git history (`9398584`).
- **Cluster:** Tenant slug `stirrup`, host `stirrup.reeves.racing`; bundle/namespace state unverified since cleanup; cloudflared not yet deployed.
- **Master plan:** [stirrup-barn-manager-master-plan.md](stirrup-barn-manager-master-plan.md) v1.1
- **Mini-plans:** [plans.md](plans.md) — MP-0.9 complete; rest `queued`

## Ordered next work

1. **MP-0.12 + MP-0.10 + MP-0.11** — Platform operator: retain StorageClass, Cloudflare Tunnel, netpol 5432
2. **MP-0.1 + MP-0.5** — Re-seed from platform tenant kit; pnpm monorepo; restore `homelab-tenant.yaml`
3. **MP-0.2–0.8 + MP-0.13** — Tenant bundle, DNS, Vault ESO, Postgres on retain SC, ingress, pg_dump (Phase 0 gate)
4. **MP-1.1a** — Domain schema freeze (resolve D-02–D-10, D-22 first)
5. **MP-2.2** — Care-to-Cash pipeline API acceptance test
6. **MP-3.x** — Expo offline mobile (after MP-2.2 + MP-0.10 Tunnel)

## Risks (top 5)

| Risk | Mitigation |
|------|------------|
| Revenue leak persists if only task-template path exists | MP-2.4 Quick Charge — ad-hoc billable care |
| oauth2-proxy on tenant Ingress blocks mobile | D-18: no `auth-url`; JWT-only API; never copy k3s-onboarding ingress (P-24) |
| API→Postgres blocked by default netpol | MP-0.11 platform MR: 5432 egress (P-25) |
| Postgres on local-path loses ledger on node move | `rook-ceph-block-retain` + early pg_dump (P-26, MP-0.13) |
| Medium namespace quota OOM (512Mi–1Gi) | Explicit requests/limits; pdf-lib not Chromium (P-28, D-21) |

## Deferred (explicit)

Phases 4–8 features, most Phase 7 observability — see master plan § Deferral matrix.
