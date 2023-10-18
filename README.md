# About the project
This project is derived from Imran Teli's udemy course(DevOps from beginner to advanced). An application source code is pulled from the course repository in order to focus on the construction of CI/CD pipeline rather than on application development.
Below are the steps to setup the environment and test accordingly.

## Prerequisites
1. An AWS account 
2. Basic knowledge of containerization
3. Time commitment

## Technologies 
- Spring
- Maven
- Jenkins
- SonarQube
- Nexus
- Docker
- ECR

### Clone the repository into your local machine 

`git clone https://github.com/YU88John/vprofile_test.git`

### Launch EC2 instances for Jenkins, SonarQube and Nexus 

instance type: t2-medium
In Advanced Options > userdata, please copy the user data provided in the userdata folder for each instance respectively. 



