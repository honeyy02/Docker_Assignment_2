pipeline {
    agent any

    environment {
        VOLUME_NAME = 'my-volume'
    }

    stages {
        stage('Create a local dir') {
            steps {
                sh 'mkdir -p jar-file'
            }
        }

        stage('Path of Volume') {
            steps {
                script {
                    // Inspect the Docker volume
                    def volumeInspectOutput = sh(script: "docker volume inspect ${env.VOLUME_NAME}", returnStdout: true).trim()
                    echo "Volume inspect output: ${volumeInspectOutput}"

                    // Extract the mount point from the volume inspect output
                    def volumePath = sh(script: "echo '${volumeInspectOutput}' | jq -r '.[0].Mountpoint'", returnStdout: true).trim()
                    echo "Volume Path: ${volumePath}"

                    // Set the volume path as an environment variable
                    env.VOLUME_PATH = volumePath
                }
            }
        }

        stage('Copy the volume content to jar-file') {
            steps {
                script {
                    // Use a temporary container to access the volume and copy files
                    sh """
                        docker run --rm -v ${env.VOLUME_NAME}:/volume -v \$(pwd)/jar-file:/jar-file alpine sh -c 'cp -r /volume/* /jar-file/'
                    """
                    // List files to verify
                    sh "ls -l jar-file/"
                }
            }
        }
        stage("Build the docker image"){
            steps{
                script{
                    sh 'docker build -t assignment2 .'
                }
            }
        }
        stage("Stop and Remove the container"){
            steps{
                script{
                    sh 'docker stop assignment2 || true'
                    sh 'docker rm assignment2 || true'
                }
            }
        }
        stage("Run the container"){
            steps{
                script{
                    sh 'docker run --name assignment2 -d -d 8082:8080 my-app'
                }
            }
        }
    }
    post{
        always{
            cleanWs()
        }
    }

    
}
