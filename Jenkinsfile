pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'my-app'
    }

    // tools {
    //     nodejs "nodejs-20"
    //     docker 'Docker'
    // }

    stages {
        stage('Clone git repository') {
            steps {
                checkout scm
            }
        }
        stage('Install Dependencies') {
            steps {
                sh 'npm install'
                // sh 'yarn install'
            }
        }
        stage('Build') {
            steps {
                sh 'npm run build --prod'
            }
        }
        // stage('Test') {
        //     steps {
        //         sh 'npm run test'
        //     }
        // }
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
                    sh 'sudo docker build -t ${DOCKER_IMAGE}:latest .'
                }
            }
        }
        stage('Deploy to Localhost') {
            steps {
                sh "sudo docker stop ${DOCKER_IMAGE} || true"
                sh "sudo docker rm ${DOCKER_IMAGE} || true"
                sh "sudo docker run -d --name ${DOCKER_IMAGE} -p 3000:3000 ${DOCKER_IMAGE}:latest"
            }
        }
        // stage('Push Docker Image to Registry') {
        //     steps {
        //         script {
        //             docker.withRegistry('https://hub.docker.com/repository/docker/kitsuneyoshino/angular-app/general', '334d8347-e87a-4e42-adec-52c84cc39304') {
        //                 dockerImagePush("${DOCKER_IMAGE}:${BUILD_NUMBER}")
        //                 dockerImagePush("${DOCKER_IMAGE}:latest")
        //             }
        //         }
        //     }
        // }
    }
}
