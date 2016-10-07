FROM  openshift/base-centos7

MAINTAINER AusNimbus <support@ausnimbus.com.au>

LABEL io.k8s.display-name="Minio Server" \
      io.k8s.description="Minio is an object storage server built for cloud application developers and devops."

EXPOSE 9000

RUN curl -o /usr/local/bin/minio https://dl.minio.io/server/minio/release/linux-amd64/minio && \
    chmod 755 /usr/local/bin/minio

COPY container-entrypoint /usr/bin/

USER 1001
VOLUME /opt/app-root/src
ENTRYPOINT ["container-entrypoint"]
CMD ["minio", "server", "/opt/app-root/src"]
