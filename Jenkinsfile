pipeline {

    agent any

    stages {

        stage('Checkout') {
            steps {
                echo 'Source code has been checked out'
            }
        }

        stage('Verify Application') {
            steps {
                sh '''
                    echo "Current user:"
                    whoami

                    echo "Current directory:"
                    pwd

                    echo "Files:"
                    ls -la

                    echo "Application:"
                    ls -la app

                    echo "Content:"
                    cat app/hello.txt
                '''
            }
        }

        stage('Test') {
            steps {
                echo 'Running application tests'
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully'
        }

        failure {
            echo 'Pipeline failed'
        }
    }
}