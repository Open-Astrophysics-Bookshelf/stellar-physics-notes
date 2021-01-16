BASE = stellar-notes
COMPILE = pdflatex
OPS =  --file-line-error --synctex=1
RM = rm -f

CHAPTERS = 	frontmatter \
			introduction \
			equations \
			convection \
			Lane-Emden \
			eos \
			radiation \
			plasma \
			atmosphere \
			PMScontraction \
			nuclear \
			main-sequence \
			post-main-sequence \
			perturbations \
			initial-mass-function \
			binaries \
			technical-notes

TEX_SRC = $(foreach chap, $(CHAPTERS), $(wildcard $(chap)/*.tex))

FIGURES = 	frontmatter/cover-art.jpg \
			introduction/figs/Grid1_00240.png \
			convection/figs/Convection_000760.png \
			convection/figs/convection-1.jpg \
			convection/figs/convection-2.jpg \
			convection/figs/convective.pdf \
			convection/figs/turbulence-maker.pdf \
			Lane-Emden/figs/LE_all.pdf \
			radiation/figs/intensity-schematic.pdf \
			plasma/figs/scattering.pdf \
			plasma/figs/mean-free-path.pdf \
			plasma/figs/shear-diagram.pdf \
			atmosphere/figs/spectral_distribution.pdf \
			nuclear/figs/coulomb_integrand.pdf \
			binaries/figs/Roche.pdf \
			perturbations/figs/eulerian.pdf \
			perturbations/figs/lagrangian.pdf \
			binaries/figs/Roche.pdf \
			technical-notes/figs/steepening.pdf \
			technical-notes/figs/piston.pdf

BIBS = bibs/stellar.bib

default: $(BASE).pdf

$(BASE).pdf: $(BASE).tex $(TEX_SRC) $(FIGURES) $(BIBS)
	git rev-parse --short=8 HEAD > git-info.tex
	$(COMPILE) $(OPS) $(BASE).tex
	bibtex $(BASE).aux
	$(COMPILE) $(OPS) $(BASE).tex
	$(COMPILE) $(OPS) $(BASE).tex

clean:
	$(RM) *.aux *.log *.dvi *.bbl *.blg *.toc *.log *.synctex* *.out

realclean: clean
	$(RM) $(BASE).pdf
