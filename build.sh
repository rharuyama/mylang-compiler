#!/bin/sh

#touch source
echo "7 * 10 + 5 * 10" > source

stack ghc mylang.hs
./mylang 
gcc -o target target.s
./target
echo $?
