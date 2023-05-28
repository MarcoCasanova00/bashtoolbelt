#!/bin/bash

# Specify the folder containing the images
image_folder="path/to/folder"

# Specify the output path for the collage
output_path="path/to/collage.jpg"

# Specify the size of the collage (default: 800x800)
collage_size="800x800"

# Specify the grid size for arranging the images (default: 4x4)
grid_size="4x4"

# Create a temporary directory for resized images
temp_dir=$(mktemp -d)

# Resize and copy images to the temporary directory
find "$image_folder" -maxdepth 1 -type f -exec convert -resize "$collage_size^" -gravity center -extent "$collage_size" {} "$temp_dir/{}" \;

# Create the collage using montage
montage "$temp_dir"/*.jpg -tile "$grid_size" -geometry +0+0 "$output_path"

# Clean up temporary directory
rm -r "$temp_dir"

echo "Collage saved at $output_path"
