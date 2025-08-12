pipeline {
    agent any

    environment {
        DOCKER_HUB_USER = credentials('dockerhub-user')
        DOCKER_HUB_PASS = credentials('dockerhub-pass')
        IMAGE_NAME = "yourdockerhubusername/php-docker-app"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/your/repo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t $IMAGE_NAME:${BUILD_NUMBER} ."
            }
        }

        stage('Login to Docker Hub') {
            steps {
                sh "echo '$DOCKER_HUB_PASS' | docker login -u '$DOCKER_HUB_USER' --password-stdin"
            }
        }

        stage('Push Docker Image') {
            steps {
                sh """
                docker push $IMAGE_NAME:${BUILD_NUMBER}
                docker tag $IMAGE_NAME:${BUILD_NUMBER} $IMAGE_NAME:latest
                docker push $IMAGE_NAME:latest
                """
            }
        }

        stage('Deploy') {
            steps {
                sh """
                docker stop php-docker-app || true
                docker rm php-docker-app || true
                docker run -d --name php-docker-app -p 8080:80 $IMAGE_NAME:latest
                """
            }
        }
    }

    post {
        always {
            sh 'docker logout'
        }
    }
}
