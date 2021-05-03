node {
    stage('Checkout') {
        dir('website') {
            git url: 'https://github.com/Waabuffet/devops-website', branch: "main"
        }
        dir('test') {
            // git url: ''
            // sh 'npm install'
        }
    }
    stage('Build') {
        dir(''){
            docker.build("php-httpd:centos", "../workspace@script/Dockerfile-httpd")
            // docker.build("node:local", "./Dockerfile-nodejs")
        }
    }
    stage('Deploy') {
        sh './deploy.sh'
    }
}