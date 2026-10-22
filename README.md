# Лабораторная работа №1: Ansible и Puppet

Автоматизация развертывания веб-приложения на Apache с использованием Ansible и Puppet.

## 📁 Структура проекта

lab1-project/
├── ansible/
│ ├── hosts.ini # Инвентарный файл
│ ├── apache-playbook.yml # Плейбук Ansible
│ └── app/
│ └── index.html # Веб-приложение
├── puppet/
│ ├── manifests/
│ │ ── site.pp # Главный манифест
│ └── modules/
│ └── apache/
│ ├── manifests/
│ │ └── init.pp # Модуль Apache
│ ├── templates/
│ │ ── custom_vhost.erb
│ └── files/
│ └── index.html
── README.md

## 🛠️ Требования

- Ubuntu 20.04/22.04/24.04 (или WSL)
- Ansible >= 2.9
- Puppet >= 6.0
- Apache2

## 🚀 Запуск

### Ansible

```bash
sudo apt update && sudo apt install ansible -y
ansible-playbook -i ansible/hosts.ini ansible/apache-playbook.yml --ask-become-pass
