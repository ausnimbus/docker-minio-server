# Minio Container

[![Build Status](https://travis-ci.org/ausnimbus/minio-component.svg?branch=master)](https://travis-ci.org/ausnimbus/minio-component)
[![Docker Repository on Quay](https://quay.io/repository/ausnimbus/minio-component/status "Docker Repository on Quay")](https://quay.io/repository/ausnimbus/minio-component)

This repository contains the source for deploying [Minio](https://www.ausnimbus.com.au/apps/minio/)
on [AusNimbus](https://www.ausnimbus.com.au/).

## Environment Variables

The following environment variables are available to configure your Minio instance:

- MINIO_ACCESS_KEY
- MINIO_SECRET_KEY
- MINIO_BROWSER
- MINIO_CACHE_SIZE (automatically configured)
- MINIO_CACHE_EXPIRY
- MINIO_MAXCONN

- MINIO_DIR: Minio data directory (default: `/export`)
- MINIO_EXTRA_OPTIONS: Extra parameters passed to `minio server`

## Versions

The versions currently supported are:

- latest
