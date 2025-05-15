# Makefile for OpenNebula setup with oneadmin automation

GITHUB_DIR := /home/bajuna/bioprojects/opennebula_learning/github
PROJECT_DIR := $(GITHUB_DIR)/opennebula-k8s-ngs-pipeline
TARGET_DIR := /var/lib/one/project

.PHONY: help permissions copy-onefiles create-network create-vm-template all

help:
	@echo "Available targets:"
	@echo "  make permissions       - Set read/execute permissions for oneadmin"
	@echo "  make copy-onefiles     - Copy .one files to /var/lib/one/project"
	@echo "  make create-network    - Run onevnet create as oneadmin"
	@echo "  make create-vm-template- Run onevmtemplate create as oneadmin"
	@echo "  make all               - Do all of the above in sequence"

permissions:
	@echo "Setting directory permissions..."
	sudo chmod o+rx $(GITHUB_DIR)
	sudo chmod -R o+rx $(PROJECT_DIR)

copy-onefiles:
	@echo "Copying .one files to /var/lib/one/project..."
	sudo mkdir -p $(TARGET_DIR)
	sudo cp $(PROJECT_DIR)/opennebula/*.one $(TARGET_DIR)/
	sudo chown -R oneadmin:oneadmin $(TARGET_DIR)

create-network:
	@echo "Creating virtual network as oneadmin..."
	sudo -u oneadmin onevnet create $(TARGET_DIR)/macvlan-net.one

create-vm-template:
	@echo "Creating VM template as oneadmin..."
	sudo -u oneadmin onetemplate create $(TARGET_DIR)/vm-template.one

all: permissions copy-onefiles create-network create-vm-template
