#!/bin/bash

set -e

: ${MONGO_HOST:?}
: ${MONGO_PORT:?}
: ${MONGO_DB:?}
: ${MONGO_USERNAME:?}
: ${MONGO_PASSWORD:?}
: ${S3_FOLDER:?}
#: ${AWS_ACCESS_KEY_ID:?}
#: ${AWS_SECRET_ACCESS_KEY:?}
: ${DATE_FORMAT:?}
: ${FILE_PREFIX:?}


# define path to dump in 3
S3_PATH=${S3_FOLDER}${FILE_PREFIX}${MONGO_DB}-$(date -u +${DATE_FORMAT}).dump.gzip
# build mongodb uri with user / password and host / port
mongo_uri=mongodb://${MONGO_USERNAME}:${MONGO_PASSWORD}@${MONGO_HOST}:${MONGO_PORT}

echo "Starting backup..."

mongodump --uri mongo_uri --db ${MONGO_DB} --gzip --archive | aws s3 cp - S3_PATH

echo "Done!"
