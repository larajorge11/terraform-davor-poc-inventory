pipeline {
    agent any

    environment {
        GIT_URL="https://github.com/larajorge11/terraform-davor-poc-inventory.git"
        CREDENTIALS_GIT_ID = 'github_lara'
        GIT_BRANCH="feature/pocdemo1"
        LAMBDA_INVENTORY_JOB = 'Inventory-Maven'
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
                            choice(
                                choices: ['ONE', 'TWO'], 
                                name: 'PARAMETER_01'
                            ),
                            booleanParam(
                                defaultValue: true, 
                                description: '', 
                                name: 'BOOLEAN'
                            ),
                            text(
                                defaultValue: '''
                                this is a multi-line 
                                string parameter example
                                ''', 
                                 name: 'MULTI-LINE-STRING'
                            ),
                            string(
                                defaultValue: 'scriptcrunch', 
                                name: 'STRING-PARAMETER', 
                                trim: true
                            )
                        ])
                    ])
                }
            }
        }

        stage("SCM") {
            when {
                expression {
                    params.Destroy == false
                }
            }
            steps {
                git branch: "${GIT_BRANCH}",
                credentialsId: "${CREDENTIALS_GIT_ID}",
                url: "${GIT_URL}"
            }
        }

        stage("Build_Lambda_Function") {
            when {
                expression {
                    params.Destroy == false
                }
            }
            steps {
                build job: "${env.LAMBDA_INVENTORY_JOB}"
                sh "cp /var/jenkins_home/workspace/Inventory-Maven/target/InventoryData-1.0.0-SNAPSHOT.zip /var/jenkins_home/workspace/Inventory-poc_feature_pocdemo1" 
            }
        }

        stage("Terraform plan") {
            when {
                expression {
                    params.Destroy == false
                }
            }
            steps {
                sh """
                    #Working with aws credentials of the personal account
                    terraform plan -var aws_access_key='${AWS_ACCESS_KEY_ID}' \
                    -var aws_secret_key='${AWS_SECRET_ACCESS_KEY}' \
                    -var aws_region='${REGION}'
                """
            }
        }


        stage("Terraform Apply") {
            when {
                expression {
                    params.Destroy == false
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

        stage("Terraform Destroy") {
            when {
                expression {
                    params.Destroy == true
                }
            }
            steps {
                sh """
                    echo 'Hello Davor'

                """
            }

        }
    }
}