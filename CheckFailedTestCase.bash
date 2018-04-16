#!/bin/bash

declare file="Summary.html"
declare regex="color=\"#FF0000\">PASSED</font>"

declare file_content=$( cat "${file}" )
if [[ " $file_content " =~ $regex ]] # please note the space before and after the file content
    then
        echo "found"
    else
        echo "not found"
fi

exit