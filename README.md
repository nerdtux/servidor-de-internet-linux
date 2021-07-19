# Servidor de Internet Linux

Automatizar a configuração de um servidor de internet Linux (gateway, firewall, load-balancer, proxy, dhcp) 

![alt text](images/project.png)

# Passo 1 - Instalar Ansible na Minha Máquina Local

### Características da minha máquina local
- Ubuntu 20.04
- Python 3.8.8

### Instalando Ansible
`pip3 install ansible`

Vamos verificar se Ansible está instalado e a versão

`ansible --version`

No meu caso retornou

`ansible [core 2.11.2]`

# Passo 2 - Testar Configuração SSH com o Servidor
`ssh usuário@ip-do-servidor`

Se você conseguir conectar, é tudo o que precisamos saber para o Ansible poder trabalhar

Saia da sessão ssh com `exit`

Caso não queira utilizar senha para conectar via ssh e, ao invés disso, quiser utlizar chave SSH utilize o comando

`ssh-copy-id usuário@ip-do-servidor`

Digite a senha e pronto, nas próximas sessões SSH a senha não será mais solicitada

# Passo 3 - Criar Um Invetário de Máquinas Que Precisamos Aplicar Playbook do Ansible
Crie um diretório que será seu "ambiente" Ansible

`mkdir ~/empresa/ansible`

`cd ~/empresa/ansible`

Crie o arquivo `inventory`

`vim inventory`

Como criamos nosso "ambiente" nesse diretório, podemos editar o `ansible.cfg` para apontar para nosso arquivo de inventório.
