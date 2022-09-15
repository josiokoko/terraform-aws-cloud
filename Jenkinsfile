pipeline {
    agent any
    environment {
        PATH = "${PATH}:${getTerraformPath()}"
    }

    stages {

        stage('S3 - create Bucket') {
            steps{
                script{
                    sh "terraform init"
                    createS3Bucket('joe-terraform-09-09')
                }
            }
        }

        stage("Terraform init") {
            steps{
                sh returnStatus: true, script: 'terraform workspace new dev'
                sh "terraform init"
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

def createS3Bucket(bucketName){
    sh returnStatus: true, script: "aws s3 mb ${bucketName} --region=us-east-1"
}