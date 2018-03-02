#!/bin/bash


templates=templs
tracking_file=track


check_file() {
	# Check if file exists
	if [ ! -f "$1" ]
	then
		echo "$0: File $1 not found."
		exit 1
	fi

	# Check it's not a folder
	if [ -d "$file" ]; then
		echo "$1 is a folder, not a file"
		exit 1
	fi

	# Check it's not already tracked
	if grep -q "$(realpath $1)" "$tracking_file"; then
		echo "File is already tracked"
		exit 1
	else
		echo "File is new"
	fi

	# TODO

	# Check if file contains our replace string
	if grep -q "@.*@" "$1"; then
		echo "File is not OK"
		exit 1
	else
		echo "File OK"
	fi
}

copy_file() {

	mkdir -p $templates/$(dirname $(realpath $1))
	cp $1 $templates/$(dirname $(realpath $1))
}

add_tracking() {
	echo "$(realpath $1)	$templates$(realpath $1)	$(md5sum $1)" >> $tracking_file
}

mkdir -p $templates
check_file $1
add_tracking $1
copy_file $1





