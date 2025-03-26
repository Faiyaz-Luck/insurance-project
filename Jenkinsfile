pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'faiyazluck/springboot-app:latest'
        SERVER_USER = 'ubuntu'
        SERVER_IP = 'your-ec2-instance-ip'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'master', url: 'https://github.com/Faiyaz-Luck/insurance-project.git'
            }
        }

        stage('Build & Test') {
            steps {
                sh './mvnw clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t $DOCKER_IMAGE ."
            }
        }

        stage('Push Docker Image') {
            steps {
                withDockerRegistry([credentialsId: 'docker-hub-credentials', url: '']) {
                    sh "docker push $DOCKER_IMAGE"
                }
            }
        }

        stage('Deploy to AWS') {
            steps {
                sh "ansible-playbook -i inventory ansible-playbook.yml"
            }
        }
    }
}
