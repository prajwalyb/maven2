pipeline {
    agent none
    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "Maven"
    }
    environment {
        AWS_ACCOUNT_ID="653709203391"
        AWS_DEFAULT_REGION="us-east-1" 
        IMAGE_REPO_NAME="jenkinspipleine"
        
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
    }
   
    stages {
        
         stage('Logging into AWS ECR') {
            agent any
            steps {
                
                script {
                sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
                }
                 
            }
        }
        stage('Cleanup Workspace') {
            agent any
            steps {
                cleanWs()
                sh """
                echo "Cleaned Up Workspace For Project"
                """
            }
        }
        stage('Build') {
            agent any
            steps {
                // Get some code from a GitHub repository
                git 'https://github.com/anurajbhandari5/microservice.git'

                // Run Maven on a Unix agent.
                sh "mvn -Dmaven.test.failure.ignore=true clean install"

                // To run Maven on a Windows agent, use
                // bat "mvn -Dmaven.test.failure.ignore=true clean package"
            }
        }
        stage('SonarQube analysis') {
            agent any
                 steps{
    withSonarQubeEnv(installationName: 'SonarCloud') { // You can override the credential to be used
      sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.7.0.1746:sonar'
    }
                 }
        }
        stage('Building image') {
        agent any
      steps{
        script {
          dockerImage = docker.build "${IMAGE_REPO_NAME}:${env.BUILD_ID}"
        }
      }
    }
     stage('Pushing to ECR') {
        agent any
     steps{  
         script {
                sh "docker tag ${IMAGE_REPO_NAME}:${env.BUILD_ID} ${REPOSITORY_URI}:${env.BUILD_ID}"
                sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${env.BUILD_ID}"
         }
        }
      }
       //stage ('Kubernetes Deploy') {
       
                //kubernetesDeploy(
                    //configs: 'finaldeploy.yaml',
                    //kubeconfigId: 'K8S',
                    //enableConfigSubstitution: true
                    //)               
        //}
    }
        }
