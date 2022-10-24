#!/bin/bash
inputfile=$1
rm "sorted$inputfile" &>/dev/null
while IFS= read -r line; do
    echo $(printf "%s\n" "$line" | sed -- 's/./\0\n/g' | sort | tr -d -- "\n") >> sorted$inputfile
done < $inputfile
