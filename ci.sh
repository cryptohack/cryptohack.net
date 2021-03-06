#!/bin/bash -e
HUGO_VERSION=0.18.1
DOWNLOAD_FILE_NAME=hugo_${HUGO_VERSION}_Linux-64bit.tar.gz
EXECUTABLE_NAME=hugo_${HUGO_VERSION}_linux_amd64
S3_BUCKET=hackforprivacy.org

wget https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/${DOWNLOAD_FILE_NAME}

tar xvzf ${DOWNLOAD_FILE_NAME} --strip 1

./${EXECUTABLE_NAME} -v --uglyURLs

aws s3 sync public/ s3://${S3_BUCKET} --acl public-read --region ap-southeast-2 --delete --cache-control "max-age=300,s-maxage=300"
