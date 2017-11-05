#!/bin/bash

argc=$#
#argv=($*)
repoPaths=`repo forall -c printenv REPO_PATH`

for (( i = 1; i <= $argc; i++ )); do
	argv=${!i}
	if [ "x$argv" == "x-h" -o "x$argv" == "x--help" -o "x$argv" == "x?" ]; then
		echo -e "help info\n"
	fi

	if [ "x$argv" == "x-m" ]; then
		((i=i+1))
		#echo -e "i=$i  ${!i}\n"
		mesg=${!i}
	fi
done


#echo "-------------"
#echo "commit:$mesg"
#echo "-------------"
#echo "$repoPaths"

sed -i "s/^Bug #657697.*/Bug #657697 $mesg/g" ~/.commit_template_local

for repoPath in $repoPaths
do 
	cd $repoPath
	changes=`git status | grep modified | awk -F ':' '{print $2}' | sed s/[[:space:]]//g | sed ':x;N;s/\n/ /;b x'`
	if [ "x$changes" != "x" ]; then
		git add $changes
		git commit -F ~/.commit_template_local
	fi
	cd -
done


