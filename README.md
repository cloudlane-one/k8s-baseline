# k8s-baseline

production-ready, provider-independent &amp; easily manageable k8s cluster setup

## How to bootstrap on bare linux hosts

### Install binary dependencies

These are to be installed on your local machine.

- [Python](https://www.python.org/downloads/)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html)

### Install Ansible role dependencies

```bash
ansible-galaxy install -r requirements.yaml
```

### Provide configuration

First copy the configuration template file `inventory.template.yaml` to `inventory.yaml`. Then edit the config options in the file to your liking.

### Run the Ansible playbook

```bash
ansible-playbook ansible/setup.yaml -i inventory.yaml
```
