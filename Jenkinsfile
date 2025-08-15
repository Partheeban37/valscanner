pipeline {
    agent any

    environment {
        // Terraform variables can be passed as environment variables if needed
        DB_HOST = "localhost"
        DB_USER = "vulnuser"
        DB_PASSWORD = "mr.looser37"
        BACKEND_PORT = "5000"
        FRONTEND_PORT = "3000"
    }

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

        stage('Terraform Provisioning') {
            steps {
                script {
                    // Initialize Terraform
                    sh 'terraform init'
                    // Apply Terraform to provision infrastructure
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Stop any existing containers
                    sh 'docker rm -f vulnscanner-backend || true'
                    sh 'docker rm -f vulnscan-frontend || true'

                    // Run backend container with credentials from environment
                    sh """
                    docker run -d \
                    --name vulnscanner-backend \
                    -p ${BACKEND_PORT}:${BACKEND_PORT} \
                    -e DB_HOST=${DB_HOST} \
                    -e DB_USER=${DB_USER} \
                    -e DB_PASSWORD=${DB_PASSWORD} \
                    vulnscanner-backend:latest
                    """

                    // Run frontend container
                    sh """
                    docker run -d \
                    --name vulnscan-frontend \
                    -p ${FRONTEND_PORT}:${FRONTEND_PORT} \
                    vulnscan-frontend:latest
                    """
                }
            }
        }
    }
}
