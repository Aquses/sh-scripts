#!/bin/bash


#Initializing an argument.
if [ $# -ne 1 ]
  then
	echo -e "Usage: large_files.sh <path>\n Please try again."
	exit 1
  fi

path="$1"

#Checking if given direcotry path exists.
if [ ! -d "$path" ]
  then
	echo "Such directory path does not exist."
	exit 1
  fi		

file_count=$()
total_file_size=$()


#For loop goes through all of the files, increments or takes their size.
for file in "$path"/*
  do
	if [ -f "$file" ]
	  then
		file_size=$(stat -c %s "$file")
		((file_count++)) #Increment the counter.
		((total_file_size += file_size)) #Pass each file size to total_file_size.
	  fi
  done

# find - searches for files.
# -exec du -b {}
echo -e "Top 5 largest files by size:"
largest_files_size=$(find "$path" -type f -exec du -b {} + | sort -rh | head -n 5)
total_size=0

while read -r size file
  do
	echo -e "\t$file: $size bytes"
	((total_size += size))
  done <<< "$largest_files_size"


#Print out the total outputs.
echo -e "\nTotal size of all 5 largest files: $total_size bytes"
echo -e "\nTotal scanned files: $file_count and their total size: $total_file_size bytes"
