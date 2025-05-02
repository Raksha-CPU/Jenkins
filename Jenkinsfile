pipeline {
    agent any

    environment {
        PYTHON_HOME = '/usr/local/bin/python3'
    }

    stages {
        stage('Run Pytest in Docker') {
            steps {
                script {
                    // Pull or build Docker image for Python
                    dockerImage = docker.build("python:3.8")

                    // Run pytest.sh inside the Docker container
                    dockerImage.inside {
                        sh './pytest.sh'
                    }
                }
            }
        }
    }
}
