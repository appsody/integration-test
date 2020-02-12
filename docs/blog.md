# Open Source Integration Test Implementation for Appsody Cloud Native Tool
## Overview:
A need for an integration test framework arose from the growing features and supported environments of the Appsody Cloud Native Command Line Interface (CLI) tool. The framework used for unit and functional tests did not work well for integration tests as it did not offer a viable solution for testing containers on Windows systems as well as testing deployments to Kubernetes. An integration test implementation was created using various open source components including BASH Automated Testing System (BATS) and Jenkins which provided the customizations required to create and run an integration test for Appsody. This implementation is applicable to other projects that utilize a CLI. 

Appsody is an open source tool for iteratively developing cloud native applications which can be deployed to Kubernetes environments. It supports multiple operating systems including macOS, Windows 10, Ubuntu and RedHat. The only requirements for running Appsody are an internet connection and a running Docker instance. Appsody has a CLI which provides multiple functions including creating your cloud app, running the app on your local development environment and deploying the app to Kubernetes. Updates to the CLI are provided via new releases which are provided every two weeks. 
## Problem:
Builds for the CLI are validated via functional and unit tests run via a Travis Continuous Integration (CI) pipeline. In order to verify candidate release readiness, integration tests are run prior to release. The setup and running of these tests were performed manually mainly due to limitations with Travis. Travis does not support Docker on Windows and does not provide an easy way to verify app deployments to Kubernetes.
## Solution:
Executing the Appsody integration tests was a time consuming, tedious and repetitive process leading to a desire to automate. The automated test implementation needed to verify the CLI commands executed successfully and also be able to launch and manage the execution of the CLI commands across multiple test systems running all the supported operating systems. A graphic summarizing the implementation that was created is below...
![graphic](https://github.com/appsody/integration-test/blob/master/docs/AppsodyIntegrationTest.jpeg "Appsody Integration Test Implementation")

A few open source black-box test frameworks were investigated and the BASH Automated Testing System (BATS) was chosen. BATS provides an easy way to verify CLI commands run successfully as well as the ability to customize the framework. For example, shell commands in the BATS helper file were written to provide several features. First, the most recent version of the Appsody CLI can be built. Second, custom logging for test execution can be created. Lastly, several environment variables can be created to set up the Kubernetes deployment. A graphic showing the console output after running BATS tests is below...
![graphic](https://github.com/appsody/integration-test/blob/master/docs/BATSOutput.png "Sample BATS output")

An implementation of the BATS framework solved some of the problems discussed earlier. It provided automation to setup and test the latest Appsody CLI along with a way to verify deployments to Kubernetes. BATS is also supported across the same operating systems as Appsody. BATS does not provide a way to manage test execution across multiple test systems. The Jenkins open source technology was used to accomplish this.

Jenkins provides a user interface where jobs can be created to run tests on systems. Since BATS is shell-based it integrates well with Jenkins. Once the connections to the test systems are created and established in Jenkins, the jobs to run the tests are easily created with just a couple shell commands. The graphic below shows the Jenkins user interface with the test systems running tests...
![graphic](https://github.com/appsody/integration-test/blob/master/docs/JenkinsOutput.png "Sample Jenkins output")

The steps below summarize the integration test implementation flow...

Steps:
1. A Jenkins job is executed on a test system via simple shell commands
- The Appsody integration test repository is cloned to pull in the latest test cases 
- BATS is run to execute the tests
- Testcase execution status is monitored and reported
2. BATS runs the test setup commands in the helper file
- The Appsody CLI and stacks repositories are cloned to pull in the latest development code
- The Appsody CLI binary is built
- Logging of testcase output is configured
- Environment variable are created to configure the Kubernetes deployment environment
3. BATS executes the integration testcases

## Challenges
The integration test implementation accomplished the main goal of providing a means to automate the execution of integration tests for the Appsody CLI tool but some challenges and limitations remain. One challenge is to be able to use Virtual Machines (VMs) for all the test systems. The linux operating systems, RedHat and Ubuntu, were able to be configured on VMs but Windows and macOs were not. Appsody requires Docker which is a virtualization technology and running docker on a VM is a "nested virtualization" configuration which is not supported by Windows. The current workaround for this issue is to use a Windows laptop as the test system instead of a VM. macOS is not a very popular operating system to install on a VM so a local macOS laptop was used.

Setting up the test systems was also challenging. Along with the operating system and Docker, each system required several additional programs to be installed and configured. Some of these were: git, BATS, Go, BASH, SSH and kubectl. Some of these programs are installed and configured differently depending on the operating system thus adding to the complexity of the solution. 

Another challenge was achieving 100% automation with the implementation. Currently some manual steps are needed to successfully run the integration tests. One of the manual steps is authenticating into the Kubernetes environment on each of the test systems. This is required as the sessions timeout and require new login credentials. Another manual step is checking the logs on the test systems. BATS can be configured to display errors and runtime logs as console output but this can be messy when running many testcases in a single session. 

Lastly, working around the BATS looping limitation was a challenge. BATS does not support looping within a testcase so all the tests using similar commands need to have their own testcase. This is not a major inconvenience until a test needs to be changed. With a change, all the similar tests need to be changed whereas if the tests could be looped, just the single loop would need to be updated.

## References
[BATS](https://github.com/bats-core/bats-core)
[Appsody Cloud Tool](https://appsody.dev/)
[Appsody Integration Test](https://github.com/appsody/integration-test)
[Jenkins](https://jenkins.io/)