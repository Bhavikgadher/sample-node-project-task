pipeline {
    agent any

    environment {
        IMAGE_NAME = "sample-node-task-app"
        DOCKERHUB_USER = "bhavikgadher"
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
                sh '''
                docker build -t $DOCKERHUB_USER/$IMAGE_NAME:latest .
                '''
            }
        }

        stage('DockerHub Login') {
            steps {

                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {

                    sh '''
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                    '''
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                sh '''
                docker push $DOCKERHUB_USER/$IMAGE_NAME:latest
                '''
            }
        }

        stage('Remove Existing Container') {
            steps {
                sh '''
                docker rm -f $CONTAINER_NAME || true
                '''
            }
        }

        stage('Remove Old Image') {
            steps {
                sh '''
                docker rmi $DOCKERHUB_USER/$IMAGE_NAME:latest || true
                '''
            }
        }

        stage('Pull Latest Docker Image') {
            steps {
                sh '''
                docker pull $DOCKERHUB_USER/$IMAGE_NAME:latest
                '''
            }
        }

        stage('Run Application Using Docker Compose') {
            steps {
                sh '''
                docker compose down || true
                docker compose up -d
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
