default: example-resume.pdf
	[ -d "aux" ] || mkdir aux
	[ -d "pdf" ] || mkdir pdf
	mv *.pdf pdf
	mv *.log aux
	mv *.aux aux

%.pdf : %.tex
	pdflatex $<

clean : 
	rm -r aux
	rm -r pdf
