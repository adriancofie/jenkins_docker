pipeline {

    triggers {
         pollSCM('H/5 * * * *')
    }	 

    // The context (container) in which to run the stages
    agent any
    stages {
	
    // Gets the Application Code , which has its own Docker File 
        stage ('Checkout Latest Code') {
                // git url: 'https://github.com/adriancofie/aspdotnet_app.git'
	steps{
        git branch: 'master', url: 'https://github.com/adriancofie/aspdotnet_app.git'
        }
}

    // Build the Docker image based on the Dockerfile within the checked out code. 

        stage("Build Docker Image"){
            steps {	
                sh "docker build -t reponame/myApplication:latest ."
            }
        }	

    // Run the Docker Image and its  releveant build process as specified in 
    //  its dockerfile . The dockerfile will provision the build context.

    // Stores the docker image in the artificat repo
    // stage("Docker push") {
    //     steps {
    //         sh "docker push reponame/myAppplication"
    //     }
    // }

    // In this scenario starts container from local jenkins docker host. 
    // Use the -H flag to specify a remote env 
    stage("Deploy to ENV ") {
        steps {
            sh "docker run -d --rm -p 9090:8080 --name myApplication reponame/myApplication"
        }
    }

    // Run any associated acceptance tests
        // stage("Acceptance test") {
        //     steps{
        //         sleep 60   //docker run-d is asynchronus make sure the service is already up by waiting
        //         sh "./acceptance_test.sh"
        //     }
        // }


    }// End Stages


    post {
        always {            
		 // sh "docker stop myApplication"
         // cleanWs()
        }
    }   

}// End Pipeline

