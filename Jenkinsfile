pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Partheeban37/valscanner.git'
            }
        }

        stage('Build Docker Images') {
            steps {
                script {
                    // Build backend image
                    sh 'docker build -t vulnscanner-backend:latest ./backend'
                    // Build frontend image
                    sh 'docker build -t vulnscan-frontend:latest ./frontend'
                }
            }
        }
    }
}
