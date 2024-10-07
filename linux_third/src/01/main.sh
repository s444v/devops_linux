#!/bin/bash

read -p "Enter: " VAR

if [[ "$VAR" =~ [0-9] ]]; then 
    echo "ERROR"
else
    echo "$VAR"
fi