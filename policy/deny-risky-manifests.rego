package main

deny[msg] {
  blocked_kinds := {
    "Namespace",
    "ClusterRole",
    "ClusterRoleBinding",
    "CustomResourceDefinition",
    "PersistentVolume",
    "StorageClass",
    "IngressClass"
  }
  blocked_kinds[input.kind]
  msg := sprintf("%s is platform-owned and forbidden in tenant repos.", [input.kind])
}

deny[msg] {
  input.kind == "NetworkPolicy"
  msg := "NetworkPolicy is platform-owned for tenant namespaces in this baseline."
}

deny[msg] {
  input.kind == "Role"
  msg := "Role resources are platform-owned for tenant namespaces in this baseline."
}

deny[msg] {
  input.kind == "RoleBinding"
  msg := "RoleBinding resources are platform-owned for tenant namespaces in this baseline."
}

deny[msg] {
  input.kind == "ResourceQuota"
  msg := "ResourceQuota resources are platform-owned for tenant namespaces in this baseline."
}

deny[msg] {
  input.kind == "LimitRange"
  msg := "LimitRange resources are platform-owned for tenant namespaces in this baseline."
}

deny[msg] {
  spec := podspec
  spec.hostNetwork == true
  msg := "hostNetwork=true is forbidden for tenant workloads."
}

deny[msg] {
  spec := podspec
  spec.hostPID == true
  msg := "hostPID=true is forbidden for tenant workloads."
}

deny[msg] {
  spec := podspec
  spec.hostIPC == true
  msg := "hostIPC=true is forbidden for tenant workloads."
}

deny[msg] {
  spec := podspec
  some i
  spec.volumes[i].hostPath
  msg := "hostPath volumes are forbidden for tenant workloads."
}

deny[msg] {
  spec := podspec
  container := spec.containers[_]
  container.securityContext.privileged == true
  msg := "privileged=true is forbidden for tenant workloads."
}

deny[msg] {
  spec := podspec
  container := spec.initContainers[_]
  container.securityContext.privileged == true
  msg := "privileged=true is forbidden for tenant workloads."
}

deny[msg] {
  spec := podspec
  container := spec.ephemeralContainers[_]
  container.securityContext.privileged == true
  msg := "privileged=true is forbidden for tenant workloads."
}

deny[msg] {
  input.kind == "ConfigMap"
  bytes := configmap_data_bytes
  bytes > 200000
  msg := sprintf("ConfigMap data is too large for Argo annotations safety (%d bytes > 200000).", [bytes])
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

configmap_data_bytes = total {
  values := [v | v := input.data[_]]
  lengths := [count(sprintf("%v", [v])) | v := values[_]]
  total := sum(lengths)
}
