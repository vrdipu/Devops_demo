pipeline {
    agent any

    environment {
        DOCKER_USER = 'dockeruser'
        DOCKER_PASS = 'dockerpass'
        COMMIT_TAG = 'latest'
    }

    stages {
        stage('Docker Login') {
            steps {
                script {
                    echo 'Logging into Docker...'
                    sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo 'Building Docker image...'
                    sh 'docker build -t contactlistdemo:${COMMIT_TAG} .'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    echo 'Pushing Docker image to repository...'
                    sh 'docker tag contactlistdemo:${COMMIT_TAG} dirajan/contactlistdemo:${COMMIT_TAG}'
                    sh 'docker push dirajan/contactlistdemo:${COMMIT_TAG}'
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
            script {
                sh 'docker rmi dirajan/contactlistdemo:${COMMIT_TAG} || true'
            }
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
