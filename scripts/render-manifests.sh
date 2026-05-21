#!/usr/bin/env bash
set -euo pipefail

RENDER_PATH="${RENDER_PATH:-}"
MANIFEST_OUTPUT="${MANIFEST_OUTPUT:-rendered.yaml}"

read_contract_render_path() {
  if [ ! -f homelab-tenant.yaml ]; then
    return 0
  fi
  local path
  path="$(grep -E '^[[:space:]]*renderPath:[[:space:]]*' homelab-tenant.yaml | head -n1 | sed -E 's/^[[:space:]]*renderPath:[[:space:]]*//; s/[[:space:]]+$//; s/^["'\'']|["'\'']$//g')"
  if [ -n "${path}" ]; then
    RENDER_PATH="${path}"
  fi
}

auto_detect_kustomize_root() {
  for candidate in k8s deploy; do
    if [ -f "${candidate}/kustomization.yaml" ]; then
      RENDER_PATH="${candidate}"
      return 0
    fi
  done
  return 1
}

has_flat_yaml_manifests() {
  local dir="$1"
  [ -d "${dir}" ] && find "${dir}" -maxdepth 1 -type f -name '*.yaml' ! -name 'kustomization.yaml' | grep -q .
}

render_flat_yaml_dir() {
  local dir="$1"
  local output="$2"
  local first=1
  : > "${output}"
  while IFS= read -r file; do
    if [ "${first}" -eq 1 ]; then
      first=0
    else
      printf '\n---\n' >> "${output}"
    fi
    cat "${file}" >> "${output}"
  done < <(find "${dir}" -maxdepth 1 -type f -name '*.yaml' ! -name 'kustomization.yaml' | sort)
  if [ "${first}" -eq 1 ]; then
    echo "No YAML manifests found in ${dir}."
    return 1
  fi
}

if [ -z "${RENDER_PATH}" ]; then
  read_contract_render_path
fi

if [ -z "${RENDER_PATH}" ]; then
  auto_detect_kustomize_root || true
fi

if [ -n "${RENDER_PATH}" ] && [ -f "${RENDER_PATH}/kustomization.yaml" ]; then
  echo "Rendering kustomize path: ${RENDER_PATH}"
  kustomize build "${RENDER_PATH}" > "${MANIFEST_OUTPUT}"
elif [ -n "${RENDER_PATH}" ] && has_flat_yaml_manifests "${RENDER_PATH}"; then
  echo "Rendering flat YAML directory: ${RENDER_PATH}"
  render_flat_yaml_dir "${RENDER_PATH}" "${MANIFEST_OUTPUT}"
elif [ -f "Chart.yaml" ]; then
  echo "Rendering Helm chart from repository root"
  if [ -f "values.yaml" ]; then
    helm template tenant-app . -f values.yaml > "${MANIFEST_OUTPUT}"
  else
    helm template tenant-app . > "${MANIFEST_OUTPUT}"
  fi
else
  echo "No renderable manifests found."
  echo "Set renderPath in homelab-tenant.yaml, add kustomization.yaml under k8s/ or deploy/, or add Chart.yaml at repo root."
  exit 1
fi
