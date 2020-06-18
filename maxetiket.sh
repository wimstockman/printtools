#!/bin/bash
# A Script to create Adresse Labels from text files to use with a Dymo Labelwriter 450 
# If lines are to long to fit on a label the fontsize is reduced to fit without linewraps
# Written by Wim Stockman
# Last Updated on 20200618
fontsize=20
while cat /tmp/o.txt  | enscript -MAdress -o"/tmp/v.ps" -B -r -fHelvetica@$fontsize 2>&1 | awk '/page/{if ($2 != 1) { exit 3;}} NR > 1 {exit 2;}'; 
(($? != 0 ));
do
	fontsize=$(($fontsize - 1))
	echo "fontsize:"$fontsize"pts"
done
lp -d DYMO /tmp/v.ps
