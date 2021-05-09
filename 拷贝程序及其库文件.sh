#!/bin/env bash


rootdir=/mnt/sysroot

libcp() {
	for i in `ldd $1|grep -o '/[^[:blank:]]*'`;do
		libdir=`dirname $i`
		[[ -d $rootdir$libdir ]] || mkdir -p $rootdir$libdir && cp  $i $rootdir$i
	done
}

read -n 20 -t 10 -p 'input the command:' bias

while [[ "$bias" != 'quit' && $bias != 'exit' && $bias != 'Q' && "$bias" != 'q' ]];do

	which $bias >& /dev/null

	#if [[ $? -ne 0 ]];then
	#	read -p 'input error,input the command:' bias
	#fi
	while [[ $? -ne 0 ]];do
		read -p 'input error,input the command:' bias
		which $bias >& /dev/null
	done

	blob=`which $bias`
	blobdir=`dirname $blob`

	[[ -d $rootdir$blobdir ]] || mkdir -p $rootdir$blobdir && cp  $blob $rootdir$blobdir
	libcp $blob

	read -p 'collocate done,next command:' bias
done
