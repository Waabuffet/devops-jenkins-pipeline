node {
    stage('Checkout') {
        dir('website') {
            git url: 'https://github.com/DeveloperDoms/devops-website.git'
        }
        dir('test') {
            git url: ''
            sh 'npm install'
        }
    }
    stage('Build') {
        docker.build("php-httpd:centos", "./Dockerfile-httpd")
        // docker.build("node:local", "./Dockerfile-nodejs")
    }
    stage('Deploy') {
        sh './deploy.sh'
    }
}