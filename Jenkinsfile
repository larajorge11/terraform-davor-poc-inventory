pipeline {
    agent any
    triggers {
        pollSCM "* * * * *"
    }
    stages {
        stage("SCM") {
            steps {
                git branch: 'main',
                credentialsId: 'github_lara',
                url: 'https://github.com/larajorge11/terraform-davor-poc-inventory.git'
            }
        }

        stage("Build") {
            steps {
                sh "mvn -version"
                sh "mvn clean install"
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}