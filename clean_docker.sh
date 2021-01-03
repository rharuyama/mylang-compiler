#!/bin/sh

docker stop mylang
docker rm mylang
docker rmi mylang-image
