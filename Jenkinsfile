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
                sh "cp /var/jenkins_home/workspace/Inventory-Maven/target/InventoryData-1.0.0-SNAPSHOT.zip /var/jenkins_home/workspace/Inventory-poc_feature_pocdemo1" 
            }
        }

        stage("Terraform Init") {
            steps {
                sh 'terraform init'
            }
        }


        stage("Terraform Apply") {
            steps {

                withCredentials([[
                    class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'lara_aws_cred',
                    accessKeyVariable: 'AWS_ACCESS_KEY',
                    secretKeyVariable: 'AWS_SECRET_KEY'
                ]]) {
                sh 'echo $AWS_ACCESS_KEY'
                sh 'echo $AWS_SECRET_KEY'
                }
                
            }
        }
    }
}