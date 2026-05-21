#!/usr/bin/env bash
set -euo pipefail

KUBERNETES_VERSION="${KUBERNETES_VERSION:-1.31.0}"
RENDER_PATH="${RENDER_PATH:-}"
MANIFEST_OUTPUT="${MANIFEST_OUTPUT:-rendered.yaml}"
export RENDER_PATH MANIFEST_OUTPUT

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
bash "${SCRIPT_DIR}/render-manifests.sh"

echo "Schema validation with kubeconform"
kubeconform -strict -summary -kubernetes-version "${KUBERNETES_VERSION}" "${MANIFEST_OUTPUT}"

echo "Policy validation with conftest"
if [ -f "homelab-tenant.yaml" ]; then
  conftest test "${MANIFEST_OUTPUT}" --policy policy --data homelab-tenant.yaml
else
  conftest test "${MANIFEST_OUTPUT}" --policy policy
fi

echo "Local validation passed."
