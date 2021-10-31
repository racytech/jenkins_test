pipleline {
    agent any

    environment {
        MY_VAR = 'this should be printed by python script'
    }

    stages {
        stage('Build') { 
            steps {
                sh './py_script.py'
            }
        }

        stage('Test') {
            steps{
                sh './py_test.py'
            }
        }

        stage('Deploy') {
            steps{
                sh './deploy.sh'
            }
        }
    }

}