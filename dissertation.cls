%
% TODO
%	GENERAL
%		Implement a variable for name and title (like in \maketitle)
%
%	BIBTEX
%		has the ibidem been used correctly?
%
%	HEADER AND FOOTER
%		None on the title page
%		None on the table of content
%		None on the abstract
%		Bibliography should have a separate page counter
%		Use said variables in header and/or footer
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dissertation}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax

\LoadClass[a4paper, 12pt]{book}

% LANGUAGE & ENCODING
\RequirePackage[utf8]{inputenc}
\RequirePackage[ngerman]{babel}
\RequirePackage[T1]{fontenc}
\RequirePackage{comment}

% PDF FUNCTIONS
\RequirePackage[breaklinks=true,colorlinks=true,linkcolor=black,anchorcolor=black,citecolor=black,filecolor=black,menucolor=black,runcolor=black,urlcolor=black]{hyperref}

% INDEX
\RequirePackage{imakeidx}

\makeindex

% DOCUMENT FORMATTING
\RequirePackage[a4paper, hmargin={3cm, 3cm}, vmargin={2.5cm, 2cm}, ignoreheadfoot=false]{geometry}
\RequirePackage{setspace}
\RequirePackage{parskip}

\onehalfspacing

% HEADINGS
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

% QUOTES
\RequirePackage[german=quotes]{csquotes}
\RequirePackage{etoolbox}

\expandafter\def\expandafter\quote\expandafter{\quote\singlespacing}

% FOOTNOTES
\RequirePackage[hang, flushmargin]{footmisc}

% BIBLATEX
\RequirePackage[backend=biber, style=verbose-ibid, citetracker]{biblatex}

\addbibresource{citavi/literatur.bib}

% HEADER & FOOTER
\RequirePackage{fancyhdr}

\newcommand{\headfootfont}{\fontsize{10}{12}\selectfont}

\fancypagestyle{plain}{%
	\fancyhf{}%
	\fancyhead[R]{\headfootfont NAME HERE}%
	\fancyfoot[C]{\headfootfont \thepage} %
}

\pagestyle{fancy}

\lhead{\headfootfont}
\chead{\headfootfont}
\rhead{\headfootfont Stefanie Ueberall}

\lfoot{\headfootfont}
\cfoot{\headfootfont\thepage}
\rfoot{\headfootfont}

% COMMANDS
\RequirePackage{xifthen}

\newcommand{\terminus}[2][]{%
	\textsl{\ifthenelse{\equal{#1}{}}{\index{#2}}{\index{#1!#2}}#2}%
}