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
                        sudo docker build -t ${registry}:latest .
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
                        sudo docker tag ${registry}:latest ${registry}
                        sudo docker push ${registry}:latest
                    '''
                }
            }
        }
        stage('Trivy SCaning image') {
            steps {
                script {
                    echo 'Trivy Scanning Docker Image ...'
                    sh '''
                        sudo trivy image ${registry}:latest 
                    '''
                }
            }
        }
        stage('Cleaning up') {
            steps {
                script {
                    echo 'Cleaning up...'
                    sh '''
                       sudo  docker rmi ${registry}:latest
                    '''
                }
            }
        }
    
        stage('Get Helm Application') {
            steps {
                script {
                    echo 'Helm Deploying ...'
                    sh '''
                       rm -rf Myargoapp
                       git clone https://github.com/vrdipu/Myargoapp.git
                    '''
                }
            }
        }
    
        stage('Deploy Helm Application') {
            steps {
                script {
                    echo 'Helm Deploying ...'
                    sh '''
                       
                       sh 'helm install demo-app ./Myargoapp --values Myargoapp/values.yaml'
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
        