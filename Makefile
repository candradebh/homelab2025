.POSIX:
.PHONY: *
.EXPORT_ALL_VARIABLES:

KUBECONFIG = ~/.kube/config
KUBE_CONFIG_PATH = $(KUBECONFIG)

default: k3s


k3s:
	ansible-playbook ./infra/k3s/playbooks/site.yml -i inventory.yml

k3s-reset:
	ansible-playbook ./infra/k3s/playbooks/reset.yml -i inventory.yml

k3s-upgrade:
	ansible-playbook ./infra/k3s/playbooks/upgrade.yml -i inventory.yml

k3s-reboot:
	ansible-playbook ./infra/k3s/playbooks/reboot.yml -i inventory.yml

docs:
	mkdocs serve


