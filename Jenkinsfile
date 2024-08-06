pipeline{
    agent any
    environment{
        VOLUME_NAME = 'my-volume'
         DOCKER_IMAGE = 'alpine'
    }
    stages{
        stage("Create a local dir"){
            steps{
                sh 'mkdir -p jar-file'
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
                    sh "sudo -i"
                    sh "cp -r ${env.VOLUME_PATH}/* jar-fie/"
                    
                    // List files to verify
                    sh "ls -l jar-file/"
                }
        }
    }
    }
}
