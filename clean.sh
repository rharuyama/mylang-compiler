#!/bin/sh

rm -f mylang *.hi *.o target target.*
docker stop mylang
docker rm mylang
docker rmi mylang-image

