pipeline {
    agent any

    environment {
        COVERAGE_THRESHOLD = '75'
    }

    stages {
        stage('Run Pytest in Docker') {
            steps {
                script {
                    docker.image('artifactory.nike.com:9002/python:3.12').inside {
                        sh 'chmod +x pytest.sh'
                        sh './pytest.sh'
                    }
                }
            }
        }

        stage('Archive Test Results') {
            steps {
                junit 'reports/test/test_report.xml'
                publishHTML(target
