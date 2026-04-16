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