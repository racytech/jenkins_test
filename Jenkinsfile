pipeline {
    agent any

    tools {
        go 'go-1.17.2'
    }

    stages {
        stage('Build') {

            input {
                message "Please enter an Erigon branch you wish to test:"
                parameters{
                    string(name: 'BRANCH', defaultValue: 'devel', description: 'Erigon branch name')
                }
            }

            steps {
                sh "./build.sh --branch=$BRANCH --buildid=${env.BUILD_ID}"
                echo "TimeStamp: ${currentBuild.startTimeInMillis}"
            }

        }

        stage('Restart') { // restart erigon and rpcdaemon if they are running
            steps{
                sh "sudo ./restart.sh --buildid=${env.BUILD_ID}" 
                echo "TimeStamp: ${currentBuild.startTimeInMillis}"
            }
        }

        stage('Test') {
            steps{
                sh "./run_tests.sh --buildid=${env.BUILD_ID}"
                echo "TimeStamp: ${currentBuild.startTimeInMillis}"
            }
        }

        stage('Deploy') {
            steps{
                sh "./deploy.sh --buildid=${env.BUILD_ID}"
                echo "TimeStamp: ${currentBuild.startTimeInMillis}"
            }
        }
    }

}
