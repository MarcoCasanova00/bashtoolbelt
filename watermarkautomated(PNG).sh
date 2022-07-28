#!/bin/bash


# usage: bash watermark.sh folder

# Change the working directory to the one specified as argument.
if ! cd "$*"; then
    echo "error: the folder '$*' doesn't exist."
    exit
fi

# Create a directory called "output" into the working directory.
mkdir output &> /dev/null

# Start counting in 1.
counter=1

# For each file that ends in .jpg:
for image in *.png; do  
    convert "$image" \
            -background transparent \
            -fill grey \
            -font ubuntu \
            -size 380x260 \
            -pointsize 38 \
            -gravity southeast \
            -annotate +0+0 "LE MEME SHOP ETSY" \
	    -resize 96% \
            "output/$image"

    # Increment counter by one.
    ((counter++)) 
done
