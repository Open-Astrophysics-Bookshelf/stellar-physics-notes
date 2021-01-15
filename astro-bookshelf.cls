%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% astro-bookshelf.cls
%
% Formating class for notes posted on Open-Astrophysics-Bookshelf.
%
% Edward Brown
% Michigan State University
%
\def\fileversion{1.2}
\def\filedate{2021/01/14}
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{astro-bookshelf}[\filedate, \fileversion]
\RequirePackage{ifxetex}
\RequirePackage{xifthen}

\typeout{%
  Document Class: `astro-bookshelf' v\fileversion \space <\filedate>}

% Flag to indicate we are making a handout
\newboolean{@handout}
\setboolean{@handout}{false}
\DeclareOption{handout}{\setboolean{@handout}{true}}

% Define fonts. The option profonts specifies the use of Chapparal Pro, Raleway Medium,
% and Source Code Pro for the serif, san serif, and fixed width fonts.
\newboolean{@profonts}
\setboolean{@profonts}{false}
\DeclareOption{profonts}{\setboolean{@profonts}{true}}
\newboolean{@stix}
\setboolean{@stix}{false}
\DeclareOption{stix}{\setboolean{@stix}{true}}

\ProcessOptions
\ifthenelse{\boolean{@handout}}
{
    \LoadClass{tufte-handout}
%    \DeclareOption*{\PassOptionsToClass{\CurrentOption}{tufte-handout}}
}
{
    \LoadClass{tufte-book}
%    \DeclareOption*{\PassOptionsToClass{\CurrentOption}{tufte-book}}
}
\RequirePackage{natbib}
\RequirePackage{amssymb}
\ifxetex
    \RequirePackage{mathspec}
\fi

\RequirePackage{graphicx}
\RequirePackage{wallpaper}
\RequirePackage{ccicons}
\RequirePackage{tcolorbox}
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
        \setmathtt{Source Code Pro}
    }{
        \typeout{loading Palatino, Courier, and Helvetica}
        \setmainfont[Mapping=tex-text]{TeX Gyre Pagella}
        \setmonofont[Mapping=tex-text]{TeX Gyre Cursor}
        \setsansfont[Mapping=tex-text]{TeX Gyre Heros}
        \setmathsfont(Digits,Latin)[Numbers={Lining,Proportional}, Scale=MatchLowercase, Mapping=tex-text]{TeX Gyre Pagella}
        \setmathrm{TeX Gyre Pagella}
        \setmathtt{TeX Gyre Cursor}
    }
    \ifthenelse{\boolean{@stix}}
    {
    \setmathsfont(Greek)[Scale=MatchLowercase,Mapping=tex-text]{STIXGeneral}
    % for bold Greeks
    \fontspec{STIXGeneral}
    \SetSymbolFont{Greek:m:n}{bold}{TU}{\zf@family}{bx}{n}
    \SetSymbolFont{Greek:m:it}{bold}{TU}{\zf@family}{bx}{it}
    }{}
\fi

% settings for sidebar text boxes
\tcbuselibrary{breakable}
\tcbset{colback=yellow!5!white,fonttitle=\bfseries}

% for having inline author citations
\newcommand{\citetalt}[1]{\citeauthor{#1}\cite{#1}}

% for code listings
\fvset{numbers=left}

% we increase \@tempdima from 2em to 2.4em to accomodate the width of the figure numbers
\renewcommand{\@tufte@lof@line}[2]{%
  % #1 is the figure/table number and its caption text
  % #2 is the page number on which the figure/table appears
  \leftskip 0.0em
  \rightskip 0em
  \parfillskip 0em plus 1fil
  \parindent 0.0em
  \@afterindenttrue
  \interlinepenalty\@M
  \leavevmode
  \@tempdima 2.4em
  \advance\leftskip\@tempdima
  \null\nobreak\hskip -\leftskip
  {#1}\nobreak\qquad\nobreak#2%
  \par%
}

\renewcommand*\l@figure{\@tufte@lof@line}

\renewcommand*{\listfigurename}{Figures}
\renewcommand*{\listtablename}{Tables}

% Offset box for inline exercises
\ifthenelse{\boolean{@handout}}
{
    \newcounter{exercise}
}
{
    \newcounter{exercise}[chapter]
    \renewcommand{\theexercise}{\thechapter.\arabic{exercise}}
}

\newcommand{\listexercisename}{Exercises}
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
\setlength{\parindent}{1.0pc}
\noindent\rule[0.6ex]{\linewidth}{0.5pt}
\allcaps{exercise \theexercise---}
\exercisedescription{#1}}
{\noindent\rule[0.6ex]{\linewidth}{0.5pt}
\end{minipage}
}

\let\l@exercise\l@figure

% Environment for sidebar
\ifthenelse{\boolean{@handout}}
{
    \newcounter{sidebar}
}
{
    \newcounter{sidebar}[chapter]
    \renewcommand{\thesidebar}{\thechapter.\arabic{sidebar}}
}

\newcommand{\listsidebarname}{Boxes}
\newcommand\listofsidebars{%
  \ifthenelse{\equal{\@tufte@class}{book}}%
    {\chapter*{\listsidebarname}}%
    {\section*{\listsidebarname}}%
    \@starttoc{lob}%
}

\newcommand{\sidebardescription}[1]{%
\addcontentsline{lob}{sidebar}{\protect\numberline{\thesidebar}{\ignorespaces #1}}
}

\newenvironment{sidebar}[1][]{%
\vspace{\baselineskip}
\refstepcounter{sidebar}
\begin{tcolorbox}[breakable,title=Box \thesidebar\ #1,title after break=Box \thesidebar\ continued]
\ifnum\value{sidebar} = 1%
\addtocontents{lob}{\protect\addvspace{10\p@}}%
\fi
\sidebardescription{#1}\setlength{\parindent}{1.0pc}}
{\end{tcolorbox}
}

\let\l@sidebar\l@figure

% Environment for MESA exercises
\ifthenelse{\boolean{@handout}}
{
    \newcounter{mesa}
}
{
    \newcounter{mesa}[chapter]
    \renewcommand{\themesa}{\thechapter.\arabic{mesa}}
}

\newcommand{\listmesaname}{MESA experiments}
\newcommand\listofmesa{%
  \ifthenelse{\equal{\@tufte@class}{book}}%
    {\chapter*{\listmesaname}}%
    {\section*{\listmesaname}}%
    \@starttoc{lom}%
}

\newcommand{\mesadescription}[1]{%
\addcontentsline{lom}{mesa}{\protect\numberline{\themesa}{\ignorespaces #1}}
}

\newenvironment{mesaproject}[1][]{%
\vspace{\baselineskip}
\refstepcounter{mesa}
\section*{\raisebox{-0.015ex}{\includegraphics[height=1.4ex]{mesa_logo2}} Experiment \themesa--- #1}
\ifnum\value{mesa} = 1%
\addtocontents{lom}{\protect\addvspace{10\p@}}%
\fi
\mesadescription{#1}\setlength{\parindent}{1.0pc}}
{}

\let\l@mesa\l@figure
