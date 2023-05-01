pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'my-app'
    }

    tools {
        nodejs "nodejs-version"
    }

    stages {
        stage('Clone git repository') {
            steps {
                checkout scm
            }
        }
        stage('Install Dependencies') {
            steps {
                node('nodejs-version') {
                    sh 'npm install'
                }
            }
        }
        stage('Build') {
            steps {
                node('nodejs-version') {
                    sh 'npm run build --prod'
                }
            }
        }
        stage('Test') {
            steps {
                sh 'npm run test'
            }
        }
        // stage('Clean Up') {
        //     steps {
        //         sh 'rm -rf node_modules'
        //         sh 'rm -rf src'
        //     }
        // }
        // stage('Deploy') {
        //     steps {
        //         sh 'docker build -t my-angular-app .'
        //         sh 'docker run -d -p 8080:80 my-angular-app'
        //     }
        // }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:${BUILD_NUMBER}")
                }
            }
        }
        stage('Deploy to Localhost') {
            steps {
                sh "docker stop ${DOCKER_IMAGE} || true"
                sh "docker rm ${DOCKER_IMAGE} || true"
                sh "docker run -d --name ${DOCKER_IMAGE} -p 80:80 ${DOCKER_IMAGE}:${BUILD_NUMBER}"
            }
        }
        stage('Push Docker Image to Registry') {
            steps {
                script {
                    docker.withRegistry('https://hub.docker.com/repository/docker/kitsuneyoshino/angular-app/general', 'f98dbdcd-0f3d-4a7c-b629-6ca6bb8d1b6e') {
                        dockerImagePush("${DOCKER_IMAGE}:${BUILD_NUMBER}")
                        dockerImagePush("${DOCKER_IMAGE}:latest")
                    }
                }
            }
        }
    }
}
