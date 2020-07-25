#!/bin/sh

echo "17 15 +" > source
touch target

stack ghc mylang.hs
./mylang 
gcc -o target target.s
./target
echo $?
