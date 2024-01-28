TEX=latex
BIB=bibtex
FILE=driver
L1=nw/001-LIE_1
LIE1=$(L1).nw $(L1)/environ.nw $(L1)/index.nw
NOWEBOPTS=-latex -n

all: doc

code:
	notangle -RTEXT/lie-1.miz $(LIE1) | tr -d '\r' > text/lie_1.miz
	notangle -RDICT/lie-1.voc $(LIE1) | tr -d '\r' > dict/lie_1.voc

rm_defs:
	-rm *.defs
	touch 001.defs
defs: rm_defs
	nodefs $(LIE1) > 001.defs
	sort -u 001.defs | cpif 001.defs

extract_text: defs
	noweave $(NOWEBOPTS) -indexfrom 001.defs $(LIE1) > tex/lie-001.tex

doc: extract_text
	$(TEX) $(FILE)
	$(TEX) $(FILE)
	dvipdfmx $(FILE).dvi
