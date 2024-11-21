#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <inputfile>" >&2
    exit 1
fi

file=$1
output=wpp_${file}

if ! which ffmpeg > /dev/null; then
    echo "unable to convert ${file}: ffmpeg not found" >&2
    exit 1
fi

ffmpeg -i ${file}  -c:v libx264 -profile:v baseline -level 3.0 -pix_fmt yuv420p ${output}

[ $? -eq 0 ] && echo "File ${output} created successfully" || echo "Error creating file ${output}"
