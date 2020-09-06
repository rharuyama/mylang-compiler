#!/bin/sh

#touch source
echo "42 + 7" > source

stack ghc mylang.hs
./mylang 
gcc -o target target.s
./target
echo $?
