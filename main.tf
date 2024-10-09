module "rg" {
    source      = "./modules/rg"
    name        = "${var.project}-${var.env}-rg-01"
    location    = var.location
    env         = var.env
    project     = var.project
}

module "vnet" {
    source      = "./modules/vnet"
    name        = "${var.project}-${var.env}-vnet-01"
    location    = var.location
    env         = var.env
    project     = var.project
    rg_name     = module.rg.name
    vnet_cidr   = var.vnet_cidr

    depends_on = [
        module.rg
    ] 
}

module "nsg" {
    source      = "./modules/nsg"
    nsg01_name  = "${var.project}-${var.env}-nsg-01"
    nsg02_name  = "${var.project}-${var.env}-nsg-02"
    rg_name     = module.rg.name
    location    = var.location
    env         = var.env
    project     = var.project

    depends_on = [
        module.rg,
        module.vnet
    ]
}

module "subnet" {
    source      = "./modules/subnets"
    vnet_name   = module.vnet.name
    rg_name     = module.rg.name
    sub1_name   = "${var.project}-${var.env}-lx-sub-01"
    sub1_cidr   = var.sub1_cidr
    nsg01_id    = module.nsg.nsg01id
    sub2_name   = "${var.project}-${var.env}-win-sub-02"
    sub2_cidr   = var.sub2_cidr
    nsg02_id    = module.nsg.nsg02id

    depends_on = [
        module.rg,
        module.vnet,
        module.nsg
    ]

}

module "storage" {
    source          = "./modules/storage"
    name            = "${var.project}${var.env}appfilestg01"
    blob1_name      = var.blob1_name
    location        = var.location
    rg_name         = module.rg.name
    tier            = var.tier
    replica_type    = var.replica_type
    project         = var.project
    env             = var.env
    ip_rules        = var.ip_rules
    subnet_ids      = [module.subnet.sub1_id, module.subnet.sub2_id]
    pe01_name       = "${var.project}-${var.env}-blob-pe-01"
    pesub1_id       = module.subnet.sub1_id
    pr_scname       = "${var.project}-${var.env}-prsc"
    pdns_id         = [module.pdns.id]


    depends_on = [
        module.rg,
        module.vnet,
        module.nsg,
        module.subnet,
        module.pdns,
    ]
}

module "pdns" {
    source      = "./modules/pdns"
    name        = "${var.project}${var.env}.com"
    rg_name     = module.rg.name

    depends_on = [
        module.rg,
    ]
}

module "vm" {
  source            = "./modules/vm"
  env               = var.env
  project           = var.project
  rg_name           = module.rg.name
  location          = var.location
  nic01_name        = "${var.project}-${var.env}-vm01-nic-01"
  ipconf1_name      = "${var.project}${var.env}vm01ipconf"
  sub1_id           = module.subnet.sub1_id
  vm01_name         = "${var.project}-${var.env}web01"
  vm01_size         = var.vm01_size
  vm01_publisher    = var.vm01_publisher
  vm01_offer        = var.vm01_offer
  vm01_sku          = var.vm01_sku
  vm01_username     = var.vm01_username
  vm01_userpswd     = var.vm01_userpswd
  nic02_name        = "${var.project}-${var.env}-vm02-nic-01"
  ipconf2_name      = "${var.project}${var.env}vm02ipconf"
  sub2_id           = module.subnet.sub2_id
  vm02_name         = "${var.project}-${var.env}app01"
  vm02_size         = var.vm02_size
  vm02_publisher    = var.vm02_publisher
  vm02_offer        = var.vm02_offer
  vm02_sku          = var.vm02_sku
  vm02_username     = var.vm02_username
  vm02_userpswd     = var.vm02_userpswd

  depends_on = [
        module.rg,
        module.vnet,
        module.nsg,
        module.subnet,
    ]

}
## Test##