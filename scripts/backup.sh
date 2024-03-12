#!/bin/bash

#What to backup with argument.
if [ $# -ne 1 ]
	then
		echo "Usage: backup.sh <source_directory>"
		echo "Please try again."
		exit 1
	fi

#Where to backup.
dest="/tmp"

if [ ! -d "$dest" ]
	then
		echo "This destination $dest does not exist"
		exit 1
	fi

#Create archive filename.
#date_format=$(date "+%Y-%m-%d_%H-%M-%S")
archive_file="backup_$date_format.tar.gz"

#Checking, if such file already exists.
if [[ -f $dest/$archive_file ]] 
	then
		echo "This backup already exists."	
		exit 1
	fi

#Just an output where it is saved and date.
echo "Backing up $1 to $dest/$archive_file"
echo

#Archiving.
tar czf $dest/$archive_file $1
echo

start=$(date +%s)
end=$(date +%s)

echo "Backup finished"
echo "Execution time: $((end-start)) seconds"
