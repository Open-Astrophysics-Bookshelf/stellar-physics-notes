BASE = stellar-notes
COMPILE = xelatex
OPS =  --file-line-error --synctex=1
RM = rm -f

CHAPTERS = 	introduction \
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
			neutron-capture \
			galactic-chemical-evolution \
			neutron-star \
			perturbations \
			technical-notes \
			thermodynamics \
			rad-transfer-moments \
			shocks

TEX_SRC = $(foreach chap, $(CHAPTERS), $(wildcard $(chap)/*.tex))

FIGURES = 	convection/figs/convection-1.jpg \
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
			neutron-star/figs/Roche.pdf \
			perturbations/figs/eulerian.pdf \
			perturbations/figs/lagrangian.pdf \
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
