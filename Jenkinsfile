pipeline {
    agent {
        docker { 
            image 'devops/fedora-yocto-toolchain:latest'

            // TODO: use this to reuse existing sstate-cache and downloads
            // args '-v /opt/yocto/downloads:/opt/yocto/downloads:Z -v /opt/yocto/sstate-cache:/opt/yocto/sstate-cache:Z'
        }
    }

    options {
        disableConcurrentBuilds()
    }

    environment {
        WORKSPACE_BUILD_DIR = "${env.WORKSPACE}/build"
        WORKSPACE_DELIVERY_DIR = "${env.WORKSPACE}/delivery"

        YOCTO_TMP_DIR = "${env.WORKSPACE_BUILD_DIR}/tmp"
        YOCTO_DEPLOY_DIR = "${env.YOCTO_TMP_DIR}/deploy"

        YOCTO_DOWNLOAD_DIR = "${env.WORKSPACE_BUILD_DIR}/downloads"
        YOCTO_SSTATE_DIR = "${env.WORKSPACE_BUILD_DIR}/sstate-cache"

        // TODO
        // YOCTO_DOWNLOAD_DIR = "/opt/yocto/downloads"
        // YOCTO_SSTATE_DIR = "/opt/yocto/sstate-cache"

        // BB_NUMBER_THREADS = "${nproc}"
        // PARALLEL_MAKE = "-j ${nproc}"
        // PARALLEL_MAKE = "-j 1"
    }

    parameters {
        choice(
            name: 'IMAGE',
            choices: [
                'ha-image',
                'ha-image-tool',
                'ha-image-minimal',
                'ha-rpi-image-legacy',
                'ha-rpi-image-ng'
            ],
            description: 'Image to build',
        )
        choice(
            name: 'MACHINE',
            choices: [
                'rpi4ha',
                'rpi3ha',
                'rpi2ha'
            ],
            description: 'Machine to build for',
        )
        choice(
            name: 'DISTRO',
            choices: ['ha'],
            description: 'Distro to build for',
        )
        choice(
            name: 'DEBUG',
            choices: ['0', '1'],
            description: 'Enable debug options (adds debug tools, enables ssh, sets root password to "root")',
        )
        string(
            name: 'WIFI_SSID',
            defaultValue: '',
            description: 'WiFi SSID for initial setup',
        )
        string(
            name: 'WIFI_PASSWORD',
            defaultValue: '',
            description: 'WiFi password for initial setup',
        )
    }

    stages {
        stage('Init') {
            steps {
                script {
                    buildNumber = "${params.IMAGE}-${params.MACHINE}-${params.DISTRO}-${BUILD_NUMBER}"
                }
            }
        }

        stage('Git checkout submodules') {
            steps {
                sh 'git submodule update --init --recursive'
            }
        }

        stage('Create environment') {
            steps {
                withEnv(["HOME=${env.WORKSPACE}"]) {
                    sh 'python3 -m venv .venv'
                    sh 'source .venv/bin/activate'
                    sh 'pip install --upgrade pip'
                    sh 'python3 -m pip install pycryptodome pyelftools jinja2 pexpect GitPython cryptography'
                    sh 'source poky/oe-init-build-env $WORKSPACE_BUILD_DIR'
                }
            }
        }

        stage('Configure yocto project') {
            steps {
                // append to local.conf
                sh """
                    echo 'DL_DIR = "${env.YOCTO_DOWNLOAD_DIR}"' >> ${env.WORKSPACE_BUILD_DIR}/conf/local.conf
                    echo 'SSTATE_DIR = "${env.YOCTO_SSTATE_DIR}"' >> ${env.WORKSPACE_BUILD_DIR}/conf/local.conf
                    echo 'MACHINE = "${params.MACHINE}"' >> ${env.WORKSPACE_BUILD_DIR}/conf/local.conf
                    echo 'DISTRO = "${params.DISTRO}"' >> ${env.WORKSPACE_BUILD_DIR}/conf/local.conf
                    echo 'LICENSE_FLAGS_ACCEPTED = "commercial synaptics-killswitch"' >> ${env.WORKSPACE_BUILD_DIR}/conf/local.conf
                    echo 'HA_DEBUG_IMAGE = "${params.DEBUG}"' >> ${env.WORKSPACE_BUILD_DIR}/conf/local.conf
                    echo 'HA_DEBUG_STATIC_IP = "0"' >> ${env.WORKSPACE_BUILD_DIR}/conf/local.conf
                    echo 'HA_DEBUG_WIFI_SSID = "${params.WIFI_SSID}"' >> ${env.WORKSPACE_BUILD_DIR}/conf/local.conf
                    echo 'HA_DEBUG_WIFI_PASSWORD = "${params.WIFI_PASSWORD}"' >> ${env.WORKSPACE_BUILD_DIR}/conf/local.conf
                """

                sh """
                    echo 'BBLAYERS = " \\' >> ${env.WORKSPACE_BUILD_DIR}/conf/bblayers.conf
                    echo '  \${TOPDIR}/../poky/meta \\' >> ${env.WORKSPACE_BUILD_DIR}/conf/bblayers.conf
                    echo '  \${TOPDIR}/../poky/meta-poky \\' >> ${env.WORKSPACE_BUILD_DIR}/conf/bblayers.conf
                    echo '  \${TOPDIR}/../poky/meta-yocto-bsp \\' >> ${env.WORKSPACE_BUILD_DIR}/conf/bblayers.conf
                    echo '  \${TOPDIR}/../meta-openembedded/meta-oe \\' >> ${env.WORKSPACE_BUILD_DIR}/conf/bblayers.conf
                    echo '  \${TOPDIR}/../meta-openembedded/meta-python \\' >> ${env.WORKSPACE_BUILD_DIR}/conf/bblayers.conf
                    echo '  \${TOPDIR}/../meta-openembedded/meta-networking \\' >> ${env.WORKSPACE_BUILD_DIR}/conf/bblayers.conf
                    echo '  \${TOPDIR}/../meta-openembedded/meta-filesystems \\' >> ${env.WORKSPACE_BUILD_DIR}/conf/bblayers.conf
                    echo '  \${TOPDIR}/../meta-openembedded/meta-webserver \\' >> ${env.WORKSPACE_BUILD_DIR}/conf/bblayers.conf
                    echo '  \${TOPDIR}/../meta-virtualization \\' >> ${env.WORKSPACE_BUILD_DIR}/conf/bblayers.conf
                    echo '  \${TOPDIR}/../meta-raspberrypi \\' >> ${env.WORKSPACE_BUILD_DIR}/conf/bblayers.conf
                    echo '  \${TOPDIR}/../meta-swupdate \\' >> ${env.WORKSPACE_BUILD_DIR}/conf/bblayers.conf
                    echo '  \${TOPDIR}/../meta-bsp-rpi \\' >> ${env.WORKSPACE_BUILD_DIR}/conf/bblayers.conf
                    echo '  \${TOPDIR}/../meta-gateway \\' >> ${env.WORKSPACE_BUILD_DIR}/conf/bblayers.conf
                    echo '"' >> ${env.WORKSPACE_BUILD_DIR}/conf/bblayers.conf
                """
            }
        }

        stage('Debug') {
            steps {
                sh "printenv"
                sh "locale"
                sh "cat ${env.WORKSPACE_BUILD_DIR}/conf/local.conf"
                sh "cat ${env.WORKSPACE_BUILD_DIR}/conf/bblayers.conf"
            }
        }

        stage('Build image') {
            steps {
                sh """
                    source .venv/bin/activate
                    source poky/oe-init-build-env ${env.WORKSPACE_BUILD_DIR}
                    bitbake ${params.IMAGE}
                """
            }
        }

        stage('Export images') {
            steps {
                dir("${env.YOCTO_DEPLOY_DIR}") {
                    script {
                        def symlinkFiles = [
                            "images/${params.MACHINE}/${params.IMAGE}-${params.MACHINE}.rootfs.ext3",
                            "images/${params.MACHINE}/${params.IMAGE}-${params.MACHINE}.rootfs.ext3.gz",
                            "images/${params.MACHINE}/${params.IMAGE}-${params.MACHINE}.rootfs.manifest",
                            "images/${params.MACHINE}/${params.IMAGE}-${params.MACHINE}.rootfs.wic.bz2",
                            "images/${params.MACHINE}/${params.IMAGE}-${params.MACHINE}.rootfs.tar.bz2",
                            "images/${params.MACHINE}/${params.IMAGE}-${params.MACHINE}.rootfs.swu",
                        ]

                        symlinkFiles.each { file ->
                            def resolvedFile = sh(script: "readlink -f ${file}", returnStdout: true).trim()
                            
                            if (resolvedFile != "${env.YOCTO_DEPLOY_DIR}/${file}") {
                                sh "cp --remove-destination ${resolvedFile} ${file}"
                            }

                            archiveArtifacts artifacts: "${file}", fingerprint: true
                        }

                        archiveArtifacts artifacts: "licenses/${params.MACHINE}/${params.IMAGE}-${params.MACHINE}.rootfs/*", fingerprint: true
                    }
                }
            }
        }

        stage('Build SDK') {
            steps {
                sh """
                    source .venv/bin/activate
                    source poky/oe-init-build-env ${env.WORKSPACE_BUILD_DIR}
                    bitbake -c populate_sdk ${params.IMAGE}
                """
            }
        }

        stage('Export SDK') {
            steps {
                archiveArtifacts artifacts: "build/tmp/deploy/sdk/*", fingerprint: true
            }
        }
    }
    post {
        always {
            dir("$YOCTO_TMP_DIR") {
                deleteDir()
            }
        }
    }
}