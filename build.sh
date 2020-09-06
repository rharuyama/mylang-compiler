#!/bin/sh

#touch source
echo "(10 * 3 + 20) / 10" > source

stack ghc mylang.hs
./mylang 
gcc -o target target.s
./target
echo $?
