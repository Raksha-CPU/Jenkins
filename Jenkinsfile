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

                script {
                    publishHTML([
                        reportDir: 'cov/cov_html',
                        reportFiles: 'index.html',
                        reportName: 'Code Coverage Report'
                    ])
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'cov/cov.xml', fingerprint: true
        }
    }
}
