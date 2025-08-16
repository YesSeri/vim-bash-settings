#!/bin/bash

# Author: Henrik Zenkert
# Description: This generates all the letters of the swedish alphabet
# I made this for my daughter. I use the letters in Anki
# to teach her the alphabet. :)
# Date: 2023, don't remember exactly

alphabet=("A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z" "Å" "Ä" "Ö")

fonts=("DejaVu-Sans" "DejaVu-Serif" "DejaVu-Sans-Mono" "Liberation-Mono" "Liberation-Serif" "Liberation-Sans" "Ubuntu" "FreeMono" "FreeSerif")

color_pairs=(
    "#000000 #FFD700"
    "#483D8B #FFB6C1"
    "#2E8B57 #FFDEAD"
    "#FF6347 #F0E68C"
    "#6A5ACD #7FFFD4"
    "#DB7093 #EEE8AA"
    "#20B2AA #FFDAB9"
    "#9370DB #87CEFA"
    "#3CA371 #FFD0DB"
    "#FF39C4 #3CFC00"
    "#7A5583 #FFC0CA"
    "#4169E1 #FFA500"
    "#8B4513 #FAFAD2"
    "#2F4F4F #FFD700"
    "#110011 #DA70D6"
    "#FFD700 #000000"
    "#FFB6C1 #483D8B"
    "#FFDEAD #2E8B57"
    "#F0E68C #FF6347"
    "#7FFFD4 #6A5ACD"
    "#EEE8AA #DB7093"
    "#FFDAB9 #20B2AA"
    "#87CEFA #9370DB"
    "#FFE0DB #3C6371"
    "#3CFC00 #FF39C4"
    "#FFC0CA #7A5583"
    "#FFA500 #4169E1"
    "#FAFAD2 #8B4513"
    "#FFD700 #2F4F4F"
    "#DA70D6 #110011"
)

mkdir -p swedish_alphabet_jpgs

for letter in "${alphabet[@]}"; do
    size=$((RANDOM % 40 + 160))

    font=${fonts[$RANDOM % ${#fonts[@]}]}

    color_pair=${color_pairs[$RANDOM % ${#color_pairs[@]}]}
    IFS=' ' read -r fg_color bg_color <<< "$color_pair"

	echo "$letter: $font $size $color_pair"

    convert -size 185x250 -gravity center -background "$bg_color" -fill "$fg_color" -font "$font" -pointsize "$size" label:"$letter" "swedish_alphabet_jpgs/$letter.jpg"
done

echo "JPEGs created in swedish_alphabet_jpgs directory."

