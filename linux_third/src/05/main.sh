#!/bin/bash

timer_start=$(date +%s%3N)

if [ $# -eq 0 ]; then
	echo "Error: path not found"
	exit 1
fi

path=$1

if [ ! -d "$path" ]; then
	echo "Error: directory not found"
	exit 1
fi

if [ "${path: -1}" != "/" ]; then
	echo "Error: path must end with '/'"
	exit 1
fi

NUM_OF_FOLDERS=$(find "$path" -type d 2>/dev/null | wc -l)
TOP5_FOLDER=$(du -h "$path"* 2>/dev/null | sort -hr | head -n 5 | awk '{print NR " - " $2 ", " $1}')
NUM_OF_FILES=$(find "$path" -type f 2>/dev/null | wc -l)
NUM_OF_CONF=$(find "$path" -type f -name "*.conf" 2>/dev/null  | wc -l)
NUM_OF_TXT=$(find "$path" -type f -name "*.txt" 2>/dev/null | wc -l)
NUM_OF_EXE=$(find "$path" -type f -executable  2>/dev/null | wc -l)
NUM_OF_LOG=$(find "$path" -type f -name "*.log" 2>/dev/null | wc -l)
NUM_OF_AR=$(find "$path" -type f \( -name "*.zip" -o -name "*.rar" -o -name "*.tar" -o -name "*.7z" -o -name "*.gz" \) 2>/dev/null | wc -l)
NUM_OF_LIN=$(find "$path" -type l 2>/dev/null | wc -l)
TOP10_FILES=$(find "$path" -type f -exec du -h {} + 2>/dev/null | sort -hr | sed -n '1,10'p | awk '{printf("%d - %s, %s, ", NR, $2, $1); system("bash -c '\''file -b --mime-type "$2"'\''")}')
TOP10_EXE=$(find "$path" -type f -executable -exec du -h {} + 2>/dev/null | sort -hr | head -n 10 | awk '{printf "%d - %s, %s, ", NR, $2, $1; system("md5sum " $2 " | cut -d\" \" -f1")}')

echo "Total number of folders (including all nested ones) = $NUM_OF_FOLDERS"
echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
echo "${TOP5_FOLDER}"
echo "Total number of files = $NUM_OF_FILES"
echo "Number of:"
echo "Configuration files (with the .conf extension) = $NUM_OF_CONF"
echo "Text files = $NUM_OF_TXT"
echo "Executable = $NUM_OF_EXE"
echo "Log files (with the extension .log) = $NUM_OF_LOG"
echo "Archive files = $NUM_OF_AR"
echo "Symbolic links = $NUM_OF_LIN"
echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
echo "${TOP10_FILES}"
echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
echo "${TOP10_EXE}"
timer_end=$(date +%s%3N)
let "total=$timer_end - $timer_start"
echo "Script execution time (in seconds) = $(bc<<<"scale=10;$total/60")"