\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{CoreBeamer}[2014/12/31 N4M3Z Beamer Class]
\def\ParentClass{beamer}

%%% +----------------------------------------------------------------------------------------------+
%%% |                                                                                              |
%%% | Options                                                                                      |
%%% |                                                                                              |
%%% +----------------------------------------------------------------------------------------------+
%% beamer class options
\DeclareOption{9pt}         {\PassOptionsToClass{\CurrentOption}{\ParentClass}}
\DeclareOption{10pt}        {\PassOptionsToClass{\CurrentOption}{\ParentClass}}
\DeclareOption{11pt}        {\PassOptionsToClass{\CurrentOption}{\ParentClass}}
\DeclareOption{12pt}        {\PassOptionsToClass{\CurrentOption}{\ParentClass}}
\DeclareOption{slidestop}   {\PassOptionsToClass{\CurrentOption}{\ParentClass}}
\DeclareOption{mathserif}   {\PassOptionsToClass{\CurrentOption}{\ParentClass}}
\DeclareOption{draft}       {\PassOptionsToClass{\CurrentOption}{\ParentClass}}

%% N4M3Z Core package options
\DeclareOption{morewrites}  {\PassOptionsToPackage{\CurrentOption}{Core}}
\DeclareOption{xspace}      {\PassOptionsToPackage{\CurrentOption}{Core}}

%% this class options
\DeclareOption{glossary}    {\PassOptionsToPackage{\CurrentOption}{Core}}
\DeclareOption{index}       {\PassOptionsToPackage{\CurrentOption}{Core}}

%% Fallback
\DeclareOption*%
{%
    \ClassWarning{CoreBeamer}{Unknown option '\CurrentOption'}
}

%% Execute default options
\ExecuteOptions{9pt}

%% Process given options
\ProcessOptions\relax

%% Load additional packages and commands

%%% +----------------------------------------------------------------------------------------------+
%%% |                                                                                              |
%%% | Base                                                                                         |
%%% |                                                                                              |
%%% +----------------------------------------------------------------------------------------------+
%% Load base
\LoadClass{\ParentClass}

\RequirePackage{Core}


\usepackage{longtable}
\usepackage{float}
\usepackage{wrapfig}
\usepackage{soul}
\usepackage{textcomp}
\usepackage{hyperref}


% \tolerance=1000






\RequirePackage{beamerthemesplit}

\setbeamersize{text margin left=.5cm,text margin right=.5cm}

\ifLuaTeX{}
    % Necessary for unicode-math to work properly with symbols like \blacktriangle
    %\usefonttheme{professionalfonts}
    \mode<presentation>{\beamer@suppressreplacementstrue}
\fi

\RequirePackage{CoreType}

\RequirePackage{CoreGraphics}
\graphicspath{ {Media/} }    % Put all images in this directory. Avoids clutter.

\RequirePackage{CoreHyphen}



\usepackage{booktabs}
%\usepackage[natbib=true, bibstyle=authoryear, citestyle=authoryear-comp]{biblatex}




%\setbeamertemplate{background canvas}[vertical shading][bottom=keynotebottom, middle=keynotemiddle, top=keynotetop]


\usepackage{tikz}
\usepackage{CoreTikz}

\usetikzlibrary{backgrounds}
\usetikzlibrary{mindmap,trees}    % For mind map
% http://www.texample.net/tikz/examples/computer-science-mindmap/

%% To use external nodes; http://www.texample.net/tikz/examples/beamer-arrows/
\tikzstyle{every picture}+=[remember picture]

%%% +----------------------------------------------------------------------------------------------+
%%% |                                                                                              |
%%% | Commands                                                                                     |
%%% |                                                                                              |
%%% +----------------------------------------------------------------------------------------------+

\newcommand{\myitem}{\item[\vspace{0.5ex}]}
\newcommand{\handwriting}{\fontspec{augie}} % From Emerald City, free font
\newcommand{\forbold}{\fontspec{Helvetica}}


\newcommand{\comment}[1]{\textcolor{comment}{\footnotesize{#1}\normalsize}} % comment mild
\newcommand{\Comment}[1]{\textcolor{Comment}{\footnotesize{#1}\normalsize}} % comment bold
\newcommand{\COMMENT}[1]{\textcolor{COMMENT}{\footnotesize{#1}\normalsize}} % comment crazy bold

\newcommand{\Alert}[1]{\textcolor{Alert}{#1}} % louder alert
\newcommand{\ALERT}[1]{\textcolor{ALERT}{#1}} % loudest alert
% \providecommand{\alert}[1]{\textbf{#1}}

%% "\alert" is already a beamer pre-defined

% % ALERT AND COMMENT COLORS (just copies of the above colors)
% % (I don't know how ot do this more elegantly)
\newif\ifbeamer@Flip@dark
\beamer@Flip@darkfalse
\DeclareOptionBeamer{dark}{\beamer@Flip@darktrue}
\ProcessOptionsBeamer

\ifbeamer@Flip@dark
    \definecolor{ALERT}{RGB}{153,0,0}            % crimsonred
    \definecolor{Alert}{RGB}{51,153,0}            % turtlegreen
    \definecolor{alert}{RGB}{204,204,102}        % paleale
    \definecolor{charcoal}{RGB}{51,51,51}        % charcoal
    \definecolor{comment}{RGB}{80,80,80}        % light charcoal
    \definecolor{Comment}{RGB}{100,100,100}        % ash
    \definecolor{COMMENT}{RGB}{80,20,120}        % regal
\else
    \definecolor{ALERT}{RGB}{153,0,0}            % crimsonred
    \definecolor{Alert}{RGB}{51,153,0}            % turtlegreen
    \definecolor{alert}{RGB}{140,110,10}        % lager
    \definecolor{charcoal}{RGB}{80,80,80}        % light charcoal
    \definecolor{comment}{RGB}{51,51,51}        % charcoal
    \definecolor{Comment}{RGB}{100,100,100}        % ash
    \definecolor{COMMENT}{RGB}{80,20,120}        % regal
\fi






\mode<presentation>


% \usetheme{progressbar}
% \usecolortheme{progressbarck}
% \usefonttheme{progressbar}

% \progressbaroptions%
% {%
%     headline=sections,
%     frametitle=picture-subsection,
%     titlepage=picture,
%     footer=pagenum,
%     itemize=triangle
% }

% % These are a few colors that I like.

% \definecolor{crimsonred}{RGB}{153,0,0}        % Neurtal red, good for dark or light bg
% \definecolor{darkcharcoal}{RGB}{25,25,25}        % Darker gray
% \definecolor{charcoal}{RGB}{51,51,51}        % Darker gray
% \definecolor{ash}{RGB}{100,100,100}            % medium gray
% \definecolor{paleblue}{RGB}{0,102,102}        % More of an `ocean' color
% \definecolor{turtlegreen}{RGB}{51,153,0}    % A more neutral green
% \definecolor{paleale}{RGB}{204,204,102}        % Only for dark BG
% \definecolor{lager}{RGB}{140,110,10}        % Use instead of pale ale for white BG
% \definecolor{regal}{RGB}{90,0,120}            % A more neutral purple
% \definecolor{jeans}{RGB}{20,30,150}            % A more neutral blue


% % Define some "invariant colors" so that a color that doen't work with a
% % light/dark background will automatically be substituted with one that does.
% % These will be rewritten in beamercolorthemeFlipDark

% \ifbeamer@Flip@dark
%     \definecolor{FlipSand}{RGB}{204,204,102}        % paleale, Only for dark BG
%     \definecolor{FlipGreen}{RGB}{0,255,0}            % Neon-like green, only for dark BG
% \else
%     \definecolor{FlipSand}{RGB}{140,110,10}            % lager, Only for light BG
%     \definecolor{FlipGreen}{RGB}{51,153,0}            % turtlegreen, works for both
% \fi

% %% Future revision: It would be nice to define these in terms of the palette.


% \ifbeamer@Flip@dark
%     \setbeamercolor{normal text}{fg=white, bg=black}
%     \setbeamercolor{structure}{fg=gray, bg=black}        % fg controls bullets
%     \setbeamercolor*{footerlike}{fg=white,bg=black}        % Controls the footerline
% \else
%     % Default to black on white
%     \setbeamercolor*{footerlike}{fg=white,bg=charcoal}    % for charcoal footer
%     \setbeamercolor{structure}{fg=charcoal, bg=white}    % fg controls bullets
%     % \setbeamercolor{normal text}{fg=white, bg=black}
% \fi

% % These defined colors can be used in \textcolor{colorname}{text in that color}.

% % Colors for Keynote background: DARK
% \definecolor{keynotebottom}{rgb}{0.32,0.3,0.38}
% \definecolor{keynotemiddle}{rgb}{0.08,0.08,0.16}
% \definecolor{keynotetop}{rgb}{0,0,0}
% %%% Example of usage:
% %% \setbeamertemplate{background canvas}[vertical shading]
% %% [bottom=keynotebottom, middle=keynotemiddle, top=keynotetop]


\setbeamertemplate{sidebar right}{\llap{\includegraphics[width=\paperwidth,height=\paperheight]{BG_upper}}}

\mode<all>

\endinput
