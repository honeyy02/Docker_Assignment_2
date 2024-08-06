pipeline{
    agent any
    environment{
        VOLUME_NAME = 'my-volume'
         DOCKER_IMAGE = 'alpine'
    }
    stages{
        stage("Create a local dir"){
            steps{
                sh 'mkdir jar-file'
            }
        }
        stage("Path of Volume"){
            steps{
                script{
                     def VolumeInspectOutput = sh(script:" docker volume inspect ${VOLUME_NAME}",returnStdout:true).trim()
                echo "Volume inspect output ${volumeInspectOutput}"
                def VolumePath = sh(script:"echo '${VolumeInspectOutput}' | jq -r .[0].Mountpoint", returnStdout : true).trim()
                echo "Volume Path : ${VolumePath}"
                env.VOLUME_PATH = VolumePath 
                }
               
            }
        }
        stage("Copy the volume content to jar-file"){
            steps{
                 script {
                    // Use a temporary container to access the volume and copy files
                    sh """
                        docker run --rm \
                            -v ${VOLUME_NAME}:/volume \
                            -v $(pwd)/jar-file:/jar-file \
                            ${DOCKER_IMAGE} \
                            sh -c "cp -r /volume/* /jar-file/"
                    """
                    
                    // List files to verify
                    sh "ls -l jar-file/"
                }
        }
    }
    }
}
