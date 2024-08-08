pipeline {
    environment {
        registry = "dirajan/contactlist"
        registryCredential = 'dockerhub_id'
    }
    agent any
    stages {
        stage('Cloning our Git') {
            steps {
                git url: 'https://github.com/vrdipu/Devops_demo.git', branch: 'main'
            }
        }

        stage('Building our image') {
            steps {
                script {
                    echo 'Building Docker image...'
                    sh '''
                        sudo docker build -t ${registry}:${BUILD_NUMBER} .
                    '''
                }
            }
        }

        stage('Deploy our image') {
            steps {
                script {
                    echo 'Deploying Docker image...'
                    sh '''
                        sudo docker login -u "${DOCKER_USERNAME}" -p "${DOCKER_PASSWORD}"
                        sudo docker tag ${registry}:${BUILD_NUMBER} ${registry}
                        sudo docker push ${registry}:${BUILD_NUMBER}
                    '''
                }
            }
        }
        stage('Trivy SCaning image') {
            steps {
                script {
                    echo 'Trivy Scanning Docker Image ...'
                    sh '''
                        sudo trivy image ${registry}:${BUILD_NUMBER} 
                    '''
                }
            }
        }
        stage('Cleaning up') {
            steps {
                script {
                    echo 'Cleaning up...'
                    sh '''
                       sudo  docker rmi ${registry}:${BUILD_NUMBER}
                    '''
                }
            }
        }
    }
    post {
        always {
            echo 'Pipeline completed.'
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
