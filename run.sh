#!/bin/bash

docker build -t apache2_gdb .
docker run -it --cap-add=SYS_PTRACE --security-opt seccomp=unconfined --rm --name apache_gdb -p 8888:80 -p 23456:23456 apache2_gdb