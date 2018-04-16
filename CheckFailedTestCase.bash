#!/bin/bash

declare file="Summary.html"
declare regex="color=\"#FF0000\">FAILED</font>"
retval=-1
declare file_content=$( cat "${file}" )
if [[ " $file_content " =~ $regex ]] # please note the space before and after the file content
    then
        echo "found"
		retval=0
    else
        echo "not found"
		retval=1
fi

exit