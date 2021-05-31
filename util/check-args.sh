#!/usr/bin/env bash

if [ -z "$BASE_IMAGE" ]; then
    >&2 echo "BASE_IMAGE not set. Please set BASE_IMAGE environment variable."
    exit 1
fi