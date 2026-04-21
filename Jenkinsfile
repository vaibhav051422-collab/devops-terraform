pipeline {
    agent any

    options {
        timestamps()
    } 
    environment {
        AWS_REGION = "ap-south-1"
    }


    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
         stage('Terraform Init') {
            steps {
                dir('Terraform') {
                    sh 'terraform init'
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                dir('Terraform') {
                    sh 'terraform plan'
                }
            }
        }
        
        stage('Terraform Apply'){
            when{
                branch 'main'
            }
            steps {
                dir('Terraform') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }
        

        stage('Install backend') {
            steps {
                dir('backend') {
                    sh 'npm ci --include=dev'
                }
            }
        }

        stage('Smoke test backend') {
            steps {
                dir('backend') {
                    sh '''
                        set -e
                        nohup npm start > backend.log 2>&1 &
                        SERVER_PID=$!
                        trap 'kill $SERVER_PID' EXIT
                        sleep 5
                        curl --fail http://127.0.0.1:3000/
                    '''
                }
            }
        }
    }
}