## Development of Appsody as a standalone project has ended, but the core technologies of Appsody have been merged with odo to create odo 2.0! See our [blog post](https://appsody.dev/blogs/DevelopmentEnded) for more details!

# integration-test
## Integration Testing with BATS (Bash Automated Testing System)
### Workarounds:
Before running the integration tests:
- `sudo rm -rf ~/.appsody/stacks`
- `sudo rm -rf ~/bats_temp/temp`
- `sudo rm -rf ~/.m2`
- `docker system prune`
- log into the openshift ui as kubeadmin and then in the top right corner click the kube:admin and then `Copy Login command` and then run the oc login command provided
- `oc project <project name>`
- `docker login -u admin -p $(oc whoami -t) default-route-openshift-image-registry.apps.appsodyopenshift42.os.fyre.ibm.com`
### Prereqs:
#### macOS
1. install go:
    - `brew install go`
1. install bats:
    - `brew install bats-core`
1. install util-linux to get `setpid` command
    - `brew install util-linux`
    - `echo 'export PATH="/usr/local/opt/util-linux/bin:$PATH"' >> ~/.bash_profile`
    - `echo 'export PATH="/usr/local/opt/util-linux/sbin:$PATH"' >> ~/.bash_profile`
1. install coreutils to get `timeout` command
    - `brew install coreutils`
#### RHEL
1. install go:
    - https://golang.org/doc/install
    - download the tarball
    - `sudo tar -C /usr/local -xzf go1.13.4.linux-amd64.tar.gz`
    -  add this to the bottom of /etc/profile: `sudo vi /etc/profile`
        - `export PATH=$PATH:/usr/local/go/bin`
    - log out/in
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
    - `./install.sh $HOME`
1. run bats tests from git bash
### General Usage
- Syntax: `bats <.bats test>
- Example: `bats gold_mac_tests.bats`
### Jenkins Usage
See [Jenkins](https://github.com/appsody/integration-test/blob/master/docs/JENKINS.md)
### Debug Tips
1. Rerun the test locally
1. Check repo issues for existing problems/bugs
1. Perform the workaround steps and retry the test run
1. Try the test on a different OS
