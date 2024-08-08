pipeline {
    agent any
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
            // Add any cleanup commands here
            docker rmi dirajan/contactlistdemo:${COMMIT_TAG}
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
