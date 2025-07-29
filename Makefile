.POSIX:
.PHONY: *
.EXPORT_ALL_VARIABLES:

KUBECONFIG := $(HOME)/.kube/kubeconfig.yaml
KUBE_CONFIG_PATH := $(KUBECONFIG)

default: k3s configure-cluster system external post-install

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

system:
	make -C system

external:
	make -C external

smoke-test:
	make -C test filter=Smoke

post-install:
	@./scripts/hacks


# TODO maybe there's a better way to manage backup with GitOps?
backup:
	./scripts/backup --action setup --namespace=actualbudget --pvc=actualbudget-data
	./scripts/backup --action setup --namespace=jellyfin --pvc=jellyfin-data

restore:
	./scripts/backup --action restore --namespace=actualbudget --pvc=actualbudget-data
	./scripts/backup --action restore --namespace=jellyfin --pvc=jellyfin-data

test:
	make -C test

docs:
	mkdocs serve

git-hooks:
	pre-commit install


########### Antes de tudo
pre-execute:
	ansible-playbook roles/pre-execute.yml -i inventory.yml

########### Apos o k3s
configure-cluster:
	ansible-playbook ./roles/configure-cluster.yml -i inventory.yml




