pipeline {
  agent any

  environment {
    ENV_NAME   = "qa"
    AWS_REGION = "us-east-1"
  }

  stages {

    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Terraform Init') {
      steps {
        withCredentials([
          [$class: 'AmazonWebServicesCredentialsBinding',
           credentialsId: 'aws-terraform']
        ]) {
          sh 'terraform init'
        }
      }
    }

    stage('Terraform Validate') {
      steps {
        sh 'terraform validate'
      }
    }

    stage('Terraform Plan') {
      steps {
        sh 'terraform plan -out=tfplan'
      }
    }

    stage('Terraform Apply') {
      steps {
        input message: "Approve deployment to QA?"
        sh 'terraform apply -auto-approve tfplan'
      }
    }
  }
}
