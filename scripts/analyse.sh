#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Wrong. Please provide a URL."
    exit 1
fi

url=$1
temp_folder="$HOME/Desktop/analyse_test"
filename=$(basename "$url")
output_file="$temp_folder/$filename"

if wget -q -O "$output_file" "$url"; then
    file_type=$(file "$output_file")
    echo "The type and mime type of the file: $file_type"

    file_size=$(stat -c %s "$output_file")
    echo "The size of the file: $file_size bytes"
    echo

    if ! file --mime-encoding "$output_file" | grep -qE "binary|image/jpeg"; then
        number_of_bytes=$(stat -c %s "$output_file")
        echo "The number of bytes in the file: $number_of_bytes"

        first_bytes=$(od -A n -t x1 -N 10 "$output_file" | tr -d ' \n')
        last_bytes=$(tail -c 10 "$output_file" | od -A n -t x1 | tr -d ' \n')
        echo "First bytes: $first_bytes"
        echo "Last bytes: $last_bytes"

    elif [[ "$file_type" = *"ASCII text"* ]]; then
        number_of_lines=$(wc -l "$output_file")
        echo "The number of lines: $number_of_lines"


        number_of_words=$(wc -w "$output_file")
        echo "The number of words: $number_of_words"


        number_of_spaces=$(grep -o ' ' "$output_file" | wc -l)
        echo "The number of spaces: $number_of_spaces"


        first_and_last_lines=$(head -n 1 "$output_file" && tail -n 1 "$output_file")
        echo "First line and last line: $first_and_last_lines"

        
        firefox "$output_file"
    else
        firefox "$output_file"
    fi
else
    echo "Failed to download file from $url."
    exit 1
fi