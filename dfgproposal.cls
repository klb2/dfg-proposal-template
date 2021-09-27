\NeedsTeXFormat{LaTeX2e}%[1999/12/01]
\ProvidesClass{dfgproposal}[2021/09/27 v0.1 class for research grant proposals to DFG]
% author: Karl-Ludwig Besser
% based on: template by Martin Hoelzer (hoelzer.martin@gmail.com)

\RequirePackage{kvoptions}
\RequirePackage{etoolbox}

\SetupKeyvalOptions{family=proposal,prefix=proposal@}
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
\RequirePackage[exponent-product={\cdot}]{siunitx}
\RequirePackage{fp}

\RequirePackage{eurosym}

\RequirePackage[usenames,dvipsnames,svgnames]{xcolor}
\RequirePackage{tcolorbox}
\tcbuselibrary{skins}

\RequirePackage{geometry}
\RequirePackage{scrlayer-scrpage}
\RequirePackage{lastpage}
\RequirePackage{helvet}

\RequirePackage{tikz}
\usetikzlibrary{calc}

\RequirePackage[%
	backend = biber,
	style = alphabetic,
%	style=numeric,
	giveninits = true,
	hyperref = true,
	maxbibnames = 10,
	url=false,
	doi=true,
	eprint=true,
%	sorting=none,%remove this to have things sorted, e.g. use style=alphabetic
]{biblatex}
\RequirePackage[babel]{csquotes}


%%% LAYOUT AND GEOMETRY %%%
\ohead*{\pagemark}
\cfoot*{}
\chead{}

\geometry{headheight=28pt, tmargin=70pt, lmargin=55pt, rmargin=55pt, bmargin=70pt}
\pagestyle{plain}

\setlength{\parskip}{0.5em}
\setlength{\parindent}{0em}


%%% FONTS %%%
\setkomafont{section}{\normalsize\bfseries}
\setkomafont{subsection}{\normalsize\bfseries}
\renewcommand{\familydefault}{\sfdefault}
\renewcommand{\headfont}{\sffamily\footnotesize}

\addtokomafont{caption}{\small}
\setkomafont{captionlabel}{\bfseries}


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
\renewcommand{\pagemark}{\GetTranslation{page} \thepage~\GetTranslation{of} \pageref{LastPage}}



%%% COMMANDS %%%

%% Fund calculations
% Ensure that if round-precision is specified, the give number of decimals is printed (necessary for prices in Euro)
\sisetup{round-integer-to-decimal} 
\DeclareSIUnit{\sieuro}{\mbox{\euro}}
% Place this environment in funds section to automatically add up costs using the macro 'position'.
\newenvironment{funds}[1][]
% Define variable funds for calculation. Store argument (description of total) in new command.
{\def\funds{0.00} \newcommand{\totaldescr}{#1}}
% Print total of environment with provided description. 
{\rule{\textwidth}{0.5pt} \par \total~\totaldescr \hfill \SI[round-mode = places, round-precision = 2]{\funds}{\sieuro}}

% To be used inside a funds environment. Place text and add given price to totals.
\newcommand{\position}[2]{\par #1 \hfill \SI[round-mode = places, round-precision = 2]{#2}{\sieuro} \FPeval{\funds}{\funds + #2}}
% Same as above but with multiples of a position.
\newcommand{\positionmul}[3]{\par #1 \hfill \num{#3} $\times$ \SI[round-mode = places, round-precision = 2]{#2}{\sieuro} \FPeval{\funds}{\funds + #3*#2}}


%% Sections
\newcommand{\subsubsubsection}[1]{\paragraph{#1} \mbox{} \par}
\setcounter{secnumdepth}{5}
\newcommand{\intextheading}[1]{\vskip 1em plus 1em minus .3em \textit{#1}\par} %TODO: do not end paragraph but add some vspace


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
	%	\vspace*{0.5cm}\hrulefill
	\bigskip\hrulefill{}
	
	{\usekomafont{section} WP \thewp~#1.}
	\par
	\bigskip
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
\textbf{\GetTranslation{titledescription}}

{\renewcommand{\and}{\\[1ex]}
	\proposal@shortauthor
}

\textbf{\@title}

\hrulefill
}

\textbf{\GetTranslation{projectdescription}}\par
}