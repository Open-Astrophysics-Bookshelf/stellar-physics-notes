# Stellar Astrophysics

Part of the [Open Astrophysics Bookshelf](http://open-astrophysics-bookshelf.github.io/).

These notes were written while teaching a graduate-level astronomy course on stars at Michigan State University.  The only background preparation for this course is undergraduate physics and a course on radiative processes, and so portions of these notes could be useful for upper-level undergraduates.  
The text layout uses the [`tufte-book`](https://tufte-latex.github.io/tufte-latex/) LaTeX class:  the main feature is a large right margin in which the students can take notes; this margin also holds small figures and sidenotes. Exercises are embedded throughout the text.  These range from "reading exercises" to longer, more challenging problems.  In addition, there are several numerical exercises that use the `MESA` stellar evolution code, available from [http://mesa.sourceforge.net/](http://mesa.sourceforge.net/).  These numerical exercises are prefaced with the `MESA` logo, used by kind permission of the MESA council. Because the exercises are spread throughout the text, there is a "List of Exercises" in the front matter to help with looking for specific problems.

The course notes were originally meant as a supplement to the main text, Hansen, Kawaler, and Trimble (2004); in some editions of the course I also drew from Clayton (1983) and Kippenhahn and Weigert (1994).  These notes therefore tend to expand upon topics not already covered there.  In the second half of the course, the students typically gave presentations on current topics in stellar evolution, and I supplemented those with readings from the MESA instrument papers (Paxton et al. 2010, 2012).  As a result my notes on topics of stellar evolution have lagged behind the rest of the text; I will update the repository as they are ready.

## License

Except where explicitly noted, this work is licensed under the Creative Commons
Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) license.

## Requirements for installing

0. Either pdfLaTeX or XeLaTeX.
1. [`tufte-book`](https://tufte-latex.github.io/tufte-latex/) LaTeX class
2. The [`starType`](https://github.com/nworbde/starType) macros.  You can install this from the source; alternatively, a shell script `install_local_starType` is provided to automatically fetch the macros into the directory of this package.
4. If you process the document with XeLaTeX, you will need either the TeX Gyre font family or the fonts Chaparral Pro, Source Code Pro, and Raleway Medium.

## To build

1. For a default installation, simply `make`.  This will build the document using pdfLaTeX.
2. If you wish to use XeLaTeX, change line 2 of the makefile to read `COMPILE=xelatex`

    1. If you have Chaparral Pro, Source Code Pro, and Raleway Medium fonts available, add the option `profonts` to the `\documentclass` directive in AST208-notes.tex.
    2. If you wish to use the STIX fonts for greek letters, add the option `stix` to the `\documentclass` directive in AST208-notes.tex.
