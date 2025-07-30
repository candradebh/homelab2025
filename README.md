## Homelab2025

Automação e gerenciamento do meu homelab com Kubernetes (K3s) + Ansible + MkDocs.

### VMS do Cluster
Criar VMS ubuntu 22 e acesso ssh com root, segui esses ips, pois são os da minha rede e já estão estáticos no meu roteador.

BC:24:11:8E:3E:F6 - 192.168.1.50 - kubmaster1
BC:24:11:FB:96:1C - 192.168.1.51 - kubmaster2
BC:24:11:CA:E2:86 - 192.168.1.52 - kubmaster3
BC:24:11:8E:3E:F7 - 192.168.1.53 - kubnode1

- Ubuntu ≥ 22 

- Chave SSH com acesso root aos nós do cluster
- Git + Make + OpenSSH

### SSH Root

```bash
# altere a senha
echo "root:Rapa" | sudo chpasswd

#edite o arquivo
sudo sed -i 's/^#\?\s*PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config
sudo sed -i 's/^#\?\s*PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config

#reinicie o ssh
sudo systemctl restart ssh

```

Agora tem que adicionar a ssh em cada nó

```bash

for ip in 192.168.1.50 192.168.1.51 192.168.1.52 192.168.1.53; do
  echo "➡️ Copiando chave para $ip..."
  ssh-copy-id -i ~/.ssh/id_ed25519.pub root@$ip
done

```

### Como iniciar

#### Preparando a maquina de deployer

```bash 
sudo apt update
sudo apt install -y nix-bin make ansible
pip3 install --upgrade pip
#ansible-galaxy install -r infra/k3s/requirements.yml
```

Clone o repositorio na máquina em que vai deployar a aplicação. 

```bash
git clone --recurse-submodules https://github.com/candradebh/homelab2025.git
cd homelab2025

#ou se ja tiver clonado
git submodule update --init --recursive
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

## Instalar nix
apt install nix-bin



## Terraform




## ARGO
Rodei na mao em kubmaster1 no local onde copio a pasta

Primeira instalação:

helm template argocd ./argocd \
-n argocd \
--include-crds \
-f argocd/values-seed.yaml \
--dependency-update > argocd-render.yaml


Senão: 

helm template argocd ./argocd \
-n argocd \
--include-crds \
-f argocd/values.yaml \
--dependency-update > argocd-render.yaml



Aplicarndo:
kubectl apply --server-side --force-conflicts -f argocd-render.yaml



## testar em deployer o jkubectl
export KUBECONFIG=$HOME/.kube/kubeconfig.yaml
kubectl get nodes


