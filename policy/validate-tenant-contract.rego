package main

deny[msg] {
  contract := tenant_contract
  contract.tenantSlug == ""
  msg := "homelab-tenant.yaml must set tenantSlug."
}

deny[msg] {
  contract := tenant_contract
  contract.renderPath == ""
  msg := "homelab-tenant.yaml must set renderPath."
}

deny[msg] {
  contract := tenant_contract
  contract.ingressClass == ""
  msg := "homelab-tenant.yaml must set ingressClass."
}

deny[msg] {
  contract := tenant_contract
  contract.ingressHost != ""
  input.kind == "Ingress"
  not ingress_has_contract_host(input, contract.ingressHost)
  msg := sprintf("Ingress %s must include ingressHost %s from homelab-tenant.yaml.", [input.metadata.name, contract.ingressHost])
}

ingress_has_contract_host(ingress, host) {
  ingress.spec.rules[_].host == host
}

ingress_has_contract_host(ingress, host) {
  ingress.spec.tls[_].hosts[_] == host
}

tenant_contract = c {
  c := data["homelab-tenant"]
}
