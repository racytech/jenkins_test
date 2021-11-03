pipeline {
    agent any

    tools {
        go 'go-1.17.2'
    }

    environment {
        now = "${currentBuild.startTimeInMillis}" // timestamp
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
                sh "./build.sh --branch=$BRANCH --buildid=${env.BUILD_ID} --timestamp=$now"
            }

        }

        stage('Restart') { // restart erigon and rpcdaemon if they are running
            steps{
                sh "sudo ./restart.sh --buildid=${env.BUILD_ID} --timestamp=$now" 
            }
        }

        stage('Test') {
            steps{
                sh "./run_tests.sh --buildid=${env.BUILD_ID} --timestamp=$now"
            }
        }

        stage('Deploy') {
            steps{
                sh "./deploy.sh --buildid=${env.BUILD_ID} --timestamp=$now"
            }
        }
    }

}
