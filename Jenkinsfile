node {
    try{
        stage('Clean up') {
            dir('../devops_website'){
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
            dir('../devops_website@script'){
                // def dockerfile = "Dockerfile-httpd"
                docker.build("php-httpd:centos", "./httpd_build")
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
    } catch (e){
        throw e
    } finally {
        stage('Post Build') {
            dir('../devops_website@script'){
                sh './shutdown.sh'
            }
            if(currentBuild.currentResult == 'SUCCESS') {
                emailext to: 'developerdoms@gmail.com',
                    subject: "Build Successful: ${currentBuild.fullDisplayName}",
                    body: "Check Build output ${env.BUILD_URL}"
            } else {
                emailext to: 'developerdoms@gmail.com',
                    subject: "Failed Build: ${currentBuild.fullDisplayName}",
                    body: "Something is wrong with ${env.BUILD_URL}"
            }
        }
    }
}

// node vs pipeline agent
// Agent is for declarative pipelines and node is for scripted pipelines

// pipeline{
//     agent{
//         label "node"
//     }
//     stages{
//         stage('Clean up') {
//             steps{
//                 dir('../devops_website'){
//                     cleanWs()
//                 }
//             }
//         }
//         stage('Checkout') {
//             steps{
//                 dir('website') {
//                     git url: 'https://github.com/Waabuffet/devops-website', branch: "dev-branch"
//                 }
//                 dir('test') {
//                     git url: 'https://github.com/Waabuffet/devops-test', branch: "main"
//                 }
//             }
//         }
//         stage('Build') {
//             steps{
//                 dir('../devops_website@script'){
//                     script{
//                         // def dockerfile = "Dockerfile-httpd"
//                         docker.build("php-httpd:centos", "./httpd_build")
//                         // docker.build("node:local", "./Dockerfile-nodejs")
//                     }
//                 }
//             }
//         }
//         stage('Deploy') {
//             steps{
//                 dir('../devops_website@script'){
//                     sh './deploy.sh'
//                 }
//             }
//         }
//         stage('Test') {
//             steps{
//                 dir('../devops_website@script'){
//                     sh './run-test.sh'
//                 }
//             }
//         }
//     }
//     post {
//         always {
//             dir('../devops_website@script'){
//                 sh './shutdown.sh'
//             }
//         }
//         success {
//             mail to: 'developerdoms@gmail.com',
//                 subject: "Build Successful: ${currentBuild.fullDisplayName}",
//                 body: "Check Build output ${env.BUILD_URL}"
//         }
//         failure {
//             mail to: 'developerdoms@gmail.com',
//                 subject: "Failed Build: ${currentBuild.fullDisplayName}",
//                 body: "Something is wrong with ${env.BUILD_URL}"
//         }
//     }
// }
