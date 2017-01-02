# Minio Server Docker Image

[![Build Status](https://travis-ci.org/ausnimbus/docker-minio-server.svg?branch=master)](https://travis-ci.org/ausnimbus/docker-minio-server)
[![Licensed under Apache License version 2.0](https://img.shields.io/github/license/ausnimbus/docker-minio-server.svg?maxAge=2592000)](https://www.apache.org/licenses/LICENSE-2.0)

This repository contains a Dockerfile to run Minio Server on [AusNimbus](https://www.ausnimbus.com.au/) (OpenShift V3)

## Configuration

The following environment variables are required:

- MINIO_ACCESS_KEY
- MINIO_SECRET_KEY
- MINIO_CACHE_SIZE
- MINIO_CACHE_EXPIRY
