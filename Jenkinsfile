/**
* NOTE: THIS JENKINSFILE IS GENERATED VIA "./hack/run update"
*
* DO NOT EDIT IT DIRECTLY.
*/
node {
        def versions = "RELEASE.2017-05-05T01-14-51Z".split(',');
        for (int i = 0; i < versions.length; i++) {
                try {
                        stage("Build (Minio ${versions[i]})") {
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
                                                                "builder" : "minio"
                                                        ]
                                                ],
                                                "spec" : [
                                                        "tags" : [
                                                                [
                                                                        "name" : "${versions[i]}-alpine",
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
                                                        "name" : "minio",
                                                        "labels" : [
                                                                "builder" : "minio"
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
                                        "name" : "minio-${versions[i]}",
                                        "labels" : [
                                                "builder" : "minio"
                                        ]
                                ],
                                "spec" : [
                                        "output" : [
                                                "to" : [
                                                        "kind" : "ImageStreamTag",
                                                        "name" : "minio:${versions[i]}"
                                                ]
                                        ],
                                        "runPolicy" : "Serial",
                                        "source" : [
                                                "git" : [
                                                        "uri" : "https://github.com/ausnimbus/minio"
                                                ],
                                                "type" : "Git"
                                        ],
                                        "strategy" : [
                                                "dockerStrategy" : [
                                                        "dockerfilePath" : "versions/${versions[i]}/Dockerfile",
                                                        "from" : [
                                                                "kind" : "ImageStreamTag",
                                                                "name" : "minio/minio:${versions[i]}"
                                                        ]
                                                ],
                                                "type" : "Docker"
                                        ]
                                ]
                        ])
        echo "Created minio:${versions[i]} objects"
        /**
        * TODO: Replace the sleep with import-image
        * openshift.importImage("minio:${versions[i]}-alpine")
        */
        sleep 60

        echo "==============================="
        echo "Starting build minio-${versions[i]}"
        echo "==============================="
        def builds = openshift.startBuild("minio-${versions[i]}");

        timeout(10) {
                builds.untilEach(1) {
                        return it.object().status.phase == "Complete"
                }
        }
        echo "Finished build ${builds.names()}"
}

                        }
                        stage("Test (Minio ${versions[i]})") {
                                openshift.withCluster() {
        echo "==============================="
        echo "Starting test application"
        echo "==============================="

        def testApp = openshift.newApp("minio:${versions[i]}", "-l app=minio-ex");
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
