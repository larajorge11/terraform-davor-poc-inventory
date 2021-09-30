pipeline {
    agent any

    environment {
        GIT_URL="https://github.com/larajorge11/terraform-davor-poc-inventory.git"
        CREDENTIALS_GIT_ID = 'github_lara'
        GIT_BRANCH="poc-csv-rds"
        ENVIRONMENT = 'dev'
        AWS_ACCESS_KEY_ID     = credentials('aws_access_key_dev')
        AWS_SECRET_ACCESS_KEY = credentials('aws_secret_key_dev')
        REGION = 'eu-west-2'
    }

    stages {
        stage("Parameters") {
            steps {
                script {
                    properties([
                        parameters([
                            booleanParam(
                                defaultValue: false, 
                                description: '', 
                                name: 'Parameter_Terraform_Destroy'
                            )
                        ])
                    ])
                }
            }
        }

        stage("SCM") {
            when {
                expression {
                    params.Parameter_Terraform_Destroy == false
                }
            }
            steps {
                git branch: "${GIT_BRANCH}",
                credentialsId: "${CREDENTIALS_GIT_ID}",
                url: "${GIT_URL}"
            }
        }

        stage("Terraform Init") {
            steps {
                sh "terraform init -input=false"
            }
        }

        stage("Terraform Apply") {
            when {
                expression {
                    params.Parameter_Terraform_Destroy == false
                }
            }
            steps {
                withAWS(credentials: 'aws_davor_credentials', region: "${REGION}") {
                    sh 'echo "hello Jenkins">hello.txt'
                    s3Upload acl: 'Private', bucket: 'devopslee', file: 'hello.txt'
                    s3Download bucket: 'devopslee', file: 'downloadedHello.txt', path: 'hello.txt'
                    sh 'cat downloadedHello.txt'
                }
            }
            
        }


    }
}