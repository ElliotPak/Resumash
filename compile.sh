#!/usr/bin/env bash

PARTSDIR=""

if [ "$1" = "clean" ]; then
    rm -r tex-compile
    rm -r pdf
    rm -r aux
    exit 0
elif [ "$#" -ne 1 ]; then
    echo "Usage: $0 [parts directory]"
    exit 1
else
    PARTSDIR="$1"
fi

PARTS="head intro education skills work projects honours tail"
TYPES="site"

TEXHEAD="\\documentclass{elliot-cv}\\begin{document}"
TEXTAIL="\\end{document}"
MAIN=""
EXTRA=""

[ -d "tex-compile/$PARTSDIR" ] || mkdir -p tex-compile/$PARTSDIR
[ -d "pdf/$PARTSDIR" ] || mkdir -p pdf/$PARTSDIR
[ -d "aux/$PARTSDIR" ] || mkdir -p aux/$PARTSDIR

for part in $PARTS; do
    # add default text to all types
    MAIN="$MAIN$(cat $PARTSDIR/$part.tex)"
    EXTRA="$EXTRA$(cat $PARTSDIR/$part.tex)"

    # add extra text to extra (if it exists)
    if [ -f "$PARTSDIR/$part.extra.tex" ]; then
        EXTRA="$EXTRA$(cat $PARTSDIR/$part.extra.tex)"
    fi
done

echo "$MAIN" > tex-compile/$PARTSDIR/main.tex
echo "$EXTRA" > tex-compile/$PARTSDIR/extra.tex
pdflatex tex-compile/$PARTSDIR/main.tex
pdflatex tex-compile/$PARTSDIR/extra.tex

for type in $TYPES; do
    THISTYPE=""
    THISTYPEEXTRA=""
    for part in $PARTS; do
        # adds the type specific text if it exists, and default text otherwise
        if [ -f "$PARTSDIR/$part.$type.tex" ]; then
            THISTYPE="$THISTYPE$(cat $PARTSDIR/$part.$type.tex)"
            THISTYPEEXTRA="$THISTYPEEXTRA$(cat $PARTSDIR/$part.$type.tex)"
        else
            THISTYPE="$THISTYPE$(cat $PARTSDIR/$part.tex)"
            THISTYPEEXTRA="$THISTYPEEXTRA$(cat $PARTSDIR/$part.tex)"
        fi

        # adds type specific extra text to the extra if it exists, and default
        # extra otherwise (if that exists also)
        if [ -f "$PARTSDIR/$part.$type.extra.tex" ]; then
            THISTYPEEXTRA="$THISTYPEEXTRA$(cat $PARTSDIR/$part.$type.extra.tex)"
        else
            if [ -f "$PARTSDIR/$part.extra.tex" ]; then
                THISTYPEEXTRA="$THISTYPEEXTRA$(cat $PARTSDIR/$part.extra.tex)"
            fi
        fi
    done
    echo "$THISTYPE" > tex-compile/$PARTSDIR/$type.tex
    echo "$THISTYPEEXTRA" > tex-compile/$PARTSDIR/${type}extra.tex
    pdflatex tex-compile/$PARTSDIR/$type.tex
    pdflatex tex-compile/$PARTSDIR/${type}extra.tex
done

mv *.pdf pdf/$PARTSDIR
mv *.aux aux/$PARTSDIR
mv *.log aux/$PARTSDIR
