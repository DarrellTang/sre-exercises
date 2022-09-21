module "iam" {
  source = "./modules/iam"

  svc_user_name = var.svc_user_name
}
