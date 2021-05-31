#!/usr/bin/env zsh
./util/check-args.sh

if [ $? -eq 0 ]; then 
    docker rmi $BASE_IMAGE
    docker rmi $BASE_IMAGE-aws
    docker rmi $BASE_IMAGE-azure
fi
