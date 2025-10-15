.PHONY: tf-init
tf-init:
	cd terraform && terraform init

.PHONY: tf-apply
tf-apply:
	cd terraform && terraform apply -var-file=proxmox.tfvars $(if $(auto),-auto-approve,)

.PHONY: tf-destroy
tf-destroy:
	cd terraform && terraform destroy -var-file=proxmox.tfvars $(if $(auto),-auto-approve,)

.PHONY: tf-plan
tf-plan:
	cd terraform && terraform plan -var-file=proxmox.tfvars
	