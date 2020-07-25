#!/bin/sh

echo "33 3 /" > source
touch target

stack ghc mylang.hs
./mylang 
gcc -o target target.s
./target
echo $?
