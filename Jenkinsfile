pipeline {
    agent any

    environment {
        DOCKER_HUB_USER = credentials('dockerhub-user')
        DOCKER_HUB_PASS = credentials('dockerhub-pass')
        IMAGE_NAME = "anestesia01/filiz-php"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Feruza-M/php-docker-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t $IMAGE_NAME:${BUILD_NUMBER} ."
            }
        }

        stage('Login to Docker Hub') {
            steps {
                sh "docker login -u '$DOCKER_HUB_USER' -p '$DOCKER_HUB_PASS'"
            }
        }

        stage('Push Docker Image') {
            steps {
                sh """
                docker build -t $IMAGE_NAME:${BUILD_NUMBER} .
                docker push $IMAGE_NAME:${BUILD_NUMBER}
                """
            }
        }

        stage('Deploy') {
            steps {
                sh """
                docker stop php-docker-app || true
                docker rm php-docker-app || true
                docker run -d --name php-docker-app -p 8082:80 $IMAGE_NAME:${BUILD_NUMBER}
                """
            }
        }
    }

}
