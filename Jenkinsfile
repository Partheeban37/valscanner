pipeline {
    agent any

    environment {
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

        stage('Cleanup Old Containers') {
            steps {
                script {
                    // Remove any old vulnscan containers to avoid port conflicts
                    sh 'docker ps -aq --filter "name=vulnscan" | xargs -r docker rm -f || true'
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
    }
}
