/**
* NOTE: THIS JENKINSFILE IS GENERATED VIA "./hack/run update"
*
* DO NOT EDIT IT DIRECTLY.
*/
node {
        def variants = "alpine".split(',');
        for (int v = 0; v < variants.length; v++) {

                def versions = "latest".split(',');
                for (int i = 0; i < versions.length; i++) {

                  if (variants[v] == "default") {
                    variant = ""
                    tag = versions[i]
                  } else {
                    variant = variants[v]
                    tag = versions[i] + "-" + variant
                  }


                        try {
                                stage("Build (Minio-${tag})") {
                                        openshift.withCluster() {
        openshift.apply([
                                "apiVersion" : "v1",
                                "items" : [
                                        [
                                                "apiVersion" : "v1",
                                                "kind" : "ImageStream",
                                                "metadata" : [
                                                        "name" : "minio",
                                                        "labels" : [
                                                                "builder" : "minio-component"
                                                        ]
                                                ],
                                                "spec" : [
                                                        "tags" : [
                                                                [
                                                                        "name" : "${tag}",
                                                                        "from" : [
                                                                                "kind" : "DockerImage",
                                                                                "name" : "minio/minio:${versions[i]}",
                                                                        ],
                                                                        "referencePolicy" : [
                                                                                "type" : "Source"
                                                                        ]
                                                                ]
                                                        ]
                                                ]
                                        ],
                                        [
                                                "apiVersion" : "v1",
                                                "kind" : "ImageStream",
                                                "metadata" : [
                                                        "name" : "minio-component",
                                                        "labels" : [
                                                                "builder" : "minio-component"
                                                        ]
                                                ]
                                        ]
                                ],
                                "kind" : "List"
                        ])
        openshift.apply([
                                "apiVersion" : "v1",
                                "kind" : "BuildConfig",
                                "metadata" : [
                                        "name" : "minio-component-${tag}",
                                        "labels" : [
                                                "builder" : "minio-component"
                                        ]
                                ],
                                "spec" : [
                                        "output" : [
                                                "to" : [
                                                        "kind" : "ImageStreamTag",
                                                        "name" : "minio-component:${tag}"
                                                ]
                                        ],
                                        "runPolicy" : "Serial",
                                        "resources" : [
                                            "limits" : [
                                                "memory" : "2Gi"
                                            ]
                                        ],
                                        "source" : [
                                                "git" : [
                                                        "uri" : "https://github.com/ausnimbus/minio-component"
                                                ],
                                                "type" : "Git"
                                        ],
                                        "strategy" : [
                                                "dockerStrategy" : [
                                                        "dockerfilePath" : "versions/${versions[i]}/${variant}/Dockerfile",
                                                        "from" : [
                                                                "kind" : "ImageStreamTag",
                                                                "name" : "minio:${tag}"
                                                        ]
                                                ],
                                                "type" : "Docker"
                                        ]
                                ]
                        ])
        echo "Created minio-component:${tag} objects"
        /**
        * TODO: Replace the sleep with import-image
        * openshift.importImage("minio:${tag}")
        */
        sleep 60

        echo "==============================="
        echo "Starting build minio-component-${tag}"
        echo "==============================="
        def builds = openshift.startBuild("minio-component-${tag}");

        timeout(10) {
                builds.untilEach(1) {
                        return it.object().status.phase == "Complete"
                }
        }
        echo "Finished build ${builds.names()}"
}

                                }
                                stage("Test (Minio-${tag})") {
                                        openshift.withCluster() {
        echo "==============================="
        echo "Starting test application"
        echo "==============================="

        def testApp = openshift.newApp("minio-component:${tag}", "-l app=minio-ex");
        echo "new-app created ${testApp.count()} objects named: ${testApp.names()}"
        testApp.describe()

        def testAppDC = testApp.narrow("dc");
        echo "Waiting for ${testAppDC.names()} to start"
        timeout(10) {
                testAppDC.untilEach(1) {
                        return it.object().status.availableReplicas >= 1
                }
        }
        echo "${testAppDC.names()} is ready"

        def testAppService = testApp.narrow("svc");
        def testAppHost = testAppService.object().spec.clusterIP;
        def testAppPort = testAppService.object().spec.ports[0].port;

        sleep 60
        echo "Testing endpoint ${testAppHost}:${testAppPort}"
        sh ": </dev/tcp/$testAppHost/$testAppPort"
}

                                }
                                stage("Stage (Minio-${tag})") {
                                        openshift.withCluster() {
        echo "==============================="
        echo "Tag new image into staging"
        echo "==============================="

        openshift.tag("ausnimbus-ci/minio-component:${tag}", "ausnimbus/minio-component:${tag}")
}

                                }
                        } finally {
                                openshift.withCluster() {
                                        echo "Deleting test resources minio-ex"
                                        openshift.selector("dc", [app: "minio-ex"]).delete()
                                        openshift.selector("bc", [app: "minio-ex"]).delete()
                                        openshift.selector("svc", [app: "minio-ex"]).delete()
                                        openshift.selector("is", [app: "minio-ex"]).delete()
                                        openshift.selector("pods", [app: "minio-ex"]).delete()
                                        openshift.selector("routes", [app: "minio-ex"]).delete()
                                }
                        }

                }
        }
}
