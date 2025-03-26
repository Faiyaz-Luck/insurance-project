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
                git branch: 'main', url: 'https://github.com/Faiyaz-Luck/insurance-project.git'
            }
        }

  stage('Run Tests') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Verify JAR File') {
            steps {
                sh 'ls -l target/'
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
        withCredentials([string(credentialsId: 'ansible-inventory', variable: 'INVENTORY_FILE')]) {
            sh '''
                echo "[webservers]" > inventory
                echo "$INVENTORY_FILE" >> inventory
                export ANSIBLE_HOST_KEY_CHECKING=False
                ansible-playbook -i inventory ansible-playbook.yml
            '''
        }
    }
}
    }
}
