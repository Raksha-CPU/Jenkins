pipeline {
    agent {
        docker {
            image 'artifactory.nike.com:9002/python:3.12'
            args '-u root:root' // to avoid permission issues
        }
    }

    environment {
        COVERAGE_THRESHOLD = '75'
    }

    stages {
        stage('Run Tests') {
            steps {
                script {
                    sh 'chmod +x pytest.sh'
                    sh './pytest.sh'
                }
            }
        }

        stage('Archive Test Results') {
            steps {
                junit 'reports/test/test_report.xml'
            }
        }

        stage('Publish Coverage HTML') {
            steps {
                publishHTML(target: [
                    reportDir: 'cov/cov_html',
                    reportFiles: 'index.html',
                    reportName: 'Coverage Report',
                    keepAll: true
                ])
            }
        }
    }

    post {
        always {
            echo 'Cleaning up workspace...'
            deleteDir()
        }
        failure {
            echo 'Build failed. Please check test or coverage results.'
        }
    }
}
