data "tfe_outputs" "be_network" {
  organization = "aungcloud-tfc"
  workspace    = "be-network-ws"
}

data "tfe_outputs" "be_security" {
  organization = "aungcloud-tfc"
  workspace    = "be-security-ws"
}