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
        sh "terraform init -backend-config=backend.tf"
      }
    }

    stage('Terraform Validate') {
      steps {
        sh "terraform validate"
      }
    }

    stage('Terraform Plan') {
      steps {
        sh "terraform plan -var-file=env/qa.tfvars"
      }
    }

    stage('Terraform Apply') {
      steps {
        input message: "Approve deployment to QA?"
        sh "terraform apply -auto-approve -var-file=env/qa.tfvars"
      }
    }
  }
}
