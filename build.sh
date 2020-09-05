#!/bin/sh

#touch source
echo "33 3 / 10 *" > source

stack ghc mylang.hs
./mylang 
gcc -o target target.s
./target
echo $?
