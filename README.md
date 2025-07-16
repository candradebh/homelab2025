## Homelab2025

Automação e gerenciamento do meu homelab com Kubernetes (K3s) + Ansible + MkDocs.

### Pre requisitos

- Ubuntu ≥ 22 
- Python ≥ 3.8
- Ansible ≥ 2.15
- OpenTofu (terraform)
- Chave SSH com acesso root aos nós do cluster
- Git + Make + OpenSSH

### Como iniciar

#### Preparando a maquina de deployer

```bash 
sudo apt update
sudo apt install -y python3-pip git make ansible openssh-client
pip3 install --upgrade pip
ansible-galaxy install -r infra/k3s/requirements.yml
```

Clone o repositorio na máquina em que vai deployar a aplicação. 

```bash
git clone --recurse-submodules https://github.com/candradebh/homelab2025.git
cd homelab2025
```

#### Altere o arquivo inventory.yml

```yaml
k3s_cluster:
  children:
    server:
      hosts:
        192.168.1.50:
        192.168.1.51:
        192.168.1.52:
    agent:
      hosts:
        192.168.1.53:

  vars:
    ansible_user: root
    ansible_ssh_private_key_file: ~/.ssh/id_ed25519
    k3s_version: v1.30.2+k3s1
    token: "SEU_TOKEN_SEGREDO_AQUI"

```
#### Criando o cluster kubernets

```bash
ansible -i inventory.yml all -m ping

make k3s

```