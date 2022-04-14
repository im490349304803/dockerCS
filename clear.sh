#!/bin/bash
source conf.sh
docker container stop $CNS
docker container stop $CNC
docker container rm $CNS
docker container rm $CNC
docker network rm nwk1 
