pipeline {
  agent any

  environment {
    AWS_REGION = "us-east-1"
  }

  stages {

    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Set Environment') {
      steps {
        script {
          if (env.BRANCH_NAME == 'dev') {
            env.ENV_NAME = 'dev'
            env.AUTO_APPLY = 'true'
          }
          else if (env.BRANCH_NAME == 'qa') {
            env.ENV_NAME = 'qa'
            env.AUTO_APPLY = 'false'
          }
          else if (env.BRANCH_NAME == 'prod' || env.BRANCH_NAME == 'main') {
            env.ENV_NAME = 'prod'
            env.AUTO_APPLY = 'false'
          }
          else {
            env.ENV_NAME = 'none'
          }
        }
      }
    }

    stage('Terraform Init') {
      when {
        expression { env.ENV_NAME != 'none' }
      }
      steps {
        sh "terraform init -backend-config=backend/${env.ENV_NAME}.tfbackend"
      }
    }

    stage('Terraform Validate') {
      when {
        expression { env.ENV_NAME != 'none' }
      }
      steps {
        sh 'terraform validate'
      }
    }

    stage('Terraform Plan') {
      when {
        expression { env.ENV_NAME != 'none' }
      }
      steps {
        sh "terraform plan -var-file=env/${env.ENV_NAME}.tfvars"
      }
    }

    stage('Terraform Apply') {
      when {
        expression { env.ENV_NAME != 'none' }
      }
      steps {
        script {
          if (env.AUTO_APPLY == 'true') {
            echo "Auto apply enabled for DEV"
            sh "terraform apply -auto-approve -var-file=env/${env.ENV_NAME}.tfvars"
          } else {
            input message: "Approve deployment to ${env.ENV_NAME}?"
            sh "terraform apply -auto-approve -var-file=env/${env.ENV_NAME}.tfvars"
          }
        }
      }
    }
  }
}
