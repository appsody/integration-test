# integration-test
## Integration Testing with BATS (Bash Automated Testing System)
### Prereqs:
#### macOS
1. install go:
    - `brew install go`
1. install bats:
    - `brew install bats-core`
#### RHEL
1. install go:
    - https://golang.org/doc/install
    - download the tarball
    - `sudo tar -C /usr/local -xzf go1.13.4.linux-amd64.tar.gz`
    - `export PATH=$PATH:/usr/local/go/bin`
    - add this to the bottom of /etc/profile: `sudo vi /etc/profile`
    - reboot
1. install bats:
    - see: https://github.com/bats-core/bats-core
    - `git clone https://github.com/bats-core/bats-core.git`
    - `cd bats-core`
    - `sudo ./install.sh /usr/local`
#### Ubuntu
1. install go:
    - `sudo snap install go --classic`
1. install make:
    - `sudo apt install make`
1. install bats:
    - see: https://github.com/bats-core/bats-core
    - `git clone https://github.com/bats-core/bats-core.git`
    - `cd bats-core`
    - `sudo ./install.sh /usr/local`
#### Windows
1. install go
1. install make
1. install git
1. install bats (from git bash):
    - see: https://github.com/bats-core/bats-core
    - `git clone https://github.com/bats-core/bats-core.git`
    - `cd bats-core`
    - `sudo ./install.sh /usr/local`
1. run bats tests from git bash
### Usage
- Syntax: `bats <.bats test>
- Example: `bats gold_mac_tests.bats`