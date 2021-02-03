// Jenkinsfile for docker-middleman-shell

// compute revision based on build-number and branch
if(env.JOB_BASE_NAME == "master") {
    revision="b-${env.BUILD_NUMBER}"
} else if (env.JOB_BASE_NAME.startsWith("PR-")) {
    revision="${env.JOB_BASE_NAME}-dev"
} else {
    revision="${env.JOB_BASE_NAME}-b-${env.BUILD_NUMBER}"
}

dockerImageName = "middleman-shell:${revision}"
dockerImage = null

pipeline {

    agent any

    environment {
        DOCKER_REGISTRY_URL = credentials("DOCKER_REGISTRY_URL")
    }

    stages {
        stage("Tag with build number") {
            steps {
                sh """
                    echo ${BUILD_NUMBER} >${WORKSPACE}/BUILDNUMBER
                    echo ${GIT_COMMIT} >${WORKSPACE}/REVISION
                    env
                """
            }
        }

        stage("Build docker container") {
            steps {
                script {
                    dockerImage = docker.build(dockerImageName)
                }
            }
        }

        stage("Push container") {
            steps {
                script {
                    docker.withRegistry("${DOCKER_REGISTRY_URL}") {
                        dockerImage.push()
                    }
                }
            }
        }
    }
}
