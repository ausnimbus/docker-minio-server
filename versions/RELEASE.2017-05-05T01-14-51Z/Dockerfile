#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "./hack/run update"
#
# DO NOT EDIT IT DIRECTLY.
#
FROM minio/minio:RELEASE.2017-05-05T01-14-51Z
# <pre>

MAINTAINER AusNimbus <support@ausnimbus.com.au>

LABEL summary="Platform for running Minio RELEASE.2017-05-05T01-14-51Z applications" \
      maintainer="AusNimbus <support@ausnimbus.com.au>" \
      io.k8s.description="Platform for running Minio RELEASE.2017-05-05T01-14-51Z applications" \
      io.k8s.display-name="Minio RELEASE.2017-05-05T01-14-51Z"

ENV HOME=/opt/app-root/src

RUN apk --no-cache add bash rsync && rm -rf /var/cache/apk/* && \
    mkdir -p ${HOME}/.pki/nssdb && \
    chown -R 1001:0 ${HOME}/.pki && \
    adduser -S -u 1001 -G root -h ${HOME} -s /sbin/nologin \
      -g "Default Application User" default && \
    chown -R 1001:0 /opt/app-root

# Copy common executable utilities.
COPY ./common/bin/ /usr/bin/

# Each container image can have 'contrib' a directory with extra files needed to
# run and build the application.
COPY ./contrib/ /opt/app-root

# </pre>
# <component>

RUN apk --no-cache add shadow && rm -rf /var/cache/apk/*

# Copy the component scripts (override existing container-entrypoint)
COPY ./component/bin/ /usr/bin/

# </component>
# <template>

LABEL io.openshift.expose-services="9000:http" \
    io.openshift.tags="component,minio"

# </template>
# <post>

# Drop the root user and make the content of /opt/app-root owned by user default
RUN chown -R default:0 /opt/app-root && chmod -R ug+rwx /opt/app-root
USER default

ENTRYPOINT ["container-entrypoint"]

# </post>
