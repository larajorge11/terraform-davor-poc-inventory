pipeline {
    agent any

    environment {
        LAMBDA_INVENTORY_JOB = 'Inventory-Maven'
        ENVIRONMENT = 'dev'
        AWS_ACCESS_KEY_ID     = credentials('aws_access_key_dev')
        AWS_SECRET_ACCESS_KEY = credentials('aws_secret_key_dev')
        REGION = 'eu-west-2'
    }


    stages {
        stage("SCM") {
            steps {
                git branch: 'main',
                credentialsId: 'github_lara',
                url: 'https://github.com/larajorge11/terraform-davor-poc-inventory.git'
            }
        }

        stage("Build_Lambda_Function") {
            steps {
                build job: "${env.LAMBDA_INVENTORY_JOB}"
            }
        }

        stage("Terraform Init") {
            steps {
                sh 'terraform init'
            }
        }

        stage("Terraform Plan") {
            steps {
                sh """
                    #Working with aws credentials of the personal account
                    terraform init -var aws_access_key='"${AWS_ACCESS_KEY_ID}"' \
                    -var aws_secret_key='"${AWS_SECRET_ACCESS_KEY}"' \
                    -var aws_region='${REGION}'
                """
            }
        }

        stage("Terraform Apply") {
            steps {
                sh "pwd"
            }
        }
    }
}