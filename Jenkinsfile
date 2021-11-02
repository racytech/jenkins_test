pipeline {
    agent any

    stages {
        stage('Build') {

            input {
                message "Please enter an Erigon branch you wish to test:"
                parameters{
                    string(name: 'BRANCH', defaultValue: 'devel', description: 'Erigon branch name')
                }
            }

            steps {
                sh './build.sh --branch=$BRANCH'
            }
        }

        stage('Restart') {

            steps{
                sh './restart.sh' // restart erigon and rpcdaemon if they are running
            }
        }

        stage('Test') {
            steps{
                sh './run_tests.sh'
            }
        }

        stage('Deploy') {
            steps{
                sh './deploy.sh'
            }
        }
    }

}
