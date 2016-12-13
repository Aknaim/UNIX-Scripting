#!/bin/bash

#2-----------
if [ -d ~/deleted  ] 			#check if the delted directory exists in home
then
	:				#if it does do nothing
else
	mkdir ~/deleted			#otherwise make the directory
fi

fileName="$(basename ${1})" 		#store the basename of any argument (incase it is a path)
#echo "${fileName}"

#4-----------
if [ -d $fileName ] 			#check if the argument was a directory
then
	echo "That is a directory not a file" #if arg was a directory then print this msg
#5/6---start
elif [ $(find ~ -name "$fileName") ]	#otherwise check if a file exists with said name
then

pathext="$(readlink -m ${fileName})"	#store the absolute to the file in pathext
inode="$( ls -i ~ | fgrep ${fileName} | tr -d [:alpha:] )"	#store the inode of the file
deletedname="$(echo ${fileName}_${inode})"	#format the deleted to be fileName_inode
#echo "${deletedname}"
mv ${pathext} ~/deleted			#move the file to the deleted folder in home
mv ~/deleted/${fileName} ~/deleted/${deletedname}	#rename the file to be in the fileName_inode format

restorename="${deletedname}:${pathext}"	#store restore name as deletedname:path
#echo "${restorename}"
echo "${restorename}" >> ~/.restore.info	#append the restorename to the .restore.info file in home

#path="${PWD}"
#pathext="${path}/${fileName}"

#5/6---end
elif [ $# -eq 0 ]			#check to see if there was an argument provided
then
	echo "No filename provided"	#if there was no argument provided print this msg
else
	echo "File does not exist"	#otherwise print the file doesn't exist
fi