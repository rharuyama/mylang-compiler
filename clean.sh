#!/bin/sh

rm -f mylang *.hi *.o
docker stop mylang
docker rm mylang
docker rmi mylang-image

