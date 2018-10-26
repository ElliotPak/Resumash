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

# change this variable to change the parts used to build your resume
PARTS="head intro education skills work projects honours tail"
# change this variable to specify alternate versions to be built
TYPES="site"

# you shouldn't need to change anything past this point
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

echo "$MAIN" > tex-compile/$PARTSDIR/resume.tex
echo "$EXTRA" > tex-compile/$PARTSDIR/resume-extra.tex
pdflatex tex-compile/$PARTSDIR/resume.tex
pdflatex tex-compile/$PARTSDIR/resume-extra.tex

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
    echo "$THISTYPE" > tex-compile/$PARTSDIR/resume-$type.tex
    echo "$THISTYPEEXTRA" > tex-compile/$PARTSDIR/resume-$type-extra.tex
    pdflatex tex-compile/$PARTSDIR/resume-$type.tex
    pdflatex tex-compile/$PARTSDIR/resume-$type-extra.tex
done

mv *.pdf pdf/$PARTSDIR
mv *.aux aux/$PARTSDIR
mv *.log aux/$PARTSDIR
