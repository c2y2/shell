#!/bin/bash
 
#get proxy list
declare check_threads=10
declare line
declare times
declare ip
declare port
declare i
declare j
declare mod
 
function quit() {
    exit "$1"
}
 
#echo "start check proxy's functionality..."
 
#retarget the input file to stdin
if [ "$#" -gt "0" ]
then
    exec 0<$1
else
    exec 1>&2
    echo "usage: bash $0 proxyListFile.txt"
    echo "error: must have one input arg"
    quit 1
fi
 
#check proxy's functionality
times=0
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
    #echo "times=$times ip=$ip port=$port"
    # start test
    if GET -t 5 -p "http://$ip:$port" "http://baidu.com" &>/dev/null
    then
        echo "$ip $port"
        echo ":) ip=$ip port=$port " &>/dev/null
    else
        echo "invalid ip=$ip port=$port : please check ip:host or network" &>/proc/self/fd/2
    fi &
    mod=$((times%check_threads))
    if [ "$mod" -eq "0" ]
    then
        wait
    fi
done
 
#close the fd of input file
exec 0>&-
quit 0
#exit
