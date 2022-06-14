#!/bin/zsh
cmds=("jot 100" "(jot 50 && sleep 0.5 && jot 50 50)")
for cmd in "${cmds[@]}"
do
	printf "$cmd | ./gnl-echo | diff - <($cmd)\n"
	eval $cmd | ./gnl-echo | diff -U 3 - <(eval $cmd) 1>/dev/null && printf "\e[32mOK\n\e[m" || printf "\e[31mKO\n\e[m"
done
