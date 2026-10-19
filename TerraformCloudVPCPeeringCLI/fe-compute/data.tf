data "tfe_outputs" "fe_network" {
  organization = "aungcloud-tfc"
  workspace    = "fe-network-ws"
}

data "tfe_outputs" "fe_security" {
  organization = "aungcloud-tfc"
  workspace    = "fe-security-ws"
}