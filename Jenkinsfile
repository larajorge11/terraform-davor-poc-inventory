pipeline {
    agent any

    environment {
        GIT_URL="https://github.com/larajorge11/terraform-davor-poc-inventory.git"
        CREDENTIALS_GIT_ID = 'github_lara'
        GIT_BRANCH="feature/lambda-layer"
        LAMBDA_INVENTORY_JOB = 'Inventory-Maven'
        LAMBDA_INVENTORY_LAYER_JOB = 'Inventory-Lambda-Layer'
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

        stage("Build_Lambda_Layer") {
            when {
                expression {
                    params.Parameter_Terraform_Destroy == false
                }
            }
            steps {
                build job: "${env.LAMBDA_INVENTORY_LAYER_JOB}"
                sh 'cp /var/jenkins_home/workspace/Inventory-Lambda-Layer/target/CacheInstanceConnection-1.0.0.zip /var/jenkins_home/workspace/ventory-poc_feature_lambda-layer'
            }
        }

        stage("Build_Lambda_Function") {
            when {
                expression {
                    params.Parameter_Terraform_Destroy == false
                }
            }
            steps {
                build job: "${env.LAMBDA_INVENTORY_JOB}"
                sh 'cp /var/jenkins_home/workspace/Inventory-Maven/target/InventoryData-1.0.0-SNAPSHOT.zip /var/jenkins_home/workspace/ventory-poc_feature_lambda-layer'
            }
        }

        stage("Terraform Init") {
            steps {
                sh 'terraform init'
            }
        }

        stage("Terraform Apply") {
            when {
                expression {
                    params.Parameter_Terraform_Destroy == false
                }
            }
            steps {
                sh """
                    #Working with aws credentials of the personal account
                    cd instance_module
                    if [ ! -d ".ssh" ]
                    then
                        mkdir .ssh
                    fi
                    cd .ssh

                    if [ ! -f "davorkey" ]
                    then
                        ssh-keygen -f davorkey
                    fi
                    cd ../.. 
                    terraform apply -var aws_access_key='${AWS_ACCESS_KEY_ID}' \
                    -var aws_secret_key='${AWS_SECRET_ACCESS_KEY}' \
                    -var aws_region='${REGION}' \
                    -auto-approve
                """
            }
        }

        stage("Terraform Show") {
            steps {
                sh 'terraform show'
            }
        }

        stage("Terraform Destroy") {
            when {
                expression {
                    params.Parameter_Terraform_Destroy == true
                }
            }
            steps {
                sh """
                    terraform destroy -var aws_access_key='${AWS_ACCESS_KEY_ID}' \
                    -var aws_secret_key='${AWS_SECRET_ACCESS_KEY}' \
                    -var aws_region='${REGION}' \
                    -auto-approve

                """
            }

        }
    }
}