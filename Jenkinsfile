pipeline {
    agent any

    environment {
        LAMBDA_INVENTORY_JOB = 'Inventory-Maven'
        ENVIRONMENT = 'dev'
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
                sh 'terraform plan -var-file="dev.tfvars"'
            }
        }
    }
}