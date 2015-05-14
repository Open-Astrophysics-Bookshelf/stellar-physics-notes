BASE = stellar-notes
COMPILE = xelatex
OPS =  --file-line-error --synctex=1

VPATH = Figures

CHAPTERS = 	introduction.tex \
			equations.tex \
			convection.tex \
			Lane-Emden.tex \
			eos.tex \
			radiation.tex \
			plasma.tex \
			atmosphere.tex \
			PMScontraction.tex \
			nuclear.tex \
			main-sequence.tex \
			post-main-sequence.tex \
			neutron-capture.tex \
			galactic-chemical-evolution.tex \
			neutron-star.tex \
			perturbations.tex \
			technical-notes.tex \
			thermodynamics.tex \
			rad-transfer-moments.tex \
			shocks.tex

FIGURES = 	LE_all.pdf \
			spectral_distribution.pdf \
			convection-2.jpg \
			convective.pdf \
			eulerian.pdf \
			lagrangian.pdf \
			turbulence-maker.pdf \
			roche-sketch.pdf \
			coulomb_integrand.pdf \
			scattering.pdf \
			mean-free-path.pdf \
			shear-diagram.pdf \
			intensity-schematic.pdf \
			shock-formation.pdf \
			piston.pdf \

BIBS = bibs/stellar.bib

$(BASE).pdf: $(BASE).tex $(CHAPTERS) $(FIGURES) $(BIBS)
	git rev-parse --short=8 HEAD > git-info.tex
	$(COMPILE) $(OPS) $(BASE).tex
	bibtex $(BASE).aux
	$(COMPILE) $(OPS) $(BASE).tex
	$(COMPILE) $(OPS) $(BASE).tex
