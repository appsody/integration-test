# Jenkins
## admin UI install and setup for macOS
* brew install jenkins-lts
    * Note: When using launchctl the port will be 8080. You can launch with --httpPort=7070 to change the port
    * To have launchd start jenkins-lts now and restart at login:  brew services start jenkins-ltsOr, if you don't want/need a background service you can just run:  jenkins-lts
* jenkins-lts -> launches jenkins and gives you the initial admin password. You can launch with --httpPort=7070 to change the port
* localhost:8080 brings up the ui
* selected all the ssh plugins
* admin user:
    * jenkinstest
## Ubuntu Jenkins test node setup
* users:
    * adduser jenkinstest
    * sudo usermod -aG sudo jenkinstest
* ssh:
    * already had ~/.ssh/id_rsa.pub on mac so just needed to add it to the node...
    * cat .ssh/id_rsa.pub | ssh jenkinstest@(ubuntu ip) 'cat >> .ssh/authorized_keys'
* docker:
    * reference URL: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04
    * sudo apt update
    * sudo apt install apt-transport-https ca-certificates curl software-properties-common
    * curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    * sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
    * sudo apt update
    * apt-cache policy docker-ce
    * sudo apt install docker-ce
    * sudo systemctl status docker
    * sudo usermod -aG docker ${USER}
* appsody:
    * wget https://github.com/appsody/appsody/releases/download/0.5.3/appsody_0.5.3_amd64.deb
    * sudo apt install -f /home/test/Downloads/appsody_0.5.3_amd64.deb
* bash:
    * sudo dpkg-reconfigure dash
        * select no to change system shell from dash to bash
* go:
    * reference URL: https://github.com/golang/go/wiki/Ubuntu
    * sudo add-apt-repository ppa:longsleep/golang-backports
    * sudo apt-get update
    * sudo apt-get install golang-go
* java:
    * sudo apt install openjdk-8-jdk
* make:
    * sudo apt update
    * sudo apt install make
* bats:
    * git clone https://github.com/bats-core/bats-core.git
    * cd bats-core
    * ./install.sh /usr/local
* create test node:
    * Manage Jenkins -> Manage Nodes -> New Node
        * Name: Appsody-Ubutu-Test-Node
        * Remote root directory: /home/jenkinstest
        * Launch method: Launch agent agents via SSH
        * Host: IP of the Ubuntu system/VM
        * Credentials: Add jenkinstest:(password)
* create jenkins job to deploy bats tests on the node:
    * New item -> Name: Ubuntu-BATS -> Freestyle Project -> General
        * check "Restrict where this project can be run" and provide the name of the Jenkins Ubuntu node, ex: Appsody-Ubuntu-Test-Node
        * Build Environment
            * check "Delete workspace before build starts"
        * Build:
            * Execute shell command:
            ```
            git clone https://github.com/appsody/integration-test.git
            bats integration-test/ubuntu/integration_test/integration_tests.bats
            ```
## RHEL Jenkins test node setup
* users:
    * useradd jenkinstest
    * usermod -aG wheel jenkinstest
* docker:
    * sudo yum remove docker docker-common docker-selinux docker-engine
    * sudo yum install yum-utils
    * sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    * sudo yum install docker-ce
    * sudo systemctl enable docker.service
    * sudo systemctl start docker.service
    * sudo usermod -aG docker jenkinstest
* appsody:
    * wget https://github.com/appsody/appsody/releases/download/0.5.3/appsody-0.5.3-1.x86_64.rpm
    * sudo yum install /home/jenkinstest/Downloads/appsody-0.5.3-1.x86_64.rpm
* bats:
    * git clone https://github.com/bats-core/bats-core.git
    * cd bats-core
    * ./install.sh /usr/local
* go:
    * wget https://dl.google.com/go/go1.13.5.linux-amd64.tar.gz
    * sudo tar -C /usr/local -xzf go1.13.5.linux-amd64.tar.gz
    * echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bashrc
* java:
    * sudo yum update
    * sudo yum install java-1.8.0-openjdk-devel
* create test node:
    * Manage Jenkins -> Manage Nodes -> New Node
        * Name: Appsody-RHEL-Test-Node
        * Remote root directory: /home/jenkinstest
        * Launch method: Launch agent agents via SSH
        * Host: IP of the RHEL system/VM
        * Credentials: Add jenkinstest:(password)
* create jenkins job to deploy bats tests on the node:
    * New item -> Name: RHEL-BATS -> Freestyle Project -> General
        * check "Restrict where this project can be run" and provide the name of the Jenkins RHEL node, ex: Appsody-RHEL-Test-Node
        * Build Environment
            * check "Delete workspace before build starts"
        * Build:
            * Execute shell command:
            ```
            git clone https://github.com/appsody/integration-test.git
            bats integration-test/ubuntu/integration_test/integration_tests.bats
            ```
## Windows Jenkins test node setup
* users:
    * create jenkinstest user in Administrators group
* go:
    * reference URL: https://golang.org/doc/install
        * download/install the .msi
* choco:
    * reference URL: https://chocolatey.org/docs/installation
* make:
    * choco install make
* docker:
    * install while logged in as Windows azure id (not jenkinstest)
    * reference URL: https://docs.docker.com/docker-for-windows/install/
        * allow the C drive to be shared with the jenkinstest account (see appsody instructions for Windows Enterprise)
        * got errors starting hyper-v AMD VM:
            * `docker failed to start the virutal machine 'dockerdesktopvm' because one of the hyper-v components is not running`
            * https://github.com/docker/for-win/issues/3577
            * https://github.com/docker/for-win/issues/3597
            * https://github.com/docker/for-win/issues/574
            * https://stackoverflow.com/questions/4037939/
            * looks like nested virtualization is only allow on intel-based VMs not on AMD
* appsody:
    * reference URL: https://appsody.dev/docs/getting-started/installation
* bash/ssh:
    * reference URL: https://superuser.com/questions/1332346/setting-to-use-git-bash-as-default-shell-when-connecting-remotely-via-openssh-to
    * wasn't able to get the authorized_keys to work on the windows client slave but was able to get ssh to work with bash 
* java
    * needed to manually copy the remoting.jar file from another slave node (ubuntu) to get the agent to connect
* create test node:
    * Manage Jenkins -> Manage Nodes -> New Node
        * Name: Appsody-Windows-Test-Node
        * Remote root directory: /c/Users/jenkinstest
        * Launch method: Launch agent agents via SSH
        * Host: IP of the Windows system/VM
        * Credentials: Add jenkinstest:(password)
        * Advanced:
            * java path: /c/java/bin/java
* create jenkins job to deploy bats tests on the node:
    * New item -> Name: Windows-BATS -> Freestyle Project -> General
        * check "Restrict where this project can be run" and provide the name of the Jenkins Windows node, ex: Appsody-Windows-Test-Node
        * Build Environment
            * check "Delete workspace before build starts"
        * Build:
            * Execute shell command:
            ```
            git clone https://github.com/appsody/integration-test.git
            bats integration-test/ubuntu/integration_test/integration_tests.bats
            ```
    * if stuff like "make" isn't found then log into the windows node as jenkinstest and edit the env path to include the directory where its stored (C:\ProgramData\chocolatey\bin). may need to disconnect the node and reconnect it for it to pick up the path changes