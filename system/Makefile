.POSIX:

export KUBECONFIG = $(shell pwd)/../kubeconfig-homelab.yaml

.PHONY: bootstrap
bootstrap:
	ansible-playbook \
		bootstrap.yml
