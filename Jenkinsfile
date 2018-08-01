pipeline {

    triggers {
         pollSCM('H/5 * * * *')
    }	 

    // The Jenkins context (env/container) in which to run the stages
    agent any

    stages {
	
    // Retrieve the application code, which contains its own Docker File 
        stage ('Checkout Latest Code') {
                // git url: 'https://github.com/adriancofie/aspdotnet_app.git'
            steps{
                git branch: 'master', url: 'https://github.com/adriancofie/aspdotnet_app.git'
            }
        }

    // Build the Docker image based on the Dockerfile located in the checked out code   . 
        stage("Build Docker Image"){
            steps {	
                sh "docker build -t reponame/my_application:latest ."
            }
        }	

    // Run the Docker Image and its  releveant build process as specified in 
    //  its dockerfile . The dockerfile will provision the build context.

    // Store the Docker image in the artificat repo
    // stage("Docker push") {
    //     steps {
    //         sh "docker push reponame/my_appplication"
    //     }
    // }

    // In this scenario starts container from local jenkins docker host. 
    // Use the -H flag to specify a remote env 
    stage("Deploy to ENV ") {
        steps {
            sh "docker run -d --rm -p 9090:80 --name myApplication reponame/my_application"
        }
    }

    //Run any associated acceptance tests
        stage("Acceptance test") {
            steps{
                sleep 60   //docker run-d is asynchronus make sure the service is already up by waiting
                sh 'docker exec myApplication /bin/bash -c "./acceptance_test.sh"'

                // Run the application for 5 minutes before proceeding / shutting down
                sleep 300
            }
        }


    }// End Stages

    post {
        always {            
		  sh "docker stop myApplication"

        // Clear the Jenkins workspace (build artifacts)
         cleanWs()
        }
    }   

}// End Pipeline
