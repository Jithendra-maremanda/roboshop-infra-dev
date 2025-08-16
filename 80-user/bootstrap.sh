#!/bin/bash

component=$1
dnf install ansible -y
ansible-pull -U https://github.com/Jithendra-maremanda/ansible-roboshop-roles-terraform.git -e component=$1 -e env=$2 main.yaml