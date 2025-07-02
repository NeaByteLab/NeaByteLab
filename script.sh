#!/bin/bash

arr[0]="bot(👋)"
arr[1]="bot(🥳)"
arr[2]="bot(😬)"
arr[3]="bot(👨‍💻)"
arr[4]="bot(😪)"
arr[5]="bot(😎)"
arr[6]="bot(🙄)"
arr[7]="bot(👻)"

rand=$[$RANDOM % ${#arr[@]}]
d=`date '+%Y-%m-%dT%H:%M:%SZ'`

echo "## LAST UPDATED AT: ${d}" > UPDATE.md

git commit -am "${arr[$rand]}: ${d}"