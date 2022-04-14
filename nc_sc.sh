#!/bin/bash
source conf.sh
set +e
docker container create -i -t --name $CNS  --mount type=bind,source="$(pwd)"/target,target=/app alpine
docker container create -i -t --name $CNC  --mount type=bind,source="$(pwd)"/target,target=/app alpine 
docker network create nwk1 --driver bridge  --subnet=172.18.0.0/16
docker network connect --ip 172.18.0.2 nwk1 $CNS
docker network connect --ip 172.18.0.3 nwk1 $CNC
set -e
# check if session is already running
tmux ls | if grep -q $TMUX_SESSION
then
    echo "session is already running, killing it"
    tmux kill-session -t $TMUX_SESSION
fi
docker container start $CNS
docker container start $CNC
tmux new-session -d -s $TMUX_SESSION "docker exec -it ${CNS}  sh /app/ncs.sh"
tmux split-window -d -t $TMUX_SESSION:0 -p20 -v "docker exec -it ${CNC} sh /app/ncc.sh"
# attach user to se it
tmux attach -t $TMUX_SESSION
