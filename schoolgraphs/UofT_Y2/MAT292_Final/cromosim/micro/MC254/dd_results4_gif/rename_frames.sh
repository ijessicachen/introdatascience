#!/bin/bash

i=0
for f in MC254hall_fig_*.png; do
    printf -v newname "MC254hall_fig_%03d.png" "$i"
    mv "$f" "$newname"
    i=$((i+1))
done
