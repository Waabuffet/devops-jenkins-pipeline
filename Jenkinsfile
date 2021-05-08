node {
    stage('Checkout') {
        dir('website') {
            git url: 'https://github.com/Waabuffet/devops-website', branch: "main"
        }
        dir('test') {
            git url: 'https://github.com/Waabuffet/devops-test', branch: "main"
        }
    }
    stage('Build') {
        dir(''){
            // def dockerfile = "Dockerfile-httpd"
            docker.build("php-httpd:centos", "../noSpacePipeline@script/httpd_build")
            // docker.build("node:local", "./Dockerfile-nodejs")
        }
    }
    stage('Deploy') {
        dir('../noSpacePipeline@script'){
            sh './deploy.sh'
        }
    }
    stage('Test') {
        dir('../noSpacePipeline@script'){
            sh './run-test.sh'
        }
    }
    stage('Clean up') {
        dir('../noSpacePipeline@script'){
            sh './shutdown.sh'
            cleanWs()
        }
        dir(''){
            cleanWs()
        }
    }
}