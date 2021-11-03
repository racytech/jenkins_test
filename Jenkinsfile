pipeline {
    agent any

    tools {
        go 'go-1.17.2'
    }

    stages {
        stage('Build') {

            // input {
            //     message "Please enter an Erigon branch you wish to test:"
            //     parameters{
            //         string(name: 'BRANCH', defaultValue: 'devel', description: 'Erigon branch name')
            //     }
            // }

            // steps {
            //     sh './build.sh --branch=$BRANCH'
            // }

            steps {
                echo "Running ${env.BUILD_ID} on ${env.BUILD_NUMBER}"
            }
        }

        stage('Restart') { // restart erigon and rpcdaemon if they are running

            // steps{
            //     sh 'sudo ./restart.sh' 
            // }
            steps {
                echo "Running ${env.BUILD_ID} on ${env.BUILD_NUMBER}"
            }
        }

        stage('Test') {
            // steps{
            //     sh './run_tests.sh'
            // }
            steps {
                echo "Running ${env.BUILD_ID} on ${env.BUILD_NUMBER}"
            }
        }

        stage('Deploy') {
            // steps{
            //     sh './deploy.sh'
            // }
            steps {
                echo "Running ${env.BUILD_ID} on ${env.BUILD_NUMBER}"
            }
        }
    }

}
