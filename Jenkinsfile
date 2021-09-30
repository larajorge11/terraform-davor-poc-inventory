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
                git branch: 'poc-csv-rds',
                credentialsId: 'github_lara',
                url: 'https://github.com/larajorge11/terraform-davor-poc-inventory.git'
            }
        }

        stage("Terraform Init") {
            steps {
                sh """echo ${AWS_ACCESS_KEY_ID}"""
            }
        }


    }
}