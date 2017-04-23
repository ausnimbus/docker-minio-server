FROM minio/minio
MAINTAINER AusNimbus <support@ausnimbus.com.au>

ENV HOME=/opt/app-root/src

RUN apk add --update bash && rm -rf /var/cache/apk/* && \
    mkdir -p ${HOME}/.pki/nssdb && \
    chown -R 1001:0 ${HOME}/.pki && \
    adduser -S -u 1001 -G root -h ${HOME} -s /sbin/nologin \
      -g "Default Application User" default

# Copy executable utilities.
COPY bin/ /usr/bin/

LABEL io.k8s.description="Minio" \
      io.k8s.display-name="Minio is an Amazon S3 compatible object storage server." \
      io.openshift.expose-services="9090:http" \
      io.openshift.tags="minio" \
      io.openshift.non-scalable=true

# Drop the root user and make the content of /opt/app-root owned by user 1001
RUN chown -R 1001:0 /opt/app-root && chmod -R ug+rwx /opt/app-root
USER 1001

VOLUME /opt/app-root/src
ENTRYPOINT ["container-entrypoint"]
CMD ["minio", "server", "/opt/app-root/src"]
