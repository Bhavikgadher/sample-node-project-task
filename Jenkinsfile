pipeline {
    agent any

    environment {
        IMAGE_NAME = "sample-node-task-app"
        CONTAINER_NAME = "node-container"
        APP_PORT = "3000"
    }

    stages {

        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }

        stage('Clone Repository') {
            steps {
                git branch: 'dev',
                url: 'https://github.com/Bhavikgadher/sample-node-project-task.git'
            }
        }

        stage('Verify Docker Installation') {
            steps {
                sh 'docker --version'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Remove Existing Container') {
            steps {
                sh '''
                docker rm -f $CONTAINER_NAME || true
                '''
            }
        }

        stage('Run Docker Container') {
            steps {
                sh '''
                docker run -d \
                -p $APP_PORT:$APP_PORT \
                --name $CONTAINER_NAME \
                $IMAGE_NAME
                '''
            }
        }

        stage('Verify Running Container') {
            steps {
                sh 'docker ps'
            }
        }
    }

    post {

        success {
            echo 'Pipeline executed successfully!'
        }

        failure {
            echo 'Pipeline failed!'
        }

        always {
            echo 'Pipeline execution completed.'
        }
    }
}
