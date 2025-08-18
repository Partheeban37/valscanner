pipeline {
    agent any

    environment {
        DB_USER     = 'vulnuser'
        DB_PASSWORD = 'vulnpass'
        DB_NAME     = 'vulndb'
        DB_PORT     = '5432'
        BACKEND_PORT = '5000'
        FRONTEND_PORT = '3000'
    }

    stages {
        stage('Clone') {
            steps {
                git branch: 'main', url: 'https://github.com/Partheeban37/valscanner.git'
            }
        }

        stage('Build Backend') {
            steps {
                dir('backend') {
                    sh 'docker build -t vulnscanner-backend:latest .'
                }
            }
        }

        stage('Build Frontend') {
            steps {
                dir('frontend') {
                    sh 'docker build -t vulnscan-frontend:latest .'
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Clean up old containers (ignore errors)
                    sh '''
                    docker rm -f vulnscan-frontend || true
                    docker rm -f vulnscan-backend || true
                    docker rm -f vulnscan-db || true
                    '''

                    // Create a custom network if not exists
                    sh 'docker network create vulnscan-net || true'

                    // Start Postgres
                    sh '''
                    docker run -d --name vulnscan-db \
                      --network vulnscan-net \
                      -e POSTGRES_USER=${DB_USER} \
                      -e POSTGRES_PASSWORD=${DB_PASSWORD} \
                      -e POSTGRES_DB=${DB_NAME} \
                      -p ${DB_PORT}:5432 \
                      postgres:15
                    '''

                    // Wait for Postgres to be ready
                    sh '''
                    for i in {1..10}; do
                      if docker exec vulnscan-db pg_isready -U ${DB_USER}; then
                        echo "✅ Postgres is ready"
                        break
                      fi
                      echo "⏳ Waiting for Postgres..."
                      sleep 5
                    done
                    '''

                    // Start Backend
                    sh '''
                    docker run -d --name vulnscan-backend \
                      --network vulnscan-net \
                      -p ${BACKEND_PORT}:5000 \
                      -e DB_HOST=vulnscan-db \
                      -e DB_PORT=${DB_PORT} \
                      -e DB_NAME=${DB_NAME} \
                      -e DB_USER=${DB_USER} \
                      -e DB_PASSWORD=${DB_PASSWORD} \
                      vulnscanner-backend:latest
                    '''

                    // Start Frontend
                    sh '''
                    docker run -d --name vulnscan-frontend \
                      --network vulnscan-net \
                      -p ${FRONTEND_PORT}:3000 \
                      -e REACT_APP_BACKEND_URL=http://vulnscan-backend:5000 \
                      vulnscan-frontend:latest
                    '''
                }
            }
        }
    }
}
