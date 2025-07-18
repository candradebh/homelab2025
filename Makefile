.POSIX:
.PHONY: *
.EXPORT_ALL_VARIABLES:

KUBECONFIG = ~/.kube/config
KUBE_CONFIG_PATH = $(KUBECONFIG)

default: k3s cluster-addons execute-in-master

########### CLuster
k3s:
	cd infra/k3s && \
    	ansible-playbook playbooks/site.yml -i ../../inventory.yml

k3s-reset:
	cd infra/k3s && \
		ansible-playbook playbooks/reset.yml -i ../../inventory.yml

k3s-upgrade:
	cd infra/k3s && \
		ansible-playbook playbooks/upgrade.yml -i ../../inventory.yml

k3s-reboot:
	cd infra/k3s && \
	ansible-playbook playbooks/reboot.yml -i ../../inventory.yml

########### Files
copy-project:
	ansible-playbook roles/copy-project.yml -i inventory.yml

wipe-disk:
	ansible-playbook ./infra/roles/copy-project.yml -i inventory.yml

########### Network
cilium:
	ansible-playbook ./roles/cilium.yml -i inventory.yml

########### Util
execute-in-master:
	ansible-playbook ./roles/execute-in-master.yml -i inventory.yml

cluster-addons:
	ansible-playbook ./roles/cluster-addons.yml -i inventory.yml

ssh-root:
	ansible-playbook ./infra/roles/ssh_root.yml -i inventory.yml

docs:
	mkdocs serve


