# Active context

**Focus:** Master plan v1.1 deepened (mobile ↔ Kubernetes design); no implementation started. Repo working tree empty (post-cleanup `0bc3f53`).

**North star:** Care-to-Cash — point-of-care logging auto-creates ledger charges when not covered by base board.

**Locked v1 decisions:**
- Expo/React Native mobile (EAS builds)
- Internal ledger + monthly statement PDFs (no payment processor)
- API + PostgreSQL in `stirrup` tenant namespace on homelab k8s
- Cloudflare Tunnel connectivity (D-04); WAN port-forward fallback
- JWT auth on `/api`; no oauth2-proxy on tenant Ingress (D-18)
- Postgres on `rook-ceph-block-retain` + early pg_dump (D-20)
- GitLab registry `registry.reeves.racing` (D-01)

**Next mini-plans (ordered):**
1. [MP-0.10–0.12](plans.md#phase-0--foundation) — Platform operator: Tunnel, netpol, retain SC
2. [MP-0.1 + MP-0.5](plans.md#mp-01--mp-05--repo-re-seed--monorepo) — Re-seed repo, CI kit, pnpm monorepo
3. [MP-0.7 + MP-1.1a](plans.md#mp-07--mp-11a--postgres--domain-schema) — Postgres + domain schema
4. [MP-2.2](plans.md#mp-22--care-to-cash-pipeline) — Care-to-Cash API proof (before mobile)

**Canonical doc:** [stirrup-barn-manager-master-plan.md](stirrup-barn-manager-master-plan.md)

**Open decisions (resolve before MP-1.1a):** D-02 API framework, D-03 migrations, D-05 billing account, D-06 board package shape, D-08 task anchor, D-09 groom auth, D-10 admin surface, D-22 repo host GitHub vs GitLab.
