node {
    def checkout_dir = './noSpacePipeline@script'
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
            // def dockerfile = "Dockerfile-httpd"
            docker.build("php-httpd:centos", "../noSpacePipeline@script/httpd_build")
            // docker.build("node:local", "./Dockerfile-nodejs")
        }
    }
    stage('Deploy') {
        sh '${checkout_dir}/deploy.sh'
    }
}