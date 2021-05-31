#!/usr/bin/env zsh
./util/check-args.sh

if [ $? -eq 0 ]; then 
    docker push $BASE_IMAGE
    docker push $BASE_IMAGE-aws
    docker push $BASE_IMAGE-azure
    docker push $BASE_IMAGE-gcp    
fi
