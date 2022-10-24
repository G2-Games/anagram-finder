#!/bin/bash
word=$(echo $1 | xargs)
if [[ $word = "" ]]; then
    echo "usage: ./anagram.sh <word>"
    exit 1
fi
wordsorted=$(echo $word | grep -o . | sort | tr -d "\n")
lines=$(grep -xin -- "$wordsorted" sortedwords.txt | sed -e 's/:.*//g')
if [[ $lines = "" ]]; then
    echo "No matches."
    exit 0
fi
readarray -t lines <<<"$lines"
for i in "${lines[@]}"; do
   sed "${i}q;d" words.txt | tr '[:upper:]' '[:lower:]'
done
