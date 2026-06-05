# Active context

**Focus:** Master plan authored; no implementation started. Repo working tree empty (post-cleanup `0bc3f53`).

**North star:** Care-to-Cash — point-of-care logging auto-creates ledger charges when not covered by base board.

**Locked v1 decisions:**
- Expo/React Native mobile (EAS builds)
- Internal ledger + monthly statement PDFs (no payment processor)
- API + PostgreSQL in `stirrup` tenant namespace on homelab k8s

**Next mini-plans (ordered):**
1. [MP-0.1 + MP-0.5](plans.md#mp-01--mp-05--repo-re-seed--monorepo) — Re-seed repo, CI kit, pnpm monorepo
2. [MP-0.7 + MP-1.1a](plans.md#mp-07--mp-11a--postgres--domain-schema) — Postgres + domain schema
3. [MP-2.2](plans.md#mp-22--care-to-cash-pipeline) — Care-to-Cash API proof (before mobile)

**Canonical doc:** [stirrup-barn-manager-master-plan.md](stirrup-barn-manager-master-plan.md)

**Open decisions (resolve before MP-1.1a):** See master plan § Decision log — billing account model, groom auth, phone→API connectivity, registry canonical path.
