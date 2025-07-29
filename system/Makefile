.POSIX:

export KUBECONFIG = $(HOME)/.kube/kubeconfig.yaml

.PHONY: bootstrap
bootstrap:
	ansible-playbook \
		bootstrap.yml
