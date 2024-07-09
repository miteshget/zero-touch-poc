#!/bin/bash
## check file
USER=rhel

# Set the target directory and file
target_directory="/home/rhel/ansible-files"
target_file="${target_directory}/system_setup.yml"
solve_file="/tmp/first-101/solve_11_system_setup.yml"

# Make sure solvers exist
/usr/bin/git clone https://github.com/leogallego/instruqt-wyfp-2024-solve.git /tmp/first-101

# Check if the target_file file exists
if [ -f "$target_file" ]; then
    # Read the content of the target_file file and solve_file
    file_content=$(cat "$target_file")
    solve_content=$(cat "$solve_file")

    # Compare the content of the target_file file with the expected content
    if [ "$file_content" != "$solve_content" ]; then
        fail-message "Challenge 1.1: The 'system_setup.yml' file does not have the proper content. Please check the file and try again."
    fi
else
    fail-message "Challenge 1.1: The 'system_setup.yml' file does not exist in the specified directory."
fi