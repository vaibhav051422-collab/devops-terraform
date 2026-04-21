pipeline {
    agent any

    options {
        timestamps()
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Debug Pipeline Context') {
            steps {
                echo "Pipeline is executing stages"
                echo "Branch: ${env.BRANCH_NAME}"
                sh 'git rev-parse --short HEAD || true'
                sh 'pwd'
                sh 'ls -la'
            }
        }
    }
}