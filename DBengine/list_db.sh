#!/usr/bin/bash

cd ../DB
ls -F | grep / | tr '/' ' '
cd ../DBengine
PS3="1)list 2)create 3)connect 4)drop 5)exit > "