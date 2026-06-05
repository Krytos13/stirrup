# Plans index

Mini-plans spun off from [stirrup-barn-manager-master-plan.md](stirrup-barn-manager-master-plan.md). Update status here when work starts or completes.

**Status legend:** `queued` | `in_progress` | `blocked` | `complete`

---

## Phase 0 — Foundation

| ID | Name | Depends | Status |
|----|------|---------|--------|
| MP-0.1 | Repo re-seed | — | queued |
| MP-0.2 | Tenant bundle reconcile | MP-0.1 | queued |
| MP-0.3 | DNS | MP-0.2 | queued |
| MP-0.4 | Vault secrets | MP-0.2 | queued |
| MP-0.5 | Monorepo scaffold | MP-0.1 | queued |
| MP-0.6 | Container pipeline | MP-0.5 | queued |
| MP-0.7 | Postgres on tenant PVC | MP-0.4, MP-0.6 | queued |
| MP-0.8 | Ingress + TLS | MP-0.6 | queued |
| MP-0.9 | Memory bank | — | complete |

**Phase 0 gate:** `https://stirrup.reeves.racing/healthz` returns OK; Postgres migrations applied; CI green.

---

## Phase 1 — Domain and identity

| ID | Name | Depends | Status |
|----|------|---------|--------|
| MP-1.1a | ERD + migrations v001 | MP-0.7 | queued |
| MP-1.1b | Shared types + API contract | MP-1.1a | queued |
| MP-1.1c | Seed data (demo barn) | MP-1.1a | queued |
| MP-1.2 | Auth API | MP-1.1a | queued |
| MP-1.2m | Mobile login | MP-1.2, MP-3.4 | queued |
| MP-1.3 | Admin API (CRUD) | MP-1.2 | queued |

**Phase 1 gate:** Manager creates horse + board package + service via API; groom account exists.

---

## Phase 2 — Care-to-Cash (MVP)

| ID | Name | Depends | Status |
|----|------|---------|--------|
| MP-2.1 | Coverage engine | MP-1.1a | queued |
| MP-2.2 | Care-to-Cash pipeline | MP-2.1 | queued |
| MP-2.3 | Task scheduler | MP-1.1a | queued |
| MP-2.4 | Quick Charge (ad-hoc billable) | MP-2.2 | queued |

**Phase 2 gate:** API acceptance test — `pm_feed` bills, `am_feed` included does not; idempotent sync.

---

## Phase 3 — QR and offline mobile

| ID | Name | Depends | Status |
|----|------|---------|--------|
| MP-3.1 | QR generation + print kit | MP-1.3 | queued |
| MP-3.3a | SQLite schema + migrations | MP-1.1b | queued |
| MP-3.3b | Sync engine | MP-2.2, MP-3.3a | queued |
| MP-3.3c | StallScan UI | MP-3.1, MP-3.3b | queued |
| MP-3.4 | EAS pipeline | MP-0.5 | queued |

**Phase 3 gate:** Airplane mode → scan QR → complete task → sync → ChargeLine in API.

---

## Phase 4 — Split expenses

| ID | Name | Depends | Status |
|----|------|---------|--------|
| MP-4.1 | Split engine (`equal` first) | MP-2.2 | queued |
| MP-4.2 | Manager split UI | MP-4.1 | queued |

**Phase 4 gate:** $200 vet trip / 4 horses → 4 × $50 ChargeLines.

---

## Phase 5 — Proration and deposits

| ID | Name | Depends | Status |
|----|------|---------|--------|
| MP-5.1 | Proration library | MP-1.1b | queued |
| MP-5.2 | Deposit lifecycle | MP-5.1 | queued |

**Phase 5 gate:** Mid-month move-in prorates; deposit tracked separately.

---

## Phase 6 — Monthly statements

| ID | Name | Depends | Status |
|----|------|---------|--------|
| MP-6.1 | Statement aggregator | MP-2.2 | queued |
| MP-6.2 | PDF template | MP-6.1 | queued |
| MP-6.3 | Client read-only portal | MP-6.2 | queued |

**Phase 6 gate:** Finalize month → PDF total matches ledger.

---

## Phase 7 — K8s hardening

| ID | Name | Depends | Status |
|----|------|---------|--------|
| MP-7.1 | Observability | MP-0.8 | queued |
| MP-7.2 | Backup / restore runbook | MP-0.7 | queued |

---

## Phase 8 — Deferred

| ID | Name | Status |
|----|------|--------|
| MP-8.1 | Client booking portal | deferred |
| MP-8.2 | Medical records | deferred |
| MP-8.3 | Calendar / scheduling | deferred |
| MP-8.4 | Stripe / payment links | deferred |
| MP-8.5 | QuickBooks export | deferred |
| MP-8.6 | Google OIDC staff login | deferred |
| MP-8.7 | Push notifications | deferred |
| MP-8.8 | Photo attach on care events | deferred |

---

## Mini-plan detail stubs

Copy each stub into a dated section below when starting work. Full phase steps live in the master plan.

### MP-0.1 + MP-0.5 — Repo re-seed + monorepo

**Goal:** Restored tenant repo with CI kit and pnpm workspaces.  
**Steps:** See master plan Phase 0 steps 0.1, 0.5.  
**Dependencies:** Platform templates at `k3s-homelab-platform/tenants/templates/`.  
**Status:** queued

### MP-0.7 + MP-1.1a — Postgres + domain schema

**Goal:** PostgreSQL live; schema v001 with care + ledger core.  
**Steps:** See master plan Phase 0.7, Phase 1.1.  
**Dependencies:** Decision log items for MP-1.1a resolved.  
**Status:** queued

### MP-2.2 — Care-to-Cash pipeline

**Goal:** Care event ingestion → coverage check → optional ChargeLine in one transaction.  
**Steps:** See master plan Phase 2.2.  
**Dependencies:** MP-2.1, MP-1.1a.  
**Status:** queued
