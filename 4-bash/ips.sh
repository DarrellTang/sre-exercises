#!/bin/bash
# Check if a filename was passed as a parameter
# A sample file can be found in sample.log in this directory
# sample.log consists of the first 10k lines from https://www.kaggle.com/datasets/kimjmin/apache-web-log
if [ $# -eq 0 ]
  then
    echo "Please provide a filename. i.e. ./ips.sh filename.log"
    exit
fi

filename=$1

# grep for the regex for an ipv4 address from the file
# sort the ips so they're next to each other
# count unique occurrences
# reverse sort the list
# output top 10 lines
# Regex for ipv4 found here: https://www.putorius.net/grep-an-ip-address-from-a-file.html
grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' $filename | sort | uniq -c | sort -r | head
