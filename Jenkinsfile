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
                    sh "docker run --rm -v ${env.VOLUME_NAME} -v $(pwd)/jar-file:/jar-file alpine sh -c 'cp -r /volume/* /jar-file/'"
                    
                    // List files to verify
                    sh "ls -l jar-file/"
                }
            }
        }
    }

    post {
        always {
            // Clean up any resources or perform any actions needed after the pipeline
        }
    }
}
