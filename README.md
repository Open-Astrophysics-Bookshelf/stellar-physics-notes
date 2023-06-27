# Stellar Astrophysics

Part of the [Open Astrophysics Bookshelf](http://open-astrophysics-bookshelf.github.io/).  A pdf of these notes is available at [https://web.pa.msu.edu/people/ebrown/docs/stellar-notes.pdf](https://web.pa.msu.edu/people/ebrown/docs/stellar-notes.pdf).

These notes were written while teaching a graduate-level astronomy course on stars at Michigan State University.  The only background preparation for this course is undergraduate physics and a course on radiative processes, and so portions of these notes could be useful for upper-level undergraduates.

The text layout uses the [`tufte-book`](https://tufte-latex.github.io/tufte-latex/) LaTeX class:  the main feature is a large right margin in which the students can take notes; this margin also holds small figures and sidenotes. Exercises are embedded throughout the text.  These range from "reading exercises" to longer, more challenging problems. Because the exercises are spread throughout the text, there is a "List of Exercises" in the front matter to help with looking for specific problems.

In addition to the exercises, there are four numerical "experiments" that use the `MESA` stellar evolution code (first three now use the current MESA r15140, released 07 Dec 2020; the 4th will be updated soon), available from [http://mesa.sourceforge.net/](http://mesa.sourceforge.net/). These numerical exercises are prefaced with the `MESA` logo, used by kind permission of the MESA developers. Each MESA problem has an accompanying directory in the source for this text, as indicated below.

chapter | MESA project | Directory
------- | ------------ | ---------
1 | *A contracting pre-main-sequence star* | `introduction/1M-pms/`
3 | *Convection in a pre-main-sequence star* | `convection/1M-convection/`
4 | *Entropy, radius, and gravithermal specific heat* | `Lane-Emden/0.3M-entropy/`
5 | *Radiation pressure and the Eddington luminosity for massive stars* | `radiation/beta-eddington/`


The course notes were originally meant as a supplement to the main text, Hansen, Kawaler, and Trimble (2004); in some editions of the course I also drew from Clayton (1983) and Kippenhahn and Weigert (1994).  These notes therefore tend to expand upon topics not already covered there.  In the second half of the course, the students typically gave presentations on current topics in stellar evolution, and I supplemented those with readings from the MESA instrument papers (Paxton et al. 2011, 2013, 2015, 2018, 2019).  As a result my notes on topics of stellar evolution have lagged behind the rest of the text; I will update the repository as these chapters become ready.

If you do use these notes, I'd appreciate hearing about it!  This helps justify my efforts in maintaining them and adding new material.

## License

Except where explicitly noted, this work is licensed under the Creative Commons
Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) license.

## Requirements for installing

0. Either pdfLaTeX or XeLaTeX.
1. Packages `ifxetex`, `xifthen`, `natbib`, `amssymb`, `graphicx`, `wallpaper`, `ccicons`, `tcolorbox`, `fancyvrb`; plus `mathspec` if you are using XeLaTeX. These packages are included with the [`TeXLive` distribution](https://www.tug.org/texlive/).
2. [`tufte-book`](https://tufte-latex.github.io/tufte-latex/) LaTeX class and dependencies
3. The [`starType`](https://github.com/nworbde/starType) macros.  You can install this from the source; alternatively, a shell script `install_local_starType` is provided to automatically fetch the macros into the directory of this package.

## To build

1. For a default installation, simply `make`.  This will build the document using pdfLaTeX.
2. If you wish to use XeLaTeX, change line 2 of the makefile to read `COMPILE=xelatex`. In this case you will need the TeX Gyre Fonts installed. You may also need to modify the latex class file `tufte-common.def` so that  `fontspec` is loaded with the correct options. A patch file, `tufte-patch`, is included. To use, `patch /path/to/tufte-common.def tufte-patch` (you may need to run this using `sudo`).

    1. If you have Chaparral Pro, Source Code Pro, and Raleway Medium fonts available, add the option `profonts` to the `\documentclass` directive in `stellar-notes.tex`.
    2. If you wish to use the STIX fonts for greek letters, add the option `stix` to the `\documentclass` directive in `stellar-notes.tex`.
