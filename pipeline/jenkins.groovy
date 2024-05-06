pipeline {
    agent any
    parameters {
        choice(name: 'OS', choices: ['linux', 'arm', 'macos', 'windows'], description: 'Операційна система')
        choice(name: 'ARCH', choices: ['amd64', 'arm64'], description: 'Архитектура')
    }

    environment {
        GITHUB_TOKEN=credentials('laskavtsev')
        REPO = 'https://github.com/laskavtsev-dev/metelebot.git'
        BRANCH = 'main'
    }

    stages {

        stage('clone') {
            steps {
                echo 'Клонуємо репозиторій'
                git branch: "${BRANCH}", url: "${REPO}"
            }
        }

        stage('test') {
            steps {
                echo 'Тестуємо'
                sh "make test"
            }
        }

        stage('build') {
            steps {
                echo "Будуємо бінарник під платфору ${params.OS} для архітектури ${params.ARCH}"
                sh "make ${params.OS} ${params.ARCH}"
            }
        }

        stage('image') {
            steps {
                echo "Будуємо образ під платформу ${params.OS} для архітектури ${params.ARCH}"
                sh "make image-${params.OS} ${params.ARCH}"
            }
        }
        
        stage('login to GHCR') {
            steps {
                sh "echo $GITHUB_TOKEN_PSW | docker login ghcr.io -u $GITHUB_TOKEN_USR --password-stdin"
            }
        }

        stage('push image') {
            steps {
                sh "make -n ${params.OS} ${params.ARCH} image push"
            }
        } 
    }
    post {
        always {
            sh 'docker logout'
        }
    }
}