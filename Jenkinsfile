pipeline {
  agent any

  environment {
    TF_VERSION = "1.6.6"
    TF_BIN = "${WORKSPACE}/.bin/terraform"
  }

  parameters {
    string(name: 'PROJECT_ID', defaultValue: 'intense-reason-458522-h4', description: 'GCP Project ID')
    string(name: 'REGION',     defaultValue: 'us-central1',        description: 'GCP Region')
    booleanParam(name: 'DO_DESTROY', defaultValue: false, description: 'If true, run terraform destroy at the end')
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
        sh 'mkdir -p .bin'
      }
    }

    stage('Install Terraform') {
      steps {
        sh '''
          set -e
          if [ ! -x "$TF_BIN" ]; then
            curl -fsSL https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip -o /tmp/tf.zip
            unzip -o /tmp/tf.zip -d ${WORKSPACE}/.bin
            chmod +x ${WORKSPACE}/.bin/terraform
          fi
          ${TF_BIN} version
        '''
      }
    }

    stage('Terraform Init') {
      steps {
        withCredentials([file(credentialsId: 'gcp-creds', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
          dir('terraform') {
            sh '${TF_BIN} init -input=false'
          }
        }
      }
    }

    stage('Terraform Plan') {
      steps {
        withCredentials([file(credentialsId: 'gcp-creds', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
          dir('terraform') {
            sh '''
              set -e
              ${TF_BIN} validate
              ${TF_BIN} plan -input=false \
                -var "project_id=${PROJECT_ID}" \
                -var "region=${REGION}" \
                -out /tmp/tfplan
            '''
          }
        }
      }
    }

    stage('Approve & Apply') {
      steps {
        script {
          input message: 'Apply Terraform?', ok: 'Apply'
        }
        withCredentials([file(credentialsId: 'gcp-creds', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
          dir('terraform') {
            sh '${TF_BIN} apply -input=false /tmp/tfplan'
          }
        }
      }
    }

    stage('Optional Destroy') {
      when { expression { return params.DO_DESTROY } }
      steps {
        withCredentials([file(credentialsId: 'gcp-creds', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
          dir('terraform') {
            sh '''
              set -e
              ${TF_BIN} destroy -auto-approve \
                -var "project_id=${PROJECT_ID}" \
                -var "region=${REGION}"
            '''
          }
        }
      }
    }
  }
}
