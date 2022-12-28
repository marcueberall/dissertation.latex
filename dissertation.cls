%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MARC & STEFANIE UEBERALL
%
% CREATED WITH A SHITLOAD OF COPY-PASTA FROM STACKEXCHANGE
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dissertation}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax

\LoadClass[a4paper, 12pt]{book}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% LANGUAGE & ENCODING
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[utf8]{inputenc}
\RequirePackage[ngerman]{babel}
\RequirePackage[ngerman]{isodate} % [ngerman, num] if you want to swith to a pure numeric format
\RequirePackage[T1]{fontenc}
\RequirePackage{comment}

% Because inputenc does provide shit when it comes to special characters ... user "be_slayed" had the code for exactly the needed
% character on his blog https://staefcraeft.blogspot.com/2010/09/philology-and-latex-on-proto-indo.html
\RequirePackage{tipa}

\newcommand{\hith}{\tipaLoweraccent[+.1ex]{\u{}}{h}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MISC
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{graphicx}
\RequirePackage{lipsum}

\newenvironment{abstract}{}{}
\RequirePackage{abstract}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% HYPERREFS
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[hyperfootnotes=false,breaklinks=true,colorlinks=true,linkcolor=black,anchorcolor=black,citecolor=black,filecolor=black,menucolor=black,runcolor=black,urlcolor=black]{hyperref}

\RequirePackage{url}
\urlstyle{same}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% DOCUMENT
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[a4paper, hmargin={3cm, 3cm}, vmargin={2.5cm, 2cm}, ignoreheadfoot=false]{geometry}
\RequirePackage{setspace}
\RequirePackage{parskip}

\onehalfspacing

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% HEADINGS
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{sectsty}
\RequirePackage{titlesec}

\titleformat{\chapter}[block]{%
	\normalfont\fontsize{16}{19}\bfseries}{\thechapter}{16pt}{\fontsize{16}{19}%
}

\sectionfont{\fontsize{14}{16}\selectfont}
\subsectionfont{\fontsize{12}{14}\selectfont}
\subsubsectionfont{\fontsize{12}{14}\selectfont}

\setcounter{secnumdepth}{5}
\setcounter{tocdepth}{5}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% QUOTES
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[german=quotes]{csquotes}
\RequirePackage{etoolbox}

\expandafter\def\expandafter\quote\expandafter{\quote\singlespacing}

\newcommand{\danishsinglequote}[1]{›#1‹}
\newcommand{\danishdoublequote}[1]{»#1«}
\newcommand{\frenchsinglequote}[1]{‹#1›}
\newcommand{\frenchdoublequote}[1]{«#1»}
\newcommand{\germansinglequote}[1]{‚#1‘}
\newcommand{\germandoublequote}[1]{„#1“}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FOOTNOTES
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[hang, flushmargin]{footmisc}

\RequirePackage{footnote}
\makesavenoteenv{tabular}
\makesavenoteenv{table}

\RequirePackage{chngcntr}
\counterwithout{footnote}{chapter}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% BIBLATEX
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[backend=biber, style=verbose-ibid, hyperref=true, isbn=false, doi=false, ibidpage=true, citetracker, citepages=separate]{biblatex}

\addbibresource{jabref/literatur.bib}

\DefineBibliographyStrings{german}{
	andothers = {{et al\adddot}},
}

\AtEveryCitekey{\clearlist{publisher}}
\AtEveryBibitem{\clearlist{publisher}}

\AtEveryCitekey{\ifentrytype{article}{\clearfield{url}}{}}
\AtEveryBibitem{\ifentrytype{article}{\clearfield{url}}{}}

\AtEveryCitekey{\ifentrytype{book}{\clearfield{series}\clearfield{volume}\clearfield{url}}{}}
\AtEveryBibitem{\ifentrytype{book}{\clearfield{series}\clearfield{volume}\clearfield{url}}{}}

\AtEveryCitekey{\ifentrytype{incollection}{\clearfield{series}\clearfield{volume}}{}}
\AtEveryBibitem{\ifentrytype{incollection}{\clearfield{series}\clearfield{volume}}{}}

\AtEveryCitekey{\ifentrytype{online}{\clearfield{year}}{}}
\AtEveryBibitem{\ifentrytype{online}{\clearfield{year}}{}}

\DeclareFieldFormat*{title}{#1}
\DeclareFieldFormat*{citetitle}{#1}

\DeclareFieldFormat*{booktitle}{#1}
\DeclareFieldFormat*{citebooktitle}{#1}

\DeclareFieldFormat{journaltitle}{#1}

\DeclareNameAlias{sortname}{first-last}

\renewbibmacro*{publisher+location+date}{%
  \printlist{location}%
  \iflistundef{publisher}
    {\setunit*{\space}}
    {\setunit*{\addcolon\space}}%
  \printlist{publisher}%
  \setunit*{\space}%
  \usebibmacro{date}%
  \newunit}

\renewbibmacro*{cite}{%
	\usebibmacro{cite:citepages}%
	\global\togglefalse{cbx:loccit}%
	\ifciteseen
		{\iffieldundef{shorthand}
			{\ifboolexpr{
				test {\ifciteibid}
				and
				not test {\iffirstonpage}
			}
			{\usebibmacro{cite:ibid}}
			{\usebibmacro{cite:full}}}
		{\usebibmacro{cite:shorthand}}}
	{\usebibmacro{cite:full}}}


\RequirePackage{xpatch}

\xpatchbibdriver{article}
	{\usebibmacro{title}%
	\newunit}
	{\usebibmacro{title}%
	\printunit{\addcomma\space}}
	{}
	{}

\xpatchbibdriver{incollection}
	{\usebibmacro{title}%
	\newunit}
	{\usebibmacro{title}%
	\printunit{\addcomma\space}}
	{}
	{}

\xpatchbibdriver{incollection}
	{\usebibmacro{maintitle+booktitle}%
	\newunit}
	{\usebibmacro{maintitle+booktitle}%
	\printunit{\addcomma\space}}
	{}
	{}

\xpatchbibdriver{incollection}
	{\usebibmacro{byeditor+others}%
	\newunit}
	{\usebibmacro{byeditor+others}%
	\printunit{\addcomma\space}}
	{}
	{}

\xpatchbibdriver{inbook}
	{\usebibmacro{title}%
	\newunit}
	{\usebibmacro{title}%
	\printunit{\addcomma\space}}
	{}
	{}

\xpatchbibdriver{book}
	{\usebibmacro{maintitle+title}%
	\newunit}
	{\usebibmacro{maintitle+title}%
	\printunit{\addcomma\space}}
	{}
	{}

\xpatchbibdriver{book}
	{\usebibmacro{byeditor+others}%
	\newunit}
	{\usebibmacro{byeditor+others}%
	\printunit{\addcomma\space}}
	{}
	{}

\xpatchbibdriver{online}
	{\usebibmacro{title}%
	\newunit}
	{\usebibmacro{title}%
	\printunit{\addcomma\space}}
	{}
	{}

\xpatchbibdriver{online}
	{\usebibmacro{byeditor+others}%
	\newunit}
	{\usebibmacro{byeditor+others}%
	\printunit{\addcomma\space}}
	{}
	{}

\renewcommand*{\labelnamepunct}{\addcolon\space}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% HEADER & FOOTER
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{fancyhdr}

\newcommand{\headfootfont}{\fontsize{10}{12}\selectfont}

\pagestyle{fancy}

\lhead{\headfootfont}
\chead{\headfootfont}
\rhead{\headfootfont \@author}

\lfoot{\headfootfont}
\cfoot{\headfootfont\thepage}
\rfoot{\headfootfont}

\renewcommand\chapter{\if@openright\cleardoublepage\else\clearpage\fi
	\thispagestyle{fancy}%
	\global\@topnum\z@
	\@afterindentfalse
	\secdef\@chapter\@schapter}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% COMMANDS
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{xifthen}

%\newcommand{\terminus}[2][]{\textit{\ifthenelse{\equal{#1}{}}{\index{#2}}{\index{#1!#2}}#2}}
\newcommand{\terminus}[1]{\textit{#1}}
\newcommand{\kursiv}[1]{\textit{#1}}

\newcommand{\printtableofcontents}{
	\begingroup\makeatletter\let\ps@fancy\ps@plain\tableofcontents\clearpage\endgroup
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% COMMENTS
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{pdfcomment}
\RequirePackage{xcolor}

\newcommand{\kommentar}[1]{\pdfmargincomment[color=lime]{#1}}