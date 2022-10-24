#!/bin/bash
word=$(echo $1 | xargs)
dictionary="${2:-words.txt}"
if [[ $word = "" ]]; then
    echo "usage: ./anagram.sh <word> <dictionary file, optional>"
    exit 1
fi
if [ ! -f "sorted$dictionary" ]; then
    echo "Sorted dictionary not found. Generating (this will take a while)..."
    bash sorter.sh $dictionary
    echo "Done!"
fi
wordsorted=$(echo $word | grep -o . | sort | tr -d "\n")
lines=$(grep -xin -- "$wordsorted" sorted$dictionary | sed -e 's/:.*//g')
if [[ $lines = "" ]]; then
    echo "No matches."
    exit 0
fi
readarray -t lines <<<"$lines"
for i in "${lines[@]}"; do
   sed "${i}q;d" $dictionary | tr '[:upper:]' '[:lower:]'
done
