%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% astro-bookshelf.cls
%
% Formating class for notes posted on Open-Astrophysics-Bookshelf.
%
% Edward Brown
% Michigan State University
%
\def\fileversion{1.0}
\def\filedate{2015/5/27}
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{astro-bookshelf}[\filedate, \fileversion]
\RequirePackage{ifxetex}
\RequirePackage{xifthen}

\typeout{%
  Document Class: `astro-bookshelf' v\fileversion \space <\filedate>}

% Define fonts. The option profonts specifies the use of Chapparal Pro, Raleway Medium,
% and Source Code Pro for the serif, san serif, and fixed width fonts.
\newboolean{@profonts}
\setboolean{@profonts}{false}
\DeclareOption{profonts}{\setboolean{@profonts}{true}}
\newboolean{@stix}
\setboolean{@stix}{false}
\DeclareOption{stix}{\setboolean{@stix}{true}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions
\LoadClass{tufte-book}
\RequirePackage{natbib}
\RequirePackage{amssymb}
\ifxetex
    \RequirePackage{mathspec}
\fi

\RequirePackage{graphicx}
\RequirePackage{wallpaper}
\RequirePackage{ccicons}
\RequirePackage{fancyvrb}

\ifxetex
    \defaultfontfeatures{Scale=MatchLowercase}
    \renewcommand{\allcapsspacing}[1]{{\addfontfeature{LetterSpace=20.0}#1}}
    \renewcommand{\smallcapsspacing}[1]{{\addfontfeature{LetterSpace=5.0}#1}}
    \renewcommand{\textsc}[1]{\smallcapsspacing{\textsmallcaps{#1}}}
    \renewcommand{\smallcaps}[1]{\smallcapsspacing{\scshape\MakeTextLowercase{#1}}}
    
    \ifthenelse{\boolean{@profonts}}
    {
        \typeout{loading Chaparral Pro, Source Code Pro, and Raleway Medium}
        \setmainfont[Mapping=tex-text]{Chaparral Pro}
        \setmonofont[Mapping=tex-text]{Source Code Pro}
        \setsansfont[Mapping=tex-text]{Raleway Medium}
        \setmathsfont(Digits,Latin)[Numbers={Lining,Proportional}, Scale=MatchLowercase, Mapping=tex-text]{Chaparral Pro}
        \setmathrm{Chaparral Pro}    
    }{
        \typeout{loading Palatino, Courier, and Helvetica}
        \setmainfont[Mapping=tex-text]{TeX Gyre Pagella}
        \setmonofont[Mapping=tex-text]{TeX Gyre Cursor}
        \setsansfont[Mapping=tex-text]{TeX Gyre Heros}
        \setmathsfont(Digits,Latin)[Numbers={Lining,Proportional}, Scale=MatchLowercase, Mapping=tex-text]{TeX Gyre Pagella}
        \setmathrm{TeX Gyre Pagella}
    }
    \ifthenelse{\boolean{@stix}}
    {
    \setmathsfont(Greek)[Scale=MatchLowercase,Mapping=tex-text]{STIXGeneral}
    % for bold Greeks
    \fontspec{STIXGeneral}
    \SetSymbolFont{Greek:m:n}{bold}{EU1}{\zf@family}{bx}{n}
    \SetSymbolFont{Greek:m:it}{bold}{EU1}{\zf@family}{bx}{it}
    }{}
\fi


% for having inline author citations
\newcommand{\citetalt}[1]{\citeauthor{#1}\cite{#1}}

% for code listings
\fvset{numbers=left}

% Offset box for inline exercises
\newcounter{exercise}[chapter]
\renewcommand{\theexercise}{\thechapter.\arabic{exercise}}

\newcommand{\listexercisename}{List of Exercises}
\newcommand\listofexercises{%
  \ifthenelse{\equal{\@tufte@class}{book}}%
    {\chapter*{\listexercisename}}%
    {\section*{\listexercisename}}%
    \@starttoc{loe}%
}
% \newlistof[chapter]{exercise}{loe}{\listofexercises}

\newcommand{\exercisedescription}[1]{%
\addcontentsline{loe}{exercise}{\protect\numberline{\theexercise}{\ignorespaces #1}}
}

\newenvironment{exercisebox}[1][]{%
\vspace{\baselineskip}
\noindent\begin{minipage}{\linewidth}\small\raggedright
\refstepcounter{exercise}
\ifnum\value{exercise} = 1%
\addtocontents{loe}{\protect\addvspace{10\p@}}%
\fi
\noindent\rule[0.6ex]{\linewidth}{0.5pt}
\allcaps{exercise \theexercise---}
\exercisedescription{#1}}
{\noindent\rule[0.6ex]{\linewidth}{0.5pt}
\end{minipage}
}

\let\l@exercise\l@figure

