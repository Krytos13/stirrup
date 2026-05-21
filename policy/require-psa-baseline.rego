package main

deny[msg] {
  workload_kind
  spec := podspec
  not run_as_non_root(spec)
  msg := sprintf("%s must set runAsNonRoot=true at pod or container level.", [input.kind])
}

deny[msg] {
  workload_kind
  spec := podspec
  container := spec.containers[_]
  container.securityContext.allowPrivilegeEscalation != false
  msg := sprintf("%s containers must set allowPrivilegeEscalation=false.", [input.kind])
}

deny[msg] {
  workload_kind
  spec := podspec
  container := spec.initContainers[_]
  container.securityContext.allowPrivilegeEscalation != false
  msg := sprintf("%s containers must set allowPrivilegeEscalation=false.", [input.kind])
}

deny[msg] {
  workload_kind
  spec := podspec
  container := spec.ephemeralContainers[_]
  container.securityContext.allowPrivilegeEscalation != false
  msg := sprintf("%s containers must set allowPrivilegeEscalation=false.", [input.kind])
}

deny[msg] {
  workload_kind
  spec := podspec
  container := spec.containers[_]
  not drops_all_capabilities(container)
  msg := sprintf("%s containers must drop ALL Linux capabilities.", [input.kind])
}

deny[msg] {
  workload_kind
  spec := podspec
  container := spec.initContainers[_]
  not drops_all_capabilities(container)
  msg := sprintf("%s containers must drop ALL Linux capabilities.", [input.kind])
}

deny[msg] {
  workload_kind
  spec := podspec
  container := spec.ephemeralContainers[_]
  not drops_all_capabilities(container)
  msg := sprintf("%s containers must drop ALL Linux capabilities.", [input.kind])
}

deny[msg] {
  workload_kind
  spec := podspec
  not valid_seccomp(spec)
  msg := sprintf("%s must use seccompProfile RuntimeDefault or Localhost.", [input.kind])
}

deny[msg] {
  workload_kind
  spec := podspec
  container := spec.containers[_]
  not has_resource_limits(container)
  msg := sprintf("%s containers must set cpu and memory limits.", [input.kind])
}

deny[msg] {
  workload_kind
  spec := podspec
  container := spec.initContainers[_]
  not has_resource_limits(container)
  msg := sprintf("%s containers must set cpu and memory limits.", [input.kind])
}

deny[msg] {
  workload_kind
  spec := podspec
  container := spec.ephemeralContainers[_]
  not has_resource_limits(container)
  msg := sprintf("%s containers must set cpu and memory limits.", [input.kind])
}

deny[msg] {
  workload_kind
  spec := podspec
  spec.hostNetwork == true
  msg := sprintf("%s must not set hostNetwork=true.", [input.kind])
}

deny[msg] {
  workload_kind
  spec := podspec
  spec.hostPID == true
  msg := sprintf("%s must not set hostPID=true.", [input.kind])
}

deny[msg] {
  workload_kind
  spec := podspec
  spec.hostIPC == true
  msg := sprintf("%s must not set hostIPC=true.", [input.kind])
}

deny[msg] {
  workload_kind
  spec := podspec
  some i
  spec.volumes[i].hostPath
  msg := sprintf("%s must not use hostPath volumes.", [input.kind])
}

deny[msg] {
  input.kind == "Service"
  input.spec.type == "LoadBalancer"
  msg := "Service type LoadBalancer is platform-owned; use Ingress + ClusterIP."
}

workload_kind {
  input.kind == "Pod"
}

workload_kind {
  input.kind == "Deployment"
}

workload_kind {
  input.kind == "StatefulSet"
}

workload_kind {
  input.kind == "DaemonSet"
}

workload_kind {
  input.kind == "ReplicaSet"
}

workload_kind {
  input.kind == "Job"
}

workload_kind {
  input.kind == "CronJob"
}

podspec = input.spec {
  input.kind == "Pod"
}

podspec = input.spec.template.spec {
  input.kind == "Deployment"
}

podspec = input.spec.template.spec {
  input.kind == "StatefulSet"
}

podspec = input.spec.template.spec {
  input.kind == "DaemonSet"
}

podspec = input.spec.template.spec {
  input.kind == "ReplicaSet"
}

podspec = input.spec.template.spec {
  input.kind == "Job"
}

podspec = input.spec.jobTemplate.spec.template.spec {
  input.kind == "CronJob"
}

run_as_non_root(spec) {
  spec.securityContext.runAsNonRoot == true
}

run_as_non_root(spec) {
  not missing_container_run_as_non_root(spec)
}

missing_container_run_as_non_root(spec) {
  container := spec.containers[_]
  container.securityContext.runAsNonRoot != true
}

missing_container_run_as_non_root(spec) {
  container := spec.initContainers[_]
  container.securityContext.runAsNonRoot != true
}

missing_container_run_as_non_root(spec) {
  container := spec.ephemeralContainers[_]
  container.securityContext.runAsNonRoot != true
}

drops_all_capabilities(container) {
  container.securityContext.capabilities.drop[_] == "ALL"
}

valid_seccomp(spec) {
  spec.securityContext.seccompProfile.type == "RuntimeDefault"
}

valid_seccomp(spec) {
  spec.securityContext.seccompProfile.type == "Localhost"
}

has_resource_limits(container) {
  container.resources.limits.cpu
  container.resources.limits.memory
}
