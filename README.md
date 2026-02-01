# packer-vmware-builds

Automated VMware Workstation Pro image builds defined in YAML. Uses [packer-config-gen](https://github.com/serhii9132/packer-config-gen) to dynamically generate Packer manifests and boot command files from a single source of truth.

### Supported Packer builder:
- [vmware-iso](https://developer.hashicorp.com/packer/integrations/hashicorp/vmware/latest/components/builder/iso#configuration-reference)

### Available OS Images:
- Debian 13.3
- Ubuntu 24.04.3 LTS

### Template details:
- CPU: 2 cores
- Disk: 150 Gb
- Type disk: growable virtual disk contained in a single file
- RAM: 4 Gb
- Partitioning: LVM
- Swap: disabled
- Firmware: EFI
- Network adapter type: vmxnet3
- Preinstalled packages: python3, wget, rsync, bash-completion, open-vm-tools
- User: with sudo privileges is created without password prompt or root
- VNC: 127.0.0.1:5963 with password auth

### Prerequisites:
- [Vagrant](https://developer.hashicorp.com/vagrant)
- [Packer](https://developer.hashicorp.com/packer)
- [VMware Workstation Pro](https://www.vmware.com/products/desktop-hypervisor/workstation-and-fusion)
- [Python 3.13](https://www.python.org/)
- [packer-config-gen](https://pypi.org/project/packer-config-gen/)

## Usage
### 1.Environment setup
Create a .env file in the root of the project with the following content:
```sh
export USERNAME="user"
# Use: mkpasswd -m sha-512
export PASSWORD='$6$vPP.....'

export SSH_PUBLIC_KEY='ssh-ed25519 AAAAbbbbbbbccccccc....'
export SSH_PRIVATE_KEY_FILE="/home/user/.ssh/key"
```

### 2.Configuration generation
To generate build artifacts (HCL and HTTP files), use:
```sh
make ubuntu
make debian
```
After execution, the generated files will appear in the artifacts/${OS_NAME}/ directory and the OS build process will start. Vagrant images will be available at artifacts/${OS_NAME}/builds

### Tested with:
- Packer: v1.14.3
- packer-plugin-vagrant: 1.1.6
- packer-plugin-vmware: 1.2.0
- VMware Workstation Pro: 25H2
- Vagrant: 2.4.9
- vagrant-vmware-desktop: 3.0.5