# 4-bash

* A bash script to parse out ip address from an http access log and print out occurrences of each ip in reverse order (i.e. Most frequent occurrences first)
* `sample.log` is provided as a sample log file although the format does not follow the `<timestamp> <ip address> <http path> <http verb> <user agent>` format exactly.
* Regex grep should make this useful for anything using an ipv4 address but this would need to be modified for ipv6.
* if other fields (like `<http path>`) were requested, this script could be modified to take advantage of an awk filter like `awk '{print $3}' | ... | ...`
