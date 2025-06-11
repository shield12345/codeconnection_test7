#!/bin/bash

# Function to generate random content
generate_random_content() {
    dd if=/dev/urandom of="$1" bs=1M count=47 2>/dev/null
}

# Function to check if input is a positive integer
is_positive_integer() {
    [[ "$1" =~ ^[0-9]+$ ]] && [ "$1" -gt 0 ]
}

# Clear the screen
clear

# Prompt for number of files
echo "How many 49MB files do you want to generate?"
read num_files

# Validate input
if ! is_positive_integer "$num_files"; then
    echo "Error: Please enter a valid positive number"
    exit 1
fi

# Create output directory if it doesn't exist
output_dir="generated_files"
mkdir -p "$output_dir"

# Generate files
echo "Generating $num_files files of 49MB each..."
echo "----------------------------------------"

for ((i=1; i<=$num_files; i++)); do
    filename="${output_dir}/file_${i}_$(date +%s%N).dat"
    echo "Generating file $i of $num_files: $(basename "$filename")"
    generate_random_content "$filename"
done

echo "----------------------------------------"
echo "File generation complete!"
echo "Files are located in the '$output_dir' directory"
echo "Total space used: $((49 * num_files))MB"
