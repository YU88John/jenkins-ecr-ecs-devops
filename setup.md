### 1. Clone the repository into your local machine 

`git clone https://github.com/YU88John/vprofile_test.git`

### 2. Launch EC2 instances for Jenkins, SonarQube and Nexus + Configure Security Groups

Instance type: `t2-medium`
AMI: `Amazon Linux2`

In **Advanced Options > userdata**, please copy the user data provided in the userdata folder for each instance respectively. (This will be updated often to accommodate any major releases)
**Note** - If you have decided to do local `SSH`, please create key-pairs for each server.

You will need to open these ports on the security group of each instance. If you want to SSH from local machine, you will need to open port `22` too. However, you can perform this with EC2 instance connect as well.

- Jenkins: `8080, 22`
- SonarQube: `9000`
- Nexus: `8081`

We need to open these ports for browser(UI) access. Each service runs on above-mentioned ports respectively.

### 3. Setup Jenkins 

After Jenkins server is running, try `SSH` it from your local machine via Git Bash or any other unix cli. 
Please ensure Jenkins server is installed with this command: `sudo systemctl status jenkins` 
Once it shows **RUNNING** you are good to go. 
In case if things go wrong and Jenkins server is not up and running, please install it manually using this documentation: https://www.jenkins.io/doc/book/installing/linux/#debianubuntu

Log in to the Jenkins UI with its public IP on port `8080`.
It will show the path where you can get the Administrator password to unlock Jenkins. (`/var/jenkins_home/secrets/initialAdminPassword`).
Copy the path it mentioned, go back to the `SSH` session, and run `sudo cat <PATH_TO_PASSWORD>`

**Required Plugins to install in Jenkins**
- Nexus Artifact Uploader
- SonarQube Scanner
- Build Timestamp
- Pipeline Maven Integration

**For integration with SonarQube**
Under Manage Jenkins - 
Tools > SonarQube Scanner > Install automatically (Please select the latest version, and ensure you remember the name you give)
Configure System > Add SonarQube Server (In the server URL, paste the Private IP of SonarQube instance prefixed by `http://`) 
  - Since we are using the private connection, we need some form of authentication
  - We will add a token for that authentication
  - By this step, I assume you have logged into SonarQube server already. If not, please login with the default credentials. `admin` for both username and password.
  - In SonarQube UI > My account > Tokens > Generate Token (just name it *Jenkins* for classification) Please note the token somewhere safe 
  - Go back to Jenkins UI and add the token as *Secret Text*

We have successfully integrated Jenkins with SonarQube. If you want to ensure, you can test it by creating a pipeline using the code from *JenkinsfileSQ*. After this you will see your project in SonarQube as well as its status - **Passed**. This will also make it easier to associate the Quality Gates to the Jenkins project. 

### 4. Create Quality Gates in SonarQube Scanner 

Code Analysis alone is not enough for production-ready deployment. We need to ensure the source code always meets our desired standards before it proceeds to deployment stage. SonarQube itself has default Quality Gate but **One size never fits all**. For this, we can setup our custom Quality Gates in SonarQube. This is a DevSecOps practice but I will include this in our DevOps pipeline.

Quality Gates > Create 
- We will set the QG on overall code
- The condition will be **Bugs** 
- For operator - Greater than 60

After creating, go to your project > Project Settings > Quality Gate and choose your newly created QG

For the Quality Gate to check the code used in our build, we need to create a webhook for Jenkins server and configure networking.
Project Settings > Create Webhook > URL (`http://<JENKINS_PRIVATE_IP>:8080/sonarqube-webhook`)
Go back to AWS console. Add a new inbound rule in Jenkins Security Group, which allows traffic from SonarQube SG on port `8080`.

Ensure the step by creating a new pipeline with the code provided in *JenkinsfileSQqg*. If the Quality Gate build stage fails, adjust the operator of the Quality Gates based on the results. (eg. If the bugs is 70, increase the operator to a greater value than 70).

### 5. Setup Nexus Artifact repository

Sign in to the Nexus UI using its public IP on port `8081`. Use the default credentials below. (It may ask you to change the password)
`Username: admin` , `Password: admin123`



