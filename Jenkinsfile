pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/your-repo/your-project.git'
        IMAGE_NAME = 'your-docker-image'
        COMMIT_TAG = 'latest'
        K8S_CLUSTER_NAME = 'your-cluster'
        DOCKER_REGISTRY_URL = 'https://index.docker.io/v1/' // Change to your Docker registry URL if different
        DOCKER_REGISTRY_CREDENTIALS_ID = 'dirajan' // Change to your Jenkins credentials ID
    }

    stages {
        stage('Docker Login') {
            steps {
                script {
                    def dockerRegistry = env.DOCKER_REGISTRY_URL
                    withCredentials([usernamePassword(credentialsId: env.DOCKER_REGISTRY_CREDENTIALS_ID, passwordVariable: 'dockerpass', usernameVariable: 'dockeruser')]) {
                        sh "echo $dockerpass | docker login -u $dockeruser --password-stdin $dockerRegistry"
                    }
                }
            }
        }
    }
}
    stages {
        stage('Git Pull and Checkout') {
            steps {
                script {
                    echo 'Pulling the latest code from Git...'
                    git branch: 'main', url: "${env.REPO_URL}"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo 'Building Docker image...'
                    sh 'docker build -t ${IMAGE_NAME}:${COMMIT_TAG} .'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    echo 'Pushing Docker image to repository...'
                    sh 'docker tag ${IMAGE_NAME}:${COMMIT_TAG} your-docker-repo/${IMAGE_NAME}:${COMMIT_TAG}'
                    sh 'docker push your-docker-repo/${IMAGE_NAME}:${COMMIT_TAG}'
                }
            }
        }

        stage('Scan Docker Image') {
            steps {
                script {
                    echo 'Scanning Docker image...'
                    // Add your image scanning tool command here, e.g., Trivy, Clair, etc.
                    // sh 'trivy image your-docker-repo/${IMAGE_NAME}:${COMMIT_TAG}'
                }
            }
        }

        stage('Create K8s Cluster with Ansible') {
            steps {
                script {
                    echo 'Creating Kubernetes cluster with Ansible...'
                    // Add your Ansible playbook command here
                    // sh 'ansible-playbook create-cluster.yml -e cluster_name=${K8S_CLUSTER_NAME}'
                }
            }
        }

        stage('Deploy Application with Helm') {
            steps {
                script {
                    echo 'Deploying application with Helm...'
                    // Add your Helm deployment command here
                    // sh 'helm upgrade --install ${K8S_CLUSTER_NAME} ./helm-chart --set image.repository=your-docker-repo/${IMAGE_NAME},image.tag=${COMMIT_TAG}'
                }
            }
        }

        stage('Functional Test') {
            steps {
                script {
                    echo 'Performing functional tests...'
                    // Add your functional test commands here
                    // e.g., sh 'curl http://your-app-url/health'
                    echo 'Hello World'
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
            // Add any cleanup commands here
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
