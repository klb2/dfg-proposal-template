\NeedsTeXFormat{LaTeX2e}%[1999/12/01]
\ProvidesClass{dfgproposal}[2022/01/18 v0.2.1 class for research grant proposals to DFG]
% author: Karl-Ludwig Besser
% based on: template by Martin Hoelzer (hoelzer.martin@gmail.com)

\RequirePackage{kvoptions}
\RequirePackage{etoolbox}

\SetupKeyvalOptions{family=proposal,prefix=proposal@}
\DeclareBoolOption[false]{finalcompile}
\DeclareBoolOption[false]{firsttime}
\ProcessKeyvalOptions{proposal}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax

\PassOptionsToClass{notitlepage}{scrartcl}
\LoadClass[a4paper,11pt]{scrartcl}


\RequirePackage{babel}
\RequirePackage[babel]{microtype}


\RequirePackage{translations}

\RequirePackage{amsmath}
\RequirePackage{siunitx}
\RequirePackage{fp}

\RequirePackage{eurosym}

\RequirePackage[dvipsnames,svgnames]{xcolor}
\RequirePackage{tcolorbox}
\tcbuselibrary{skins}

\RequirePackage{geometry}
\RequirePackage{scrlayer-scrpage}
\RequirePackage[pagecontinue=false]{pageslts}
\RequirePackage{helvet}

\RequirePackage{tikz}
\usetikzlibrary{calc}

\RequirePackage[%
	backend = biber,
%	style = alphabetic,
	style = numeric-comp,
	giveninits = true,
	hyperref = true,
	maxbibnames = 99,
	url=false,
	doi=true,
	eprint=true,
	isbn=false,
	defernumbers=true,
	labelnumber,
%	sortcites, %optional
	sorting=none, %remove this to have things sorted, and use style=alphabetic
]{biblatex}
\RequirePackage[autostyle=true]{csquotes}


%%% LAYOUT AND GEOMETRY %%%
\ohead*{\pagemark}
\cfoot*{}
\chead{}

% Show DFG template version that the current LaTeX template is based on in the header.
% Will be deactivated when 'finalcompile' is passed as class option.
\ifproposal@finalcompile\else
	\ihead*{DFG 53.01 -- 03/25}
\fi

\pagestyle{plain}

% use DFG margins according to https://github.com/hoelzer/dfg/issues/56
\geometry{headheight=10mm, tmargin=25mm, lmargin=25mm, rmargin=20mm, bmargin=15mm}

\setlength{\parskip}{0.4em plus .2em minus .1em}
\setlength{\parindent}{0em}


%%% COLORS %%%
\definecolor{dfgblue}{RGB}{0, 77, 162}
\definecolor{dfglightblue}{RGB}{104, 163, 217}

%%% FONTS %%%
\setkomafont{section}{\normalsize\bfseries}
\setkomafont{subsection}{\normalsize\bfseries}
\renewcommand{\familydefault}{\sfdefault}
\renewcommand{\headfont}{\sffamily\footnotesize}

\addtokomafont{caption}{\small}
\setkomafont{captionlabel}{\bfseries}

\linespread{1.05}

\sisetup{%
	exponent-product = {\cdot},
	% use text mode to make numbers look better in funding section
	mode = text,
	% don't touch font family as well as series and shape settings
	reset-text-family = false,
	reset-text-series = false,
	reset-text-shape = false,
}

%%% MISC %%%
\renewcommand*{\labelalphaothers}{}

\clubpenalty = 10000
\widowpenalty = 10000
\displaywidowpenalty = 10000

% weniger underful hboxes
\tolerance=3000
\emergencystretch=15pt
\hbadness=2000 %% too many underfull hbox warnings

% keine zwei Trennstriche in untereinanderliegenden Zeilen
\hyphenpenalty 3000
\doublehyphendemerits 50000000




%%% TRANSLATIONS %%%
\DeclareTranslationFallback{titletop}{Antrag an die Deutsche Forschungsgemeinschaft}
\DeclareTranslation{English}{titletop}{Proposal to the Deutsche Forschungsgemeinschaft\\(German Research Foundation)}
\DeclareTranslation{German}{titletop}{Antrag an die Deutsche Forschungsgemeinschaft}
\DeclareTranslationFallback{titleongrant}{zur Förderung des Forschungsprojekts}
\DeclareTranslation{English}{titleongrant}{on the granting of a research project}
\DeclareTranslation{German}{titleongrant}{zur Förderung des Forschungsprojekts}

\DeclareTranslationFallback{titleproptype}{Projektantrag}
\ifproposal@firsttime
\DeclareTranslation{English}{titleproptype}{First-Time Research Grant}
\DeclareTranslation{German}{titleproptype}{Erstantrag}
\else
\DeclareTranslation{English}{titleproptype}{Research Grant}
\DeclareTranslation{German}{titleproptype}{Projektantrag}
\fi

\DeclareTranslationFallback{total}{Summe}
\DeclareTranslation{German}{total}{Summe}
\DeclareTranslation{English}{total}{Total}
\DeclareTranslation{German}{page}{Seite}
\DeclareTranslation{English}{page}{Page}
\DeclareTranslation{German}{of}{von}
\DeclareTranslation{English}{of}{of}
\DeclareTranslation{German}{researchgoal}{Ziel}
\DeclareTranslation{English}{researchgoal}{Goal}
\DeclareTranslation{German}{summary}{Zusammenfassung}
\DeclareTranslation{English}{summary}{Summary}


\DeclareTranslation{German}{titledescription}{Beschreibung des Vorhabens -- Projektantr\"age}
\DeclareTranslation{English}{titledescription}{Project Description -- Project Proposals}
\DeclareTranslation{German}{projectdescription}{Beschreibung des Vorhabens}
\DeclareTranslation{English}{projectdescription}{Project Description}


\newcommand{\total}{\GetTranslation{total}}

\newcommand{\pagenumtype}{arabic}
\renewcommand{\pagemark}{\GetTranslation{page}~\thepage~\GetTranslation{of}~\lastpageref{pagesLTS.\pagenumtype}}

% let \pagenumbering also reset \pagenumtype
\let\proposal@pagenumbering\pagenumbering
\renewcommand{\pagenumbering}[1]{\proposal@pagenumbering{#1}\renewcommand{\pagenumtype}{#1}}


%%% COMMANDS %%%

%% Fund calculations
% Ensure that if round-precision is specified, the give number of decimals is printed (necessary for prices in Euro)
%\sisetup{round-integer-to-decimal} % removed in version 3 of siunitx package
\DeclareSIUnit{\sieuro}{\mbox{\euro}}
% Place this environment in funds section to automatically add up costs using the macro 'position'.
\newenvironment{funds}[1][]
% Define variable funds for calculation. Store argument (description of total) in new command.
{\def\funds{0.00} \newcommand{\totaldescr}{#1}}
% Print total of environment with provided description. 
{\rule{\textwidth}{0.5pt} \par \total~\totaldescr \hfill \SI[round-mode=places, round-precision=2]{\funds}{\sieuro}}

% To be used inside a funds environment. Place text and add given price to totals.
\newcommand{\position}[2]{\par #1 \hfill \SI[round-mode=places, round-precision=2]{#2}{\sieuro} \FPeval{\funds}{\funds + #2}\par}
% Same as above but with multiples of a position.
\newcommand{\positionmul}[3]{\par #1 \hfill \num{#3} $\times$ \SI[round-mode=places, round-precision=2]{#2}{\sieuro} \FPeval{\funds}{\funds + #3*#2}\par}


%% Sections
\setcounter{secnumdepth}{4}
\DeclareSectionCommand[level=4, style=section, afterskip=\parskip, beforeskip=-3.25ex plus -1ex minus -.2ex, tocstyle=gobble,counterwithin=subsubsection]{subsubsubsection}
%\newcommand{\intextheading}[1]{\vskip 1em plus 1em minus .3em \textit{#1}\par} %TODO: do not end paragraph but add some vspace
\DeclareNewSectionCommand[level=5,style=section,afterskip=.2em plus .3em minus .1em,beforeskip=3ex plus .5ex minus .5ex,tocstyle=gobble]{intextheading}

\newcounter{researchgoal}
\newcommand{\goal}[1]{\refstepcounter{researchgoal}\textbf{\GetTranslation{researchgoal}~\arabic{researchgoal}} #1\par}


%% Work Packages
\xdef\Colored{0}
\ifnum\Colored > 0
\xdef\LWS{0.6mm}
\xdef\ColorYO{yellow!30!orange}
\xdef\ColorYR{yellow!70!red}
\xdef\ColorRY{red!90!yellow}
\xdef\ColorYB{yellow!90!brown}
\xdef\ColorYRB{yellow!90!red}
\xdef\ColorR{red}
\xdef\ColorO{orange}
\else
\xdef\LWS{0.4mm}
\xdef\ColorYO{gray!80!black}
\xdef\ColorYR{gray!70}
\xdef\ColorRY{gray!60!black}
\xdef\ColorYB{gray!90}
\xdef\ColorYRB{gray!50}
\xdef\ColorR{black}
\xdef\ColorO{gray!95!black}
\fi

\newcounter{wp}
\newenvironment{workpackage}[1][]{\refstepcounter{wp}
	\intextheading{WP~\thewp{}~#1.}
}{\par\ignorespacesafterend}
% with lamp
%\newenvironment{wpsummary}{
%	\begin{tcolorbox}[sidebyside, lefthand width=1.2cm, sidebyside align=top seam, enhanced,
%		segmentation code={\path[draw=black!50!white, very thick]($(segmentation.south) + (0, .3)$) -- ($(segmentation.north) - (0, .3)$);},
%		colback=white, coltitle=black, colbacktitle=white,
%		adjusted title={WP\,\thewp{} -- \GetTranslation{summary}}, fonttitle=\bfseries]
%		\begin{center}\input{lamp.tex}\end{center}
%		\tcblower
%	}{\end{tcolorbox}}

%w/o lamp
\newenvironment{wpsummary}{
	\begin{tcolorbox}[
		enhanced,
		colback=white, coltitle=black, colbacktitle=white,
		adjusted title={WP\,\thewp{} -- \GetTranslation{summary}},
		fonttitle=\bfseries]
	}{\end{tcolorbox}}




% redefine author command for title page
\def\author{\@dblarg\proposal@author}
\long\def\proposal@author[#1]#2{%
	%	\def\insertauthor{#2}%
	\def\proposal@origauthor{#2}
	\def\proposal@shortauthor{#1}%
}
\renewcommand*{\@author}{\proposal@origauthor}
%\newcommand{\@shortauthor}{\proposal@shortauthor}


\renewcommand*{\maketitle}{
\begin{titlepage}
	\setcounter{page}{0}
	\begin{center}
		\vspace*{3em}
		\large
		
		{\bfseries \GetTranslation{titletop}}
		
		Kennedyallee 40, 53175 Bonn
		
		\vspace{4ex}
		
		\GetTranslation{titleongrant}
		
		\vspace{9ex}
		
		\textbf{\@title}
		
		\medskip
		
		\GetTranslation{titleproptype}
		
		\vspace{9ex}
		
		{\renewcommand{\and}{\\[1em]\GetTranslation{and}\\[1em]}
			\@author
		}
		
		\vspace{9ex}
		
		\today
	\end{center}
\end{titlepage}
\clearpage

{
\textbf{\GetTranslation{titledescription}}\\[1em]
{\renewcommand{\and}{\\[1ex]}
	\proposal@shortauthor\\[1em]
}
\textbf{\@title}

\hrulefill
}

\textbf{\GetTranslation{projectdescription}}\par
}


%%% BIBLIOGRAPHY %%%
\DeclareFieldFormat{labelnumberwidth}{\mkbibbrackets{#1}}
\renewbibmacro*{cite}{%
	\printtext[bibhyperref]{%
		\printfield{labelprefix}%
		\ifcategory{reviewed}
		{\printfield{labelnumber}}
		{%
		 \ifcategory{nonreviewed}
		 {\printfield{labelnumber}}
		 {%
			\printfield{labelalpha}%
			\printfield{extraalpha}}}}}

\defbibenvironment{bibliographyNUM}
{\list
	{\printtext[labelnumberwidth]{%
			\printfield{labelprefix}%
			\printfield{labelnumber}}}
	{\setlength{\labelwidth}{\labelnumberwidth}%
		\setlength{\leftmargin}{\labelwidth}%
		\setlength{\labelsep}{\biblabelsep}%
		\addtolength{\leftmargin}{\labelsep}%
		\setlength{\itemsep}{\bibitemsep}%
		\setlength{\parsep}{\bibparsep}}%
	\renewcommand*{\makelabel}[1]{\hss##1}}
{\endlist}
{\item}

% necessary changes to print the selected references in bold typeface
% for references that should be bold, add their corresponding citation keys to \addtocategory{important}{%...} in proposal.tex
\DeclareBibliographyCategory{important}
\newcommand{\impbibitemstyle}{\bfseries}
\AtEveryBibitem{%
	\ifcategory{important}{\impbibitemstyle}{}%
}
\AtEveryCitekey{%
	\ifcategory{important}{\impbibitemstyle}{}%
}

% to also let the labels in the bibliography be printed in bold typeface
\AtBeginBibliography{%
	\DeclareFieldFormat{labelnumberwidth}{%
		\ifcategory{important}%
			{\impbibitemstyle\mkbibbrackets{#1}}%
			{\mkbibbrackets{#1}}}%
}
