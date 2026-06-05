# Progress

**Snapshot:** Planning complete. Implementation not started.

## Truth

- **Repo:** [stirrup](https://github.com/Krytos13/stirrup) — working tree empty; prior splash tenant scaffolding in git history (`9398584`).
- **Cluster:** Tenant slug `stirrup`, host `stirrup.reeves.racing`; bundle/namespace state unverified since cleanup.
- **Master plan:** [stirrup-barn-manager-master-plan.md](stirrup-barn-manager-master-plan.md)
- **Mini-plans:** [plans.md](plans.md) — all `queued`

## Ordered next work

1. **MP-0.1 + MP-0.5** — Re-seed from platform tenant kit; pnpm monorepo; restore `homelab-tenant.yaml`
2. **MP-0.2–0.8** — Tenant bundle, DNS, Vault ESO, Postgres, ingress, CI image (Phase 0 gate)
3. **MP-1.1a** — Domain schema freeze (resolve decision log items first)
4. **MP-2.2** — Care-to-Cash pipeline API acceptance test
5. **MP-3.x** — Expo offline mobile (after MP-2.2 passes)

## Risks (top 5)

| Risk | Mitigation |
|------|------------|
| Revenue leak persists if only task-template path exists | MP-2.4 Quick Charge — ad-hoc billable care |
| Phones off-LAN cannot reach API | Decide connectivity in Phase 0 (Tailscale / split DNS) |
| Medium namespace quota OOM | Size Postgres + API requests explicitly |
| Board package ambiguity | Coverage audit + manager waivers; iterate catalog |
| Schema churn | Freeze care + ledger tables in MP-1.1a; snapshot prices on ChargeLine |

## Deferred (explicit)

Phases 4–8 features, Phase 7 hardening (mostly), Phase 8 nice-to-haves — see master plan § Deferral matrix.
