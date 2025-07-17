.POSIX:
.PHONY: *
.EXPORT_ALL_VARIABLES:

KUBECONFIG = ~/.kube/config
KUBE_CONFIG_PATH = $(KUBECONFIG)

default: k3s cilium

########### CLuster
k3s:
	ansible-playbook ./infra/k3s/playbooks/site.yml -i inventory.yml

k3s-reset:
	ansible-playbook ./infra/k3s/playbooks/reset.yml -i inventory.yml

k3s-upgrade:
	ansible-playbook ./infra/k3s/playbooks/upgrade.yml -i inventory.yml

k3s-reboot:
	ansible-playbook ./infra/k3s/playbooks/reboot.yml -i inventory.yml

########### Files
copy-project:
	ansible-playbook ./infra/roles/copy-project.yml -i inventory.yml

wipe-disk:
	ansible-playbook ./infra/roles/copy-project.yml -i inventory.yml

########### Network
cilium:
	ansible-playbook ./infra/roles/cilium.yml -i inventory.yml


########### Util
helm:
	ansible-playbook ./infra/roles/helm.yml -i inventory.yml

ssh-root:
	ansible-playbook ./infra/roles/ssh_root.yml -i inventory.yml

docs:
	mkdocs serve


