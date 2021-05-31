#!/usr/bin/env zsh
./util/check-args.sh

if [ $? -eq 0 ]; then 
    docker build -t $BASE_IMAGE .
    docker build -f Dockerfile.aws --build-arg BASE_IMAGE=$BASE_IMAGE -t $BASE_IMAGE-aws .
    docker build -f Dockerfile.azure --build-arg BASE_IMAGE=$BASE_IMAGE -t $BASE_IMAGE-azure . 
fi
