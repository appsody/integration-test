(imagine you're speaking to one developer)
# Open Source Integration Test Implementation for Appsody Cloud Native Tool
## Overview:
A need for an integration test framework arose from the growing features and supported environments for the Appsody Cloud Native CLI tool. The framework used for unit and functional tests did not offer a viable solution for testing containers on Windows systems as well as testing deployments to Kubernetes. An integration test implementation was created using various open source components including BASH Automated Testing System (BATS) and Jenkins which provided the customizations required to create and run an integration test for Appsody. This implementation is applicable to other projects that utilize a CLI. 
## Problem:
Appsody is an open source tool for iteratively developing cloud native applications which can be deployed to Kubernetes environments. It supports multiple operating systems including macOs, Windows 10, Ubuntu and RedHat. The only requirements for running Appsody are an internet connection and a running Docker instance. Appsody has a command line interface (CLI) which provides multiple functions including creating your cloud app, running the app on your local development environment and deploying the app to Kubernetes. Updates to the CLI are provided via new releases which are provided every two weeks. 

Builds for the CLI are validated via functional and unit tests run via a Travis continuous integration (CI) pipeline. In order to verify a candidate release was ready, integration tests were run prior to release. The setup and running of these tests were performed manually mainly due to limitations with Travis. Travis did not support Docker on Windows and did not provide an easy way to verify app deployments to Kubernetes.
## Solution:
Executing the Appsody integration tests was a time consuming, tedious and repetitive process leading to a desire to automate. The automated test implementation needed to verify the CLI commands executed successfully and also be able to launch and manage the execution of the CLI commands across multiple test systems running all the supported operating systems. A graphic summarizing the implementation that was created is below...
![graphic](https://github.com/appsody/integration-test/blob/master/docs/AppsodyIntegrationTest.JPG "Appsody Integration Test Implementation")

A few open source black box test frameworks were investigated and the BASH Automated Testing System (BATS) was chosen. BATS provides an easy way to verify CLI commands run successfully as well as the ability to customize the framework. For example, shell commands in the BATS helper file were written to provide several features. First, the most recent version of the Appsody CLI was built. Second, custom logging for test execution was created. Lastly, several environment variables were created to set up the Kubernetes deployment. A graphic showing the console output after running BATS tests is below...
![graphic](https://github.com/appsody/integration-test/blob/master/docs/BATSOutput.png "Sample BATS output")

An implementation of the BATS framework solved some of the problems discussed earlier. It provided automation to setup and test the latest Appsody CLI along with a way to verify deployments to Kubernetes. BATS is also supported across the same operating systems as Appsody. BATS does not provide a way to manage test execution across multiple test systems. The Jenkins open source technology was used to accomplish this.

Jenkins provides a user interface where jobs can be created to run tests on systems. Since BATS is shell-based it integrates well with Jenkins. Once the connections to the test systems are created and established in Jenkins, the jobs to run the tests are easily created with just a couple shell commands. The graphic below shows the Jenkins user interface with the test systems running tests...
![graphic](https://github.com/appsody/integration-test/blob/master/docs/JenkinsOutput.png "Sample Jenkins output")

The steps below summarize the integration test implementation flow...

Steps:
1. Jenkins job is executed on a test system with a couple simple shell commands
- The Appsody integration test repository is cloned to pull in the latest test cases 
- BATS is run to execute the tests
- Testcase execution status is monitored
2. BATS configures and runs the tests using a shell helper file and shell test files
- The Appsody CLI and stacks repositories are cloned to pull in the latest development code
- The Appsody CLI binary is built
- Configure logging of testcase output
- Environment variable are created to configure the Kubernetes deployment environment
- Integration testcases are executed


## Challenges
The integration test implementation accomplished the main goal of providing a means to automate the execution of integration tests for the Appsody CLI tool but some challenges and limitations remain. One challenge is to be able to use Virtual Machines (VMs)for all the test systems. The linux operating systems, RedHat and Ubuntu, were able to be configured on VMs but Windows and macOs were not. Appsody requires Docker which is a virtualization technology and running docker on a VM is called "nested virtualization" which is not supported by Windows. The current workaround for this issue is to use a Windows laptop as the test system instead of a VM. Another challenge was achieving 100% automation with the implementation. Currently some manual steps are needed to successfully run the integration tests. One of the manual steps is authenticating into the Kubernetes environment on each of the test systems. This is required as the sessions timeout and require new login credentials. Another manual step is checking the logs on the test systems. BATS can be configured to display errors and runtime logs as console output but this can be messy when running many testcases in a single session. Another challenge was working around the BATS looping limitation. Currently BATS does not support looping within a testcase so all the tests using similar commands need to have their own testcase which is cumbersome when updating the test code. 


BATS doesn't allow looping 
VM setup, windows shell setup, windows nested virtualization, local mac was used for jenkins and as a test node
Logs rollup, currently have to check logs on the test systems
Manual setup to work around issues with root owned files and expiring open shift logins
Parallel testcase execution has not been attempted
Containerizing the testcases has not been attempted

## References
[BATS](https://github.com/bats-core/bats-core)
[Appsody Cloud Tool](https://appsody.dev/)
[Appsody Integration Test](https://github.com/appsody/integration-test)
[Jenkins](https://jenkins.io/)