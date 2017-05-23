# Minio Container

[![Build Status](https://travis-ci.org/ausnimbus/minio-container.svg?branch=master)](https://travis-ci.org/ausnimbus/minio-container)
[![Docker Repository on Quay](https://quay.io/repository/ausnimbus/minio/status "Docker Repository on Quay")](https://quay.io/repository/ausnimbus/minio)

This repository contains the source for deploying [Minio](https://minio.io/)
on [AusNimbus](https://www.ausnimbus.com.au/).

## Environment Variables

The following environment variables are available to configure your Minio instance:

- MINIO_ACCESS_KEY
- MINIO_SECRET_KEY
- MINIO_CACHE_SIZE
- MINIO_CACHE_EXPIRY

- MINIO_DIR: Minio data directory (default: `/opt/app-root/data`)
- MINIO_EXTRA_OPTIONS: Extra parameters passed to `minio server`

## Versions

The versions currently supported are:

- RELEASE.2017-05-05T01-14-51Z
