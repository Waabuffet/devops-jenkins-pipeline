import hudson.tasks.junit.TestResultAction
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
                currentBuild.result = 'SUCCESS'
            }
        }
    } catch (e){
        currentBuild.result = 'FAILURE'
        throw e
    } finally {
        stage('Post Build') {
            dir('../devops_website@script'){
                sh './shutdown.sh'
            }
            dir('test') {
                junit skipPublishingChecks: true, testResults: 'report.xml'
            }
            if(currentBuild.result == 'SUCCESS') {
                emailext to: 'developerdoms@gmail.com',
                    subject: "Build Successful: ${currentBuild.fullDisplayName}",
                    body: "Check Build output ${env.BUILD_URL}"
            } else {
                def errorMessage = ''
                try{
                    TestResultAction testResultAction = currentBuild.rawBuild.getAction(TestResultAction.class)
                    errorMessage = testResultAction.getResult().getFailedTests()[0].getErrorDetails()
                } catch (e2){
                    // nothign to be done here
                }
                
                emailext to: 'developerdoms@gmail.com',
                    subject: "Failed Build: ${currentBuild.fullDisplayName}",
                    body: "Something is wrong with ${env.BUILD_URL}, failed message: ${errorMessage}"
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
