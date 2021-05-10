node {
    stage('Clean up') {
        dir('../devops_website@script'){
            sh './shutdown.sh'
            cleanWs()
        }
        dir(''){
            cleanWs()
        }
    }
    stage('Checkout') {
        dir('website') {
            git url: 'https://github.com/Waabuffet/devops-website', branch: "dev-branch"
        }
        dir('test') {
            git url: 'https://github.com/Waabuffet/devops-test', branch: "main"
        }
    }
    stage('Build') {
        dir(''){
            // def dockerfile = "Dockerfile-httpd"
            docker.build("php-httpd:centos", "../devops_website@script/httpd_build")
            // docker.build("node:local", "./Dockerfile-nodejs")
        }
    }
    stage('Deploy') {
        dir('../devops_website@script'){
            sh './deploy.sh'
        }
    }
    stage('Test') {
        dir('../devops_website@script'){
            sh './run-test.sh'
        }
    }
}