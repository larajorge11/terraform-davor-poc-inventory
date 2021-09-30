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


    }
}