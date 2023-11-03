### 1. Clone the repository into your local machine 

`git clone https://github.com/YU88John/vprofile_test.git`

### Launch EC2 instances for Jenkins, SonarQube and Nexus 

Instance type: t2-medium
AMI: Amazon Linux2
In Advanced Options > userdata, please copy the user data provided in the userdata folder for each instance respectively. (This will be updated every month to accommodate any releases)
**Note** - If you have decided to do local SSH, please create key-pairs for each server.

#### 2. Security Group Configuration
You will need to open these ports on the security group of each instance. If you want to SSH from local machine, you will need to open port `22` too. However, you can perform this with EC2 instance connect as well.

Jenkins: 8080, 22
SonarQube: 9000
Nexus: 8081

We need to open these ports for browser(UI) access. Each service runs on above-mentioned ports respectively.

### 3. Setup Jenkins 

After Jenkins server is running, try SSH it from your local machine via git bash or any other unix cli. 
Please ensure jenkins server is installed with this command: `sudo systemctl status jenkins` 
Once it shows ==RUNNING== you are good to go.
