#!/usr/bin/env bash

PARTS="intro education skills work projects honours"
TYPES="site"

TEXHEAD="\\documentclass{elliot-cv}\\begin{document}"
TEXTAIL="\\end{document}"
MAIN="$TEXHEAD"
EXTRA="$TEXHEAD"

[ -d "tex" ] || mkdir tex
[ -d "pdf" ] || mkdir pdf
[ -d "aux" ] || mkdir aux

for part in $PARTS; do
    # add default text to all types
    MAIN="$MAIN$(cat parts/$part.tex)"
    EXTRA="$EXTRA$(cat parts/$part.tex)"

    # add extra text to extra (if it exists)
    if [ -f "parts/$part.extra.tex" ]; then
        EXTRA="$EXTRA$(cat parts/$part.extra.tex)"
    fi
done

echo "$MAIN$TEXTAIL" > tex/main.tex
echo "$EXTRA$TEXTAIL" > tex/extra.tex
pdflatex tex/main.tex
pdflatex tex/extra.tex

for type in $TYPES; do
    THISTYPE="$TEXHEAD"
    THISTYPEEXTRA="$TEXHEAD"
    for part in $PARTS; do
        # adds the type specific text if it exists, and default text otherwise
        if [ -f "parts/$part.$type.tex" ]; then
            THISTYPE="$THISTYPE$(cat parts/$part.$type.tex)"
        else
            THISTYPE="$THISTYPE$(cat parts/$part.tex)"
        fi

        # adds type specific extra text to the extra if it exists, and default
        # extra otherwise (if that exists also)
        if [ -f "parts/$part.$type.extra.tex" ]; then
            THISTYPEEXTRA="$THISTYPEEXTRA$(cat parts/$part.$type.extra.tex)"
        else
            if [ -f "parts/$part.extra.tex" ]; then
                THISTYPEEXTRA="$THISTYPEEXTRA$(cat parts/$part.extra.tex)"
            fi
        fi
    done
    echo tex/$type.tex
    echo "$THISTYPE$TEXTAIL" > tex/$type.tex
    echo "$THISTYPEEXTRA$TEXTAIL" > tex/${type}extra.tex
    pdflatex tex/$type.tex
    pdflatex tex/${type}extra.tex
done

mv *.pdf pdf
mv *.aux aux
mv *.log aux