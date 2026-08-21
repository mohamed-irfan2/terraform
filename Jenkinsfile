pipeline {

    agent any

    environment {
        TF_VERSION = '1.13.3'
        PATH = "${WORKSPACE}:${env.PATH}"
    }

    stages {

         stage('Install Terraform') {
            steps {
                sh '''
                    curl -fsSL \
                    https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip \
                    -o terraform.zip

                    unzip -o terraform.zip

                    chmod +x terraform

                    terraform version
                '''
            }
        }

        stage('Terraform Version') {
            steps {
                sh 'terraform version'
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding',
                     credentialsId: 'aws_creds']
                ]) {
                    sh '''
                        terraform init
                    '''
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                sh '''
                    terraform validate
                '''
            }
        }

        stage('Terraform Plan') {
            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding',
                     credentialsId: 'aws_creds']
                ]) {
                    sh '''
                        terraform plan -out=tfplan
                    '''
                }
            }
        }

        // stage('Approval') {
        //     steps {
        //         input message: 'Terraform plan completed. Do you want to apply?', \
        //               ok: 'Apply Terraform'
        //     }
        // }

        stage('Terraform Apply') {
            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding',
                     credentialsId: 'aws_creds']
                ]) {
                    sh '''
                        terraform apply --auto-approve tfplan
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Terraform deployment completed successfully.'
        }

        failure {
            echo 'Terraform deployment failed.'
        }

        always {
            echo 'Terraform pipeline completed.'
        }
    }
}