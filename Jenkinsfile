pipeline{
    agent any
    environment{
        VOLUME_NAME = 'my-volume'
    }
    stages{
        stage("Create a local dir"){
            steps{
                sh 'mkdir -p jar-file'
            }
        }
        stage("Copy the content of volume to jar-file"){
            steps{
                script{
                     def VolumeInspectOutput = sh(script:" docker volume inspect ${VOLUME_NAME}",returnStdout:true).trim()
                echo "Volume inspect output ${VolumeInspectOutput}"
                def VolumePath = sh(script:"echo '${VolumeInspectOutput}' | jq -r .[0].Mountpoint", returnStdout : true).trim()
                echo "Volume Path : ${VolumePath}"
                env.VOLUME_PATH = VolumePath 
                }
               
            }
        }
         stage("Copy the volume content to jar-file"){
            steps{
                script{
                    sh "sudo -i"
                sh "cp ${env.VOLUME_PATH}/ jar-file/"
                sh "ls /jar-file"
            }
        }
    }
    }
}
    
