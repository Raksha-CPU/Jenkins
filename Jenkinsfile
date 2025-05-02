pipeline {
    agent any

    stages {
        stage('Run Pytest') {
            steps {
                script {
                    // Directly execute the pytest.sh script
                    sh './pytest.sh'
                }
            }
        }
    }
}
