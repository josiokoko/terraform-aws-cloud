pipeline {
    agent any
    environment {
        PATH = "${PATH}:${getTerraformPath()}"
    }

    stages {

        stage("terraform init") {
            steps{
                sh returnStatus: true, script: 'terraform workspace new dev'
                sh "terraform init"
                sh "terraform apply -auto-approve"
            }
        }

         stage("Dev Terraform Apply") {
            steps{
                sh returnStatus: true, script: 'terraform workspace new dev'
                sh "terraform apply -auto-approve"
            }
        }

        stage("Dev Terraform Delete") {
            steps{
                sh returnStatus: true, script: 'terraform workspace new dev'
                sh "terraform destroy -auto-approve"
            }
        }

    }
}


def getTerraformPath(){
    def tfHome =  tool name: 'terraform1.2', type: 'terraform'
    return tfHome
}