% N4M3ZPhysics.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{N4M3ZThesis}[2014/06/08 ATLAS Thesis Class]
\def \ParentClass {book}

% First a few words about best practices in LaTeX
% -----------------------------------------------
% - Read LaTeX2 tabu about obsolete packages and commands: http://www.ctan.org/tex-archive/info/l2tabu/
% - Read documentation of proper math typesetting: http://www.ctan.org/tex-archive/info/math/voss/mathmode/
% - Use version control (SVN, git etc.)
% - Use the fact that LaTeX is not WYSIWYG. When writing paragraphs, start each sentence at the beginning of a line, and if it spills over, each subsequent line is tabbed.
% - Use latexmk + latexmkrc configuration files
% - Use "nag" Latex package, it warns the user about the usage of old packages or commands (for example, using \it, \tt, etc.) and warns about the things mentioned in l2tabu.
% - Use "fixltx2e" package, fixes bugs in LaTeX between releases, see http://www.ctan.org/pkg/fixltx2e
% - Use "geometry" package to set up page geometry instead of doing it manually. Never use obsolete a4.sty or a4wide.sty
% - Use "hyperref" to manage hyperlinks in your document (PDF only)
% - Use "booktabs" for better-looking tables than LaTeX default: introduces \toprule, \midrule, \botomrule
% - Use "siunitx" to typeset units. The package tries to replace sistyle, siunits, units, etc. and is actively maintained
% - Use "setspace" to define line spacing in documents, do not modify \baselinestreach yourself.
% - Use "microtype" for small-scale typographic enhancements (character protrusion, font expansion, letter-spacing).
% - Use "listings" for code listings formatting.
% - Use "fancyvrb" to get precise control in verbatim listings.
% - If you're creating PDF documents, use "hyperref" to get hyperlinks in your document.
% - If your document has a lot of technical figures, it might be a good idea to learn PGF/Tikz, sketch 3D, and pstricks, or a combination of those.
% - Use \centering instead of \begin{center} \end{center} to center things inside tables/figures etc.  \centering doesn't add any additional vertical space.
% - Typeset your document in draft mode to see how bad over- and underfull lines are, and if they are pretty bad, consider changing the wording a bit (but don't fuss too much over this, as the best wording is more important than minor typographical improvements). You can also help Latex by letting it hyphenate some words in this case.

% - Use \newcommand to make things more logical. For example, let's say you're writing a biology book, and it has a lot of scientific names of different species. Instead of littering your document with things like \textit{Homo sapiens}, you could define a new command \newcommand{\species}[2]{\textit{#1 #2}}. Then, later when you're reading rules about formatting species names, you realize that the name should be in a font different from the surrounding text—textit doesn't work if the surrounding text is in italics. You should have used \emph. With the \newcommand, the change is easy. Without the \newcommand, you have to manually change the font changing command in all the places you use a species name.

% How to get upright Greek letters
% --------------------------------
% (from the documentation of isomath)
% Of the following methods, can be used:
% Using isomath with PDFLaTex or unicode-math with LuaTeX or XeTeX is considered a modern approach
%
% a) If using LuaTeX/XeTeX, use unicode-math package:
%      \usepackage{unicode-math}
%      \unimathsetup%
%      {%
%          normal-style   = TeX,
%          math-style     = TeX,
%          bold-style     = TeX,
%          sans-style     = upright,
%          nabla          = upright,
%          partial        = upright,
%          vargreek-shape = TeX,
%          slash-delimiter= frac,
%      }%
%    and in the body:
%        $\mathrm{\pi}$ or $\mathbf{\pi}$
%
% b) Use isomath and the mathdesign package:
%        \usepackage[utopia]{mathdesign}
%        \usepackage[OMLmathrm,OMLmathbf]{isomath}
%    Now, e. g., \mathrm{\pi} and \mathbf{\pi} work as expected.
%    This ensures compatibility between PDFLaTeX and LuaTeX/XeTeX
%
% c) To get upright small Greek letters without affecting other fonts, set the math
%    alphabet manually to one of the three mathdesign fonts, e. g.: \SetMathAlphabet{\mathbf}{normal}{OML}{mdput}{b}{n}
%    (check if the letter shapes match with the rest of the document).
%
% d) Use a package that provides macros for upright Greek letters in math mode:
%      - fourier \otheralpha ... \otherOmega
%      - kpfonts \alphaup    ... \Omegaup
%      - mathdesign \alphaup ... \Omegaup
%      - pgreek \upalpha     ... \upOmega
%
% e) Use an upright text character (requires a matching LGR-encoded Greek text font). The following lines redefine \pi to set the mathematical constant pi upright:
%        \usepackage[LGR,T1]{fontenc}
%        \usepackage[greek,british]{babel}
%        \usepackage{amsmath}
%        \let\mathpi\pi
%        \renewcommand{\pi}{\text{\textrm{\greektext p }}}
%
% f) Use the text character with the alphabeta package from the lgrx bundle: \usepackage{amsmath}
%        \usepackage{alphabeta}
%    and in the body
%        $ u = 2 \text{\pi} r $

%%% +----------------------------------------------------------------------------------------------+
%%% |                                                                                              |
%%% | Requirements                                                                                 |
%%% |                                                                                              |
%%% +----------------------------------------------------------------------------------------------+

%% ------------------------------------------------------------------------------------------------
%%  xparse
%% ------------------------------------------------------------------------------------------------
% Pro­vides a high-level in­ter­face for pro­duc­ing doc­u­ment-level com­mands. In that way, it of­fers a re­place­ment for LATEX 2e \new­com­mand macro, with sig­nif­i­cantly im­proved func­tion­al­ity.

% http://www.ctan.org/pkg/xparse
% Version: 3990, 2014, LaTeX2e
% Load before: everything else
% Load after: -
% Compatibility: -
% Incompatibility: -

\RequirePackage{xparse}

%\PassOptionsToClass[log-declarations=false]{xparse} % supresses all logs

% INFO: A short discussion of LaTeX commands
% TeX native commands:
% --------------------
% - \def is a TeX primitive
% - \let \macroa \macrob  "copies" the definition of \macrob to \macroa. However, the important is that the definition isn't actually copied, the command sequence \macroa now points to the same hash table entry as \macrob

% LaTeX overlay:
% --------------
% The most obvious benefits of \newcommand over \def are:
% 1. \newcommand checks whether or not the command already exists
% 2. \newcommand allows you to define an optional argument
% 3. With LaTex2e, it is also possible to add a default parameter to a command with the following syntax: \newcommand{name}[num][default]{definition}

% In certain cases you might also want to use the \providecommand command. It works like \newcommand, but if the command is already defined, LaTeX will silently ignore the new command.

% xparse overlay (LaTeX3):
% ------------------------
% - \DeclareDocumentCommand <Function> {<arguments>} {<code>}
% - \NewDocumentCommand     <Function> {<arguments>} {<code>}
% - \RenewDocumentCommand   <Function> {<arguments>} {<code>}
% - \ProvideDocumentCommand <Function> {<arguments>} {<code>}

% - \DeclareDocumentEnvironment       {<environment>} {<arguments>} {<start code>} {<end code>}
% - \NewDocumentEnvironment           {<environment>} {<arguments>} {<start code>} {<end code>}
% - \RenewDocumentEnvironment         {<environment>} {<arguments>} {<start code>} {<end code>}
% - \ProvideDocumentEnvironment       {<environment>} {<arguments>} {<start code>} {<end code>}
% - \DeclareExpandableDocumentCommand {<environment>} {<arguments>} {<start code>} {<end code>}

% - \IfNoValueTF {<argument>} {<true code>} {<false code>}
% - \IfNoValueT  {<argument>} {<true code>}
% - \IfNoValueF  {<argument>} {<false code>}

% - \IfBooleanTF <argument> {<true code>} {<false code>}
% - \IfBooleanT  <argument> {<true code>}
% - \IfBooleanF  <argument> {<false code>}

% And additionally adds argument processor like \ReverseBoolean, \SplitArgument, \SplitList, \TrimSpaces etc.
% - \DeclareExpandableDocumentCommand <function> {<arguments> {<code>}

%% ------------------------------------------------------------------------------------------------
%%  etoolbox
%% ------------------------------------------------------------------------------------------------
% The pack­age is a tool­box of pro­gram­ming fa­cil­i­ties geared pri­mar­ily to­wards LATEX class and pack­age au­thors.

% http://www.ctan.org/pkg/xparse
% Version: 2.1, 2011, LaTeX2e
% Load before: everything else
% Load after: -
% Compatibility: -
% Incompatibility: -

\RequirePackage{etoolbox}

\providetoggle{morewrites}
\providetoggle{tikz}
\providetoggle{feynmf}
\providetoggle{xspace}
\providetoggle{microtype}
\providetoggle{markup}
\providetoggle{glossary}
\providetoggle{index}
\providetoggle{draft}
\providetoggle{quotchap}

%%% +----------------------------------------------------------------------------------------------+
%%% |                                                                                              |
%%% | Options                                                                                      |
%%% |                                                                                              |
%%% +----------------------------------------------------------------------------------------------+
%% Parent class options
\DeclareOption{a4paper}     {\PassOptionsToClass{\CurrentOption}{\ParentClass}}
\DeclareOption{twoside}     {\PassOptionsToClass{\CurrentOption}{\ParentClass}} % twoside ... print on both sides
\DeclareOption{oneside}     {\PassOptionsToClass{\CurrentOption}{\ParentClass}} % twoside ... print on both sides
\DeclareOption{10pt}        {\PassOptionsToClass{\CurrentOption}{\ParentClass}}
\DeclareOption{11pt}        {\PassOptionsToClass{\CurrentOption}{\ParentClass}}
\DeclareOption{12pt}        {\PassOptionsToClass{\CurrentOption}{\ParentClass}}
\DeclareOption{notitlepage} {\PassOptionsToClass{\CurrentOption}{\ParentClass}}
\DeclareOption{openright}   {\PassOptionsToClass{\CurrentOption}{\ParentClass}}
\DeclareOption{openleft}    {\PassOptionsToClass{\CurrentOption}{\ParentClass}}
\DeclareOption{draft}%
{%
  \PassOptionsToClass{\CurrentOption}{\ParentClass}
  \toggletrue{draft}
}

%% Custom package options
\DeclareOption{morewrites} { \toggletrue{morewrites} }
\DeclareOption{tikz}       { \toggletrue{tikz}       }
\DeclareOption{feynmf}     { \toggletrue{feynmf}     }
\DeclareOption{xspace}     { \toggletrue{xspace}     }
\DeclareOption{microtype}  { \toggletrue{microtype}  }
\DeclareOption{markup}     { \toggletrue{markup}     }
\DeclareOption{glossary}   { \toggletrue{glossary}   }
\DeclareOption{index}      { \toggletrue{index}      }
\DeclareOption{quotchap}   { \toggletrue{quotchap}   }

%% Fallback
\DeclareOption*%
{%
  \ClassWarning{atlasthesis}{Unknown option '\CurrentOption'}
}

%% Execute default options
\ExecuteOptions{notitlepage}

%% Process given options
\ProcessOptions\relax

\iftoggle{glossary} {\toggletrue{morewrites}}

%% Load additional packages and commands

%%% +----------------------------------------------------------------------------------------------+
%%% |                                                                                              |
%%% | Base                                                                                         |
%%% |                                                                                              |
%%% +----------------------------------------------------------------------------------------------+
%% Load base
\LoadClass{\ParentClass}

\RequirePackage[export]{adjustbox}
% export ... Exports most keys of \adjustbox to \includegraphics so that they can be used with this macro as well.
% Export ... Sets \includegraphics to be identical to \adjincludegraphics, which also allows the usage of all \adjustbox keys.
%\usepackage{subfiles}
\RequirePackage{standalone}
% 2012, LaTeX2e

\iftoggle{morewrites}%
{%
    %% ------------------------------------------------------------------------------------------------
    %%  morewrites
    %% ------------------------------------------------------------------------------------------------
    % Allows more writes to .aux files (default limited to 16), fixes the "no room for a new \write" error
    % WARNING: Some distributions of TEX allow a quoted syntax for file names with spaces. A temporary fix is to avoid file names with spaces. The current code trims spaces at the end of every line that is written to a file.

    % http://www.ctan.org/pkg/morewrites
    % Version: 0.2e, 2013, LaTeX2e
    % Load before: everything else
    % Load after: -
    % Compatibility: -
    % Incompatibility: -

    \RequirePackage{morewrites}
}

%% ------------------------------------------------------------------------------------------------
%%  nag
%% ------------------------------------------------------------------------------------------------
% Old habits die hard. All the same, there are commands, classes and packages which are outdated and superseded. nag provides routines to warn the user about the use of those. As an example, we provide an extension that detects many of the ``sins'' described in l2tabu.

% http://www.ctan.org/pkg/nag
% Version: 0.7, 2011, LaTeX2e
% Load before: everything else
% Load after: -
% Compatibility: -
% Incompatibility: caption, subfig, float, topcapt, rotating

\RequirePackage[l2tabu, orthodox]{nag}
% - l2tab ... loads nag-l2tabu.cfg checking for most common l2tabu issues
% - orthodox ... lnag-orthodox.cfg warns about usage that is not technically incorrect, but will mostly do things an unwary user may not expect

%% ------------------------------------------------------------------------------------------------
%%  fixltx2e
%% ------------------------------------------------------------------------------------------------
% Fixes bugs in LaTeX between releases

% http://www.ctan.org/pkg/fixltx2e
% Version: 1.1h, 2014, LaTeX2e
% Load before: everything else
% Load after: -
% Compatibility: -
% Incompatibility: -

\RequirePackage{fixltx2e}

%% ------------------------------------------------------------------------------------------------
%%  fix-cm
%% ------------------------------------------------------------------------------------------------
% Over­rides the (orig­i­nal) LaTeX re­stric­tions on the sizes at which CM and EC fonts may be used, otherwise one gets warning:
% "Size substitutions with differences(Font) up to 1.64499pt have occurred"
% The issue caused by siunitx in math mode with newtxmath or xfrac

% http://www.ctan.org/pkg/fix-cm
% Version: 1.1h, 2004, LaTeX2e
% Load before: everything else
% Load after: -
% Compatibility: -
% Incompatibility: -
\RequirePackage{fix-cm}

%% ------------------------------------------------------------------------------------------------
%%  ifpdf
%% ------------------------------------------------------------------------------------------------
% The following is needed in order to make the code compatible with both latex/dvips and pdflatex.
% WARNING: ifpdf returns true when using LuaLaTeX (this is intentionally used here)

% http://www.ctan.org/pkg/ifpdf
% Version: 2.3, 2011, LaTeX2e
% Load before: -
% Load after: -
% Compatibility: -
% Incompatibility: -

\RequirePackage{ifpdf}

%% ------------------------------------------------------------------------------------------------
%%  iftex
%% ------------------------------------------------------------------------------------------------
% Package for both Plain TeX and LaTeX, defines the \ifPDFTeX, \ifXeTeX, and \ifLuaTeX boolean for testing whether PDFTeX, or XeTeX, or LuaTeX is being used for typesetting.

% http://www.ctan.org/pkg/iftex
% Version: 0.2, 2013, LaTeX2e
% Load before: -
% Load after: -
% Compatibility: -
% Incompatibility: -

\RequirePackage{iftex}

%%% +----------------------------------------------------------------------------------------------+
%%% |                                                                                              |
%%% | Typography                                                                                   |
%%% |                                                                                              |
%%% +----------------------------------------------------------------------------------------------+
% For LaTeX2e guidelines, please read LaTeX2e tabu at: http://distrib-coffee.ipsl.jussieu.fr/pub/mirrors/ctan/info/l2tabu/english/l2tabuen.pdf

\ifPDFTeX
    % ENCODING
    % --------
    \RequirePackage[utf8]{inputenc} % utf8x is to be avoided if possible, since it loads the ucs package
    \RequirePackage[T1]{fontenc} % Force the font encoding to be T1 when loading inputenc, otherwise OT1 would be used (which has very few characters)

    % TEXT FONTS
    % ----------
    % prefer Times Roman in PostScript format (obsolete)
    %\usepackage{times}              % prefer Times Roman in PostScript format for rmfamily
    %\usepackage{helvet}             % prefer Arial, Verdana, Helvetica for sans serif

    % Traditional replacement for Times package
    %\usepackage{mathptmx} % does not contain boldmath fonts !
    %\usepackage{helvet}
    %\usepackage[scaled=.90]{helvet}
    %\usepackage{courier}

    %\usepackage{lmodern} % The Latin Modern fonts are enhanced versions of the Computer Modern fonts. They have enhanced metrics and glyph coverage (and they are also ugly)
    \RequirePackage[helvratio=1.0]{newtxtext} % A next to identical font to times.sty with perfectly equalized math (see below), the standard correction to Helvet ratio scale is 0.9, which we will not use as helvetica is used only for headings and we acutally want them slighly larger than normal

    %\usepackage{textcomp} % textcomp extra symbols, recommended package before loading gensymb.
    %\usepackage{gensymb}  % Generic symbols for both text and math mode (\degree , \celsius , \perthousand , \micro and \ohm )

    % MATH FONTS
    % ----------
    \RequirePackage{amsmath} % loads amstext, amsbsy, amsopn but not amssymb
    \RequirePackage{amssymb}
    %\RequirePackage[bigdelims,timesmathacc,varg,cmintegrals,nosymbolsc]{newtxmath}
    \RequirePackage[bigdelims,varg,cmintegrals]{newtxmath}
    \RequirePackage{mathtools} % extension package to amsmath
    \RequirePackage{abraces} % horizontal braces and advanced controls
    %\RequirePackage[lite]{mtpro2} % excellent professional font (paid version only)
    %\RequirePackage{wasysym} % supports Quantum Theory related symbols (\mathscr{H} ... Hilbert spaces, Lagrangians), [nointegrals] compatibility with amsmath
    \RequirePackage{mathrsfs} %, Sup­port use of the Raph Smith’s For­mal Script font in math­e­mat­ics. Pro­vides a \math­scr com­mand, rather than over­writ­ing the stan­dard \math­cal
    \RequirePackage{fixmath}  % Make maths comply with ISO31-0:1992 to ISO31-13:1992, defines Greek letters as alphabetic symbols
    \RequirePackage{upgreek}  % Upright Greek letters: \upmu, \uppi etc.
    \RequirePackage{cancel}
    %\usepackage{bm}       % load after all math to give access to bold math

    % Superseeds mathgreek
    %\usepackage[utopia]{mathdesign}
    %\usepackage[OMLmathrm,OMLmathbf]{isomath}

    % LANGUAGE LOCALE
    % ---------------
    \RequirePackage[english,french,czech]{babel} % Multilingual typesetting

    % TYPOGRAPHIC FINE-TUNING
    % -----------------------
    \allowdisplaybreaks[1] % page breaks are allowed, but avoided if possible

    \iftoggle{microtype}%
    {%
        \RequirePackage[babel=true,auto]{microtype}
        %\RequirePackage[babel=true,activate={true,nocompatibility},final,tracking=true,kerning=true,spacing=true,factor=1100,stretch=10,shrink=10]{microtype}
        % ... activate={true,nocompatibility} - activate protrusion and expansion
        % ... final - enable microtype; use "draft" to disable
        % ... tracking=true, kerning=true, spacing=true - activate these techniques
        % ... factor=1100 - add 10% to the protrusion amount (default is 1000)
        % ... stretch=10, shrink=10 - reduce stretchability/shrinkability (default is 20/20)

        %\SetProtrusion{encoding={*},family={bch},series={*},size={6,7}}
        %      {1={ ,750},2={ ,500},3={ ,500},4={ ,500},5={ ,500},
        %       6={ ,500},7={ ,600},8={ ,500},9={ ,500},0={ ,500}

        %\SetExtraKerning[unit=space]
        %    {encoding={*}, family={bch}, series={*}, size={footnotesize,small,normalsize}}
        %    {\textendash={400,400}, % en-dash, add more space around it
        %     "28={ ,150}, % left bracket, add space from right
        %     "29={150, }, % right bracket, add space from left
        %     \textquotedblleft={ ,150}, % left quotation mark, space from right
        %     \textquotedblright={150, }} % right quotation mark, space from left

        %\SetExtraKerning[unit=space]
        %   {encoding={*}, family={qhv}, series={b}, size={large,Large}}
        %   {1={-200,-200},
        %    \textendash={400,400}}

        %\SetTracking{encoding={*}, shape=sc}{40}
    }%

\else
  \ifLuaTeX
    % LuaLaTeX
    % If using LuaLaTeX
    % 1. Don't load inputenc, just encode your source in UTF-8.
    % 2. Don't load fontenc nor textcomp, but load fontspec.
    % 3. babel works with LuaLATEX but you can load polyglossia instead.
    % 4. Don't use any package that changes the fonts, but use fontspec's commands instead.

    % TEXT FONTS
    % ----------
    \RequirePackage{fontspec}
    %\defaultfontfeatures{Ligatures=TeX} % To support LaTeX quoting style

    % The TeX Gyre (TG) Font collection
    % ---------------------------------
    % An extensive remake and extension of the freely available 35 base PostScript fonts distributed with Ghostscript ver. 4.00.
    % The important aspect of the project is providing not only the support for TeX but also the cross-platform OpenType format of the fonts
    % URL: http://www.gust.org.pl/projects/e-foundry/tex-gyre/

    \setmainfont{Tex Gyre Termes} % TeX Gyre Termes can be used as a replacement for the renowned Times (new) Roman font
    %\setmainfont{Times New Roman}

    \setsansfont{Tex Gyre Heros} % TeX Gyre Heros can be used as a replacement for a popular font Helvetica, also known as Swiss
    %\setsansfont{Helvetica}

    \setmonofont{Tex Gyre Cursor} % TeX Gyre Cursor can be used as a replacement for a well-known Courier typeface
    %\setmonofont{Courier New}

    % MATH FONTS
    % ----------
    \RequirePackage{amsmath} % loads amstext, amsbsy, amsopn but not amssymb
    \RequirePackage{amssymb}
    \RequirePackage{amsfonts}

    \RequirePackage{mathtools} % extension package to amsmath
    %\RequirePackage[lite]{mtpro2} % excellent professional math font (paid version only)
    %\RequirePackage[nointegrals]{wasysym} % supports Quantum Theory related symbols (\mathscr{H} ... Hilbert spaces, Lagrangians), [nointegrals] compatibility with amsmath
    \RequirePackage{mathrsfs} %, Sup­port use of the Raph Smith’s For­mal Script font in math­e­mat­ics. Pro­vides a \math­scr com­mand, rather than over­writ­ing the stan­dard \math­cal
    %\RequirePackage{fixmath}  % Make maths comply with ISO31-0:1992 to ISO31-13:1992, defines Greek letters as alphabetic symbols
    \RequirePackage{cancel}

    \RequirePackage{unicode-math}
    \unimathsetup%
    {%
        normal-style   = TeX,
        math-style     = TeX,
        bold-style     = TeX,
        sans-style     = upright,
        nabla          = upright,
        partial        = upright,
        vargreek-shape = TeX,
        slash-delimiter= frac,
    }%
    \setmathfont{XITS Math}
    \setmathfont[range={\mathcal,\mathbfcal},StylisticSet=1]{XITS Math} % separate mathcal from mathscr

    %\RequirePackage[Symbol]{upgreek}  % Does not work with unicode-math

    % LANGUAGE LOCALE
    % ---------------
    \RequirePackage{polyglossia} % LuaTeX, XeTeX Babel replacement
    \setdefaultlanguage[variant=british]{english}
    \setotherlanguages{czech,french}

    % TYPOGRAPHIC FINE-TUNING
    % -----------------------
    \allowdisplaybreaks[1] % page breaks are allowed, but avoided if possible

    \iftoggle{microtype}%
    {%
        \RequirePackage[auto]{microtype}
    }%

    % EXTRAS
    % ------
    \RequirePackage{luatextra} % also loads fixltx2e, fontspec, xunicode

  \ifXeTeX

  \fi
\fi

%% ------------------------------------------------------------------------------------------------
%%  csquotes
%% ------------------------------------------------------------------------------------------------
\RequirePackage[autostyle=true]{csquotes}

% Czech csquotes
\DeclareQuoteStyle{czech}
  {\quotedblbase}
  {\textquotedblleft}
  {\textquoteleft}
  {\textquoteright}
% \renewcommand{\uv}[1]{
%   \enquote{#1}
% }

%% <<< SPACING >>> ------------------------------------------------------------------------
\RequirePackage{setspace} % replaces the doublespace package.
\onehalfspacing       % produces double and one-and-one-half line spacing based on the point size in use.

\iftoggle{xspace}%
{%
    \RequirePackage{xspace} % inserts space after macros automatically and takes care not to insert the space before punctuation (potentially unsafe)
}{%
    % Compatibility
    \providecommand \xspace \undefined
}

%%% +----------------------------------------------------------------------------------------------+
%%% |                                                                                              |
%%% | Layout                                                                                       |
%%% |                                                                                              |
%%% +----------------------------------------------------------------------------------------------+

%% ------------------------------------------------------------------------------------------------
%%  geometry
%% ------------------------------------------------------------------------------------------------
% The pack­age pro­vides an easy and flex­i­ble user in­ter­face to cus­tomize page lay­out, im­ple­ment­ing auto-cen­ter­ing and auto-bal­anc­ing mech­a­nisms so that the users have only to give the least de­scrip­tion for the page lay­out

% http://www.ctan.org/pkg/geometry
% Version: 5.6e, 2010, LaTeX2e
% Load before: everything else
% Load after: -
% Compatibility: -
% Incompatibility: -

\RequirePackage[a4paper]{geometry}
% - a4paper ... predefined A4 paper size
\geometry%
{%
  inner  = 35mm,
  outer  = 25mm,
  top    = 25mm,
  bottom = 25mm
}

%% Legacy commands without the use of GEOMETRY package (not recommended)
%\setlength\oddsidemargin {2.5cm}
%\setlength\evensidemargin {1.0cm}

%%% +----------------------------------------------------------------------------------------------+
%%% |                                                                                              |
%%% | Graphics                                                                                     |
%%% |                                                                                              |
%%% +----------------------------------------------------------------------------------------------+
%% ------------------------------------------------------------------------------------------------
%%  graphicx
%% ------------------------------------------------------------------------------------------------
% http://www.ctan.org/pkg/graphicx
% Version: 1.0f, 2014, LaTeX2e
% Load before: graphics, epsfig, trig, keyval, lscape
% Load after: -
% Compatibility: graphics, epsfig, trig, keyval, lscape
% Incompatibility: -

\RequirePackage{graphicx}

% Graphics handling differs between pdf and dvi format
\ifpdf
    %% ------------------------------------------------------------------------------------------------
    %%  epstopdf
    %% ------------------------------------------------------------------------------------------------
    % on-the-fly conversion of .eps to .pdf, requires graphicx to be loaded beforehand
    % WARNING: The feature \write18 must be enabled.

    % http://www.ctan.org/pkg/epstopdf-pkg
    % Version: 2.5, 2010, LaTeX2e
    % Load before: -
    % Load after: -
    % Compatibility: -
    % Incompatibility: -

    \usepackage{epstopdf}
    \epstopdfsetup{suffix=} % no default suffix to converted image output file names

    \DeclareGraphicsExtensions{.pdf,.png,.jpg,.eps}

\else
    \DeclareGraphicsExtensions{.eps}

\fi

%% ------------------------------------------------------------------------------------------------
%%  grffile
%% ------------------------------------------------------------------------------------------------
% http://www.ctan.org/pkg/grffile
% Version: 1.16, 2012, LaTeX2e
% Load before: -
% Load after: graphics, graphicx
% Compatibility: -
% Incompatibility: -

\usepackage[multidot,babel]{grffile} % allows dots in figure file names

% Override graphicx draft settings
\setkeys{Gin}{draft=false}

\iftoggle{tikz}%
{%
    %% ------------------------------------------------------------------------------------------------
    %%  tikz
    %% ------------------------------------------------------------------------------------------------
    \usepackage{tikz}
    % http://www.ctan.org/pkg/ifpdf
    % Version: 2.3, 2011, LaTeX2e
    % Load before: -
    % Load after: -
    % Compatibility: -
    % Incompatibility: -

    \usetikzlibrary{arrows}
    \usetikzlibrary{positioning}               % For "above of=" commands
    \usetikzlibrary{calc,through}              % For coordinates
    \usetikzlibrary{decorations.pathreplacing} % For curly braces
    \usetikzlibrary{decorations.pathmorphing}  % For Feynman Diagrams
    \usetikzlibrary{decorations.markings}
    \usetikzlibrary{3d}

    % style definition
    \tikzset{%
        >=latex', %%  Uncomment for more conventional arrows
        vertex/.style={circle,fill,inner sep=0mm, minimum size=4pt},
        blob/.style  ={circle,draw,inner sep=0mm, minimum size=30pt},
        vector/.style={decorate, decoration={snake}, draw},
        provector/.style={decorate, decoration={snake,amplitude=2.5pt}, draw},
        antivector/.style={decorate, decoration={snake,amplitude=-2.5pt}, draw},
        fermion/.style={draw=black, postaction={decorate},
            decoration={markings,mark=at position .60 with {\arrow[draw=black]{>}}}},
        fermionbar/.style={draw=black, postaction={decorate},
            decoration={markings,mark=at position .60 with {\arrow[draw=black]{<}}}},
        fermionnoarrow/.style={draw=black},
        gluon/.style={decorate, draw=black,
            decoration={coil,amplitude=4pt, segment length=5pt}},
        scalar/.style={dashed,draw=black, postaction={decorate},
            decoration={markings,mark=at position .60 with {\arrow[draw=black]{>}}}},
        scalarbar/.style={dashed,draw=black, postaction={decorate},
            decoration={markings,mark=at position .60 with {\arrow[draw=black]{<}}}},
        scalarnoarrow/.style={dashed,draw=black},
        electron/.style={draw=black, postaction={decorate},
            decoration={markings,mark=at position .60 with {\arrow[draw=black]{>}}}},
        bigvector/.style={decorate, decoration={snake,amplitude=4pt}, draw},
        bod/.style={circle,fill,inner sep=0pt},
        track/.style={very thick,->},
        coorsys/.style={dashed},
        zyplane/.style={canvas is zy plane at x=#1}
    }%

    % macro for recalculating phi_0 from phi
    \newcommand{\tikzAngleOfLine}{\tikz@AngleOfLine}
        \def\tikz@AngleOfLine(#1)(#2)#3{%
        \pgfmathanglebetweenpoints{%
        \pgfpointanchor{#1}{center}}{%
        \pgfpointanchor{#2}{center}}
        \pgfmathsetmacro{#3}{\pgfmathresult}%
    }

    % macro for ditto mark
    \newcommand{\ditto}{%
    \tikz
    {%
        \draw [line width=0.12ex] (-0.2ex,0) -- +(0,0.8ex)
                                  ( 0.2ex,0) -- +(0,0.8ex);
        \draw [line width=0.08ex] (-0.6ex,0.4ex) -- +(-1.5em,0)
                                  ( 0.6ex,0.4ex) -- +(1.5em,0);
    }%
}

    \usetikzlibrary{calc,through,intersections,backgrounds}
    %\usepgfplotslibrary{external}
}

\iftoggle{feynmf}%
{%
    \RequirePackage{feynmp}
    \DeclareGraphicsRule{*}{mps}{*}{} % MetaPost configuration (needed for feynmp)
    \unitlength = 1mm % SI definition for the feynmp package
}

%%% +----------------------------------------------------------------------------------------------+
%%% |                                                                                              |
%%% | Markup                                                                                       |
%%% |                                                                                              |
%%% +----------------------------------------------------------------------------------------------+
\iftoggle{markup}%
{\PassOptionsToPackage{obeyDraft}{todonotes}}%
{\PassOptionsToPackage{disable}{todonotes}}%

%% ------------------------------------------------------------------------------------------------
%%  changes
%% ------------------------------------------------------------------------------------------------
\RequirePackage{changes}

%% ------------------------------------------------------------------------------------------------
%%  todonotes
%% ------------------------------------------------------------------------------------------------
% The pack­age lets the user mark things to do later, in a sim­ple and vi­su­ally ap­peal­ing way. The pack­age takes sev­eral op­tions to en­able cus­tomiza­tion/fine­tun­ing of the vi­sual ap­pear­ance.

% http://www.ctan.org/pkg/fixme
% /macros/latex/contrib/todonotes
% Version: 2012-11-24, LaTeX2e
% Load before: everything else
% Load after: tikz, ifthen, xkeyval, xcolor, calc, graphicx
% Compatibility: -
% Incompatibility: -

\RequirePackage[colorinlistoftodos,textsize=small]{todonotes}
% - colorinlistoftodos ... adds color separation for the list of todos
% - obeyDraft ... notes showed in draft release
% - textsize ... sets the default text size of the inserted todonotes to the given value

% Select what to do with todonotes:
%\PassOptionsToClass{disable}{todonotes} % notes not showed
%\PassOptionsToClass{draft}{todonotes}   % notes always showed

\setlength{\marginparwidth}{30mm}
\reversemarginpar % print notes on the inner margin

% Redefine the behaviour of "todo" notes
\let \todonote \todo % save original todo

\newcounter{Ntodo}
\DeclareDocumentCommand {\todo} { o m }%
{%
    \refstepcounter{Ntodo}%
    {%
        \IfNoValueTF {#1}%
        {%
            \todonote%
            {%
                \textbf{To~do~\theNtodo:} #2%
            }%
        }{%
            \todonote[#1]
            {%
                \textbf{To~do~\theNtodo:} #2%
            }%
        }%
    }%
}

% Usage: \comment[<AuthorInitials>]{Testing first time.}
\newcounter{Ncomment}
\DeclareDocumentCommand {\comment} { o O{AA} m }% initials of the author (Optional{Anonymous Access}) + note in the margin
{%
    \refstepcounter{Ncomment}%
    {%
        \IfNoValueTF {#1}%
        {%
            \todonote[color={green!33}]%
            {%
                \textbf{Comment [\uppercase{#2}--\theNcomment]:} #3%
            }%
        }{%
            \todonote[#1,color={green!33}]
            {%
                \textbf{Comment [\uppercase{#2}--\theNcomment]:} #3%
            }%
        }%
    }%
}

\newcounter{Nwltodo}
\DeclareDocumentCommand {\wltodo} { o m }
{%
    \refstepcounter{Nwltodo}%
    {%
        \IfNoValueTF {#1}%
        {%
            \todonote[color={blue!33}]%
            {%
                \textbf{Would like to~\theNwltodo:} #2%
            }%
        }{%
            \todonote[#1,color={blue!33}]
            {%
                \textbf{Would like to~\theNwltodo:} #2%
            }%
        }%
    }%
}

\DeclareDocumentCommand {\addref} { o }%
{%
    \IfNoValueTF {#1}%
        {\todo[color=red!40]{Add reference.}}%
        {\todo[#1, color=red!40]{Add reference.}}%
}

% Inline commands
\DeclareDocumentCommand {\todoin} { m }
{%
    \todo[inline]{#1}
}

\DeclareDocumentCommand {\commentin} { o m }
{%
    \comment[inline][#1]{#2}%
}

\DeclareDocumentCommand {\wltodoin} { m }
{%
    \wltodo[inline]{#1}%
}

\DeclareDocumentCommand {\addrefin} {}%
{%
    \addref[inline]{Add reference.}%
}

% Minipage commands
\DeclareDocumentCommand {\todopage} { O{Block} m }
{%
    \todonote[inline, caption={#1}]%
    {%
        \begin{minipage}{\textwidth-5pt}%
        #2%
        \end{minipage}%
    }%
}%








\usepackage[hyphens]{url} % allows linebreaks of URLs
\urlstyle{sf}
\DeclareUrlCommand\email{\urlstyle{rm}}
\DeclareUrlCommand\directory{\urlstyle{tt}}





%% <<< PACKAGES for manipulating references >>> ---------------------------------------------------






\usepackage{datetime} % [ddmmyyyy]

%% PDF VERSION
% \pdfcompresslevel=10
% \pdfdecimaldigits=3
% \pdfhorigin=1 true in
% \pdfoutput=1
% \pdfpageheight=297 true mm
% \pdfpagewidth=210 true mm
% \pdfpkresolution=600
% \pdfvorigin=1 true in

% \pdfminorversion=7
% \pdfcompresslevel=9
% \pdfobjcompresslevel=9





\RequirePackage[strings]{underscore} % breaks underscores in filenames
% When you use the [strings] option, you must load this package last
% Compatibility: babel, biblatex
% This is seriously dangerous! Careful!

% ------------------------------------------------------------------------------------------------
%% References
% ------------------------------------------------------------------------------------------------
%% ------------------------------------------------------------------------------------------------
%%  biblatex
%% ------------------------------------------------------------------------------------------------
\RequirePackage[bibencoding = utf8,% Biber required for UTF8
                backend     = biber,%
                hyperref    = true,%
                %natbib      = true,%
                refsection  = chapter,% provides refsection for each chapter automatically
                backref     = true,%
                url         = true,% will always show url, we clear url field manually for non-online content later
                citestyle   = alphabetic,%
                style       = alphabetic,%
                autocite    = inline,
                firstinits  = false, % render first and middle names as initials
                useprefix   = true, % for inclusion of 'de' 'da' in surname
                maxcitenames= 3,
                maxbibnames = 100,
                sorting     = anyt]% alphabetic label, name, year, title
                {biblatex}

\RequireBiber[3] % Biber is strictly required due to unicode support

% Less fussy line breaking for bibliography
\defcounter{biburlnumpenalty}{3000}
\defcounter{biburlucpenalty}{6000}
\defcounter{biburllcpenalty}{9000}

% Keep URL only for webpages
\AtEveryBibitem{%
  \ifentrytype{misc}%
  {}%
  {%
    \clearfield{url}%
    \clearfield{urldate}%
  }%
}

% Url field formats
\NewBibliographyString{available}

\DefineBibliographyStrings{english}{%
  available = {Available at},
}

\DeclareFieldFormat{url}{\bibstring{available}\addcolon\space\small\url{#1}}
\DeclareFieldFormat{urldate}{\addcomma\space\bibstring{urlseen}\space#1}

% References at the end
\usepackage{nameref}
\defbibheading{subbibliography}{%
  \section*{\nameref{refsection:\therefsection}}}

%\DeclareCiteCommand{\textcite}
%  {\boolfalse{cbx:parens}}
%  {\usebibmacro{citeindex}%
%   \ifboolexpr{ ( not test {\iffieldundef{prenote}} and
%                  test {\ifnumequal{\value{citecount}}{1}} ) or
%                ( not test {\iffieldundef{postnote}} and
%                  test {\ifnumequal{\value{citecount}}{\value{citetotal}}} ) }
%     {\usebibmacro{textcite}}
%     {\printtext[bibhyperref]{% Apply citation link to bibmacro output
%        \DeclareFieldAlias{bibhyperref}{default}% Prevent nested hyperlinks
%        \DeclareNameAlias{labelname}{first-last}%
%        \usebibmacro{textcite}%
%        \ifbool{cbx:parens}{\bibcloseparen\global\boolfalse{cbx:parens}}{}}}}
%  {\ifbool{cbx:parens}{\bibcloseparen\global\boolfalse{cbx:parens}}{}%
%   \multicitedelim}
%  {\usebibmacro{textcite:postnote}}

\DeclareCiteCommand{\textcite}%
  {\boolfalse{cbx:parens}}%
  {%
    \usebibmacro{citeindex}%
    \printtext[bibhyperref]%
      {%
        \DeclareFieldAlias{bibhyperref}{default}% Prevent nested hyperlinks
        \DeclareNameAlias{labelname}{first-last}% use full author name
        \usebibmacro{textcite}%
        \ifbool{cbx:parens}%
          {\bibcloseparen\global\boolfalse{cbx:parens}}%
          {}%
      }%
  }%
  {%
    \ifbool{cbx:parens}%
      {\bibcloseparen\global\boolfalse{cbx:parens}}%
      {}%
    \multicitedelim%
  }%
  {\usebibmacro{textcite:postnote}}

% ------------------------------------------------------------------------------------------------
%% Hyperlinks
% ------------------------------------------------------------------------------------------------
% Note: When using the hyperref package, it is preferable to load it after biblatex. See documentation biblatex.pdf


%% <<< GRAPHICS >>> -------------------------------------------------------------------------------
%\setlength{\emergencystretch}{2em}
%\hyphenpenalty=750

\newenvironment{tolerant}[2]{%
  \par
  \ifx\empty#1\empty\else\tolerance=#1\relax\fi
  \ifx\empty#2\empty\else\emergencystretch=#2\relax\fi
}{%
  \par
}






%% <<< PACKAGES for manipulating figures/tables >>> -----------------------------------------------
\usepackage{booktabs} % publication quality tables
\usepackage{rotating}                % rotates figures or tables
\usepackage{color}
\usepackage{calc}
\usepackage{multirow}               % for multiple rows and cols in tables
% Floating Environments Captions
\usepackage[margin=15pt,font=small,labelfont=bf,up,labelsep=colon]{caption}[2013/02/03]
%\renewcommand{\captionfont}{\small}%\itshape}

%\usepackage{subfig}                % hyperref support within the subfig package is broken, use subcaption instead.
\usepackage{subcaption}             % uses subfloats within a single float (i. e. multiple figures in a single figure)

\usepackage{sidecap}                % sidecaption figure
\usepackage{wrapfig}                % wrap figure

\usepackage{array}
\usepackage{pdfpages}               % simplifies the insertion of external multi-page PDF or PS


%% <<< DRAFT NOTES >>> ------------------------------------------------------------------------
\usepackage{ifdraft}

% Draft heading code
\newcommand{\draftheading}%
{
  %
  % compute the time in hours and minutes
  % make new variables \timehh and \timemm
  %
  \newcount\timehh\newcount\timemm
  \timehh=\time
  \divide\timehh by 60 \timemm=\time
  \count255=\timehh\multiply\count255 by -60 \advance\timemm by \count255
  % put in header
  \markboth%
  % --- Left mark
  {\hspace*{\fill}{\protect\small\bf \fbox{DRAFT}}
    \hspace*{\fill}
    \protect\makebox[0pt][r]{\protect\small\sl\today\ --
      \ifnum\timehh<10 0\fi\number\timehh\,:\,\ifnum\timemm<10 0\fi\number\timemm}
  }%--- right mark
  {\protect\makebox[0pt][l]{\protect\small\sl\today\ --
      \ifnum\timehh<10 0\fi\number\timehh\,:\,\ifnum\timemm<10 0\fi\number\timemm}
    \hspace*{\fill}
    {\protect\small\bf \fbox{DRAFT}}
    \hspace*{\fill}}
}

%% <<< DOCUMENT FORMAT >>> ------------------------------------------------------------------------
%\sloppy                         % less fussy line breaking, prevents overfull boxes, may leave too much space between words.

% How many levels of section head would you like numbered?
% 0= no section numbers, 1= section, 2= subsection, 3= subsubsection
\setcounter{secnumdepth}{3}     % maximum #.#.#.: section-name subdivision

%% ------------------------------------------------------------------------------------------------
%%  xfrac
%% ------------------------------------------------------------------------------------------------
% The xfrac package defines a document command \sfrac with the following syntax:
% Causes problems with unicode characters: Font shape `U/rsfs/m/n' in size

% http://www.ctan.org/pkg/xfrac
% Version: SVN 3990, 2014, LaTeX3
% Load before: -
% Load after: -
% Compatibility: -
% Incompatibility: -

%\RequirePackage{xfrac}

%% ------------------------------------------------------------------------------------------------
%%  siunitx
%% ------------------------------------------------------------------------------------------------
% package provides a set of tools for authors to typeset quantities in a consistent way. The package has an extended set of configuration options which make it possible to follow varying typographic conventions with the same input syntax. The package includes automated processing of numbers and units, and the ability to control tabular alignment of numbers.

% http://www.ctan.org/pkg/siunitx
% Version: 2.5s, 2014, LaTeX3
% Load before: -
% Load after: -
% Compatibility: -
% Incompatibility: -

\RequirePackage{siunitx} % Comprehensice unit system
%\ProvidesFile{siunitx.cfg}
\sisetup%
{%
  locale                 = US        ,
  abbreviations          = true      ,
  binary-units           = true      ,
  per-mode               = reciprocal,
  round-mode             = places    ,
  round-precision        = 2         ,
  range-units            = single    ,
  range-phrase           = --        ,
  free-standing-units    = true      ,
  % overwrite-functions    = true      ,
  space-before-unit      = true      ,
  unit-optional-argument = true      ,
  use-xspace             = true      ,
  separate-uncertainty   = true      ,
  %mode                   = math      ,
  list-final-separator   = { \translate{and} },
  list-pair-separator    = { \translate{and} },
  %range-phrase           = { \translate{to (numerical range)} },
}%






\DeclareDocumentCommand {\thickhrulefill} { o } {\IfNoValueTF{#1} {\leavevmode \leaders \hrule height 1ex \hfill \kern \z@}%
                                                                  {\leavevmode \leaders \hrule height  #1 \hfill \kern \z@}}
%\newcommand{\thickhrulefill} {\leavevmode \leaders \hrule height 1ex \hfill \kern \z@} % legacy implementation



%% <<< NO CHAPTER HEADER on opposite page >>> -----------------------------------------------------
% \let\origdoublepage\cleardoublepage
% \newcommand{\clearemptydoublepage}{%
%   \clearpage
%   {\pagestyle{empty}\origdoublepage}%
% }
% \let\cleardoublepage\clearemptydoublepage



% {\begingroup % Create the command for including the title page in the document
% \hbox{ % Horizontal box
% \hspace*{0.2\textwidth} % Whitespace to the left of the title page
% \rule{1pt}{\textheight} % Vertical line
% \hspace*{0.05\textwidth} % Whitespace between the vertical line and title page text
% \parbox[b]{0.75\textwidth}{ % Paragraph box which restricts text to less than the width of the page
% {\noindent\Huge\bfseries #2\par % Title
% }%
% }%
% }%
% \endgroup}

% \renewcommand \@part[#1]#2{%
% \ifnum \c@secnumdepth >-2\relax
%   \refstepcounter{part}%
%   \addcontentsline{toc}{part}{\thepart\hspace{1em}#1}%
% \else
%   \addcontentsline{toc}{part}{#1}%
% \fi
% \markboth{}{}%
% {\centering
%  \interlinepenalty \@M
%  \normalfont
%  \ifnum \c@secnumdepth >-2\relax
%    \huge\bfseries \partname\nobreakspace\thepart
%    \par
%    \vskip 20\p@
%  \fi
%  \Huge \bfseries #2\par}%
% \@endpart}

%% COLORS
\definecolor{aquamarine}{RGB}{0,255,255}


%% CUSTOM COMMANDS
\newcommand{\mc}{\multicolumn}                          % easy MULTICOLUMN
\newcommand{\mr}{\multirow}                             % easy MULTIROW

\newtheorem{theorem}{Theorem}[section]
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{proposition}[theorem]{Proposition}
\newtheorem{corollary}[theorem]{Corollary}

\newenvironment{proof}[1][Proof]{\begin{trivlist}
\item[\hskip \labelsep {\bfseries #1}]}{\end{trivlist}}
\newenvironment{definition}[1][Definition]{\begin{trivlist}
\item[\hskip \labelsep {\bfseries #1}]}{\end{trivlist}}
\newenvironment{example}[1][Example]{\begin{trivlist}
\item[\hskip \labelsep {\bfseries #1}]}{\end{trivlist}}
\newenvironment{remark}[1][Remark]{\begin{trivlist}
\item[\hskip \labelsep {\bfseries #1}]}{\end{trivlist}}

%\newcommand{\qed}{\nobreak \ifvmode \relax \else
%      \ifdim\lastskip<1.5em \hskip-\lastskip
%      \hskip1.5em plus0em minus0.5em \fi \nobreak
%      \vrule height0.75em width0.5em depth0.25em\fi}


\DeclareDocumentCommand {\eqnref} { s m } {\IfBooleanTF {#1} {eqn.\,\eqref{#2}} {equation~\eqref{#2}}}
\DeclareDocumentCommand {\figref} { s m } {\IfBooleanTF {#1} {fig.\,\ref{#2}} {figure~\ref{#2}}}
\DeclareDocumentCommand {\tabref} { s m } {\IfBooleanTF {#1} {tab.\,\ref{#2}} {table~\ref{#2}}}
\DeclareDocumentCommand {\secref} { s m } {\IfBooleanTF {#1} {sec.\,\ref{#2}} {section~\ref{#2}}}


%%%  ----------------------------------------------------------------------------------------------
%%% |                                                                                              |
%%% | DRAFT                                                                                        |
%%% |                                                                                              |
%%%  ----------------------------------------------------------------------------------------------
% Draft mode:
% Classes
% - Print a box at the end of overfull lines.

% Packages
% - changes (final disables markup of changes, and list of changes)
% - graphics (draw frames instead of including images)
% - graphicx (draw frames instead of including images)
% - hyperref (disable all linking features)
% - listings (don’t include external files)
% - listofsymbols (final suppresses printing of macro names and unused symbols)
% - mfpic (assume every latex run to be the first one)
% - microtype (disable all features)
% - pdfcomment (final suppresses the comments)
% - pdfpages (don’t include external file but print a frame box)
% - pgf (similar to graphics/x: all images will be replaced by empty rectangles)
% - showkeys (draft shows the labels, the default option)
% - thumbs (thumbs' width=2pt, thumbs' text=black, thumbs' color=grey)
% - varioref (turn warnings in error messages)

\iftoggle{draft}%
{%
    %% ================================================================================================
    \usepackage[switch]{lineno} % Provides line numbers on paragraphs.
    % switch ... puts the line numbers on the outer (inner) margin 4 of the text, requires pagewise mode

    % http://www.ctan.org/pkg/lineno
    % Version: 4.41, 2005, LaTexX2e
    % Load before: -
    % Load after: hyperref
    % Compatibility: displaymath, hyperref,
    % Incompatibility: -

    \modulolinenumbers[2]
}
{
    % Fix for .aux files corrupted by lineno when switching between final and draft modes
    \providecommand{\@LN}[2]{}
}

%% ================================================================================================
\RequirePackage{accsupp} % provides accessibility support for internal PDF settings

% Using the \BeginAccSupp and \EndAccSupp group, any text can be typeset in the PDF, but actually replaced by an empty space {}. This is done by supplying the option ActualText={}.
\DeclareRobustCommand\squelch[1]{%
  \protect\BeginAccSupp{method=escape,ActualText={}}#1\protect\EndAccSupp{}%
}

% Protect line numbers from selection in PDF using accsupp (lineno package)
\iftoggle{draft}%
{%
  \renewcommand{\thelinenumber}%
  {%
    \squelch{\arabic{linenumber}}%
  }%
}%
% \renewcommand{\thelinenumber}{
%     \protect\BeginAccSupp{ActualText={}}\arabic{linenumber}\protect\EndAccSupp{}%
% }

% Protect line numbers from selection in PDF using accsupp (lineno package)
% Broken by hyperref, fix:
% \AtBeginDocument{\renewcommand*{\theHlstnumber}{\arabic{lstnumber}}}% or manually put it after `\begin{document}
%\renewcommand{\thelstnumber}{
%  \squelch{\arabic{lstnumber}}%
%}
% \renewcommand{\thelstnumber}{
%     \protect\BeginAccSupp{ActualText={}}\arabic{lstnumber}\protect\EndAccSupp{}%
% }

% Protect footnote marks numbers from selection in PDF
\renewcommand{\thefootnote}{%
  \squelch{\arabic{footnote}}%
}%
% \renewcommand{\thefootnote}{%
%   \protect\BeginAccSupp{ActualText={}}\arabic{footnote}\protect\EndAccSupp{}%
% }

% Make equation LaTeX code copyable
% N.B.: The argument of \copyable is read with verbatim catcodes. Therefore this trick will not work, if \copyable is inside an argument of another macro (or in environments of package amsmath). In this case the \detokenize has a function to get the previous version with spaces after command names at least.
\DeclareDocumentCommand{\copyable} {} {%
  \begingroup
  \@sanitize
  \catcode`\%=14 % allow % as comment char, also needed for \%
  \@copyable
}%
\newcommand*{\@copyable}[1]{%
  \endgroup
  \BeginAccSupp{%
    ActualText=\detokenize{#1},%
    method=escape,
  }%
  \scantokens{#1}%
  \EndAccSupp{}%
}

% The same command without verbatim catcodes
\newcommand*{\copytokens}[1]{%
  \BeginAccSupp{%
    ActualText=\detokenize{#1},%
    method=escape,
  }%
  #1%
  \EndAccSupp{}%
}

\RequirePackage{environ}
\NewEnviron{accequation}%
{%
    \equation
    \protected@edef\body{\BODY}
    \copyable{\body}
    \endequation
}

%%% +----------------------------------------------------------------------------------------------+
%%% |                                                                                              |
%%% | ENVIROMENTS                                                                                  |
%%% |                                                                                              |
%%% +----------------------------------------------------------------------------------------------+

%% ================================================================================================
\RequirePackage[shortlabels]{enumitem}
% - shortlabels ... allows enumerate-like syntax: A, a, I, i and 1 stand for \Alph*, \alph*, \Roman*, \roman* and \arabic*.

% http://ctan.org/pkg/enumitem
% Version: 3.5.2, 2009, LaTeX2e
% Load before: -
% Load after: -
% Compatibility: enumerate
% Incompatibility: -

% itemize,<level>
% leftmargin=* ... margin like before, but labelwidth is set to the width of the current label, using the default value of 0 in \arabic*, viii in \roman*, m in \alph* and similarly in uppercase forms

\ifPDFTeX
  \setlist[itemize]{label=$\blacktriangleright$, itemsep=1pt, parsep=0pt}
  \setlist[itemize,2]{label=$\triangleright$}
\else
  \ifLuaTeX
    \setlist[itemize]{itemsep=1pt, parsep=0pt}
    \setlist[itemize]{label=$\scriptstyle \blacktriangleright$, itemsep=1pt, parsep=0pt}
    \setlist[itemize,2]{label=$\scriptstyle \triangleright$}
  \fi
\fi

% enumerate,<level>
\setlist[enumerate]{label*=\arabic*., itemsep=1pt, parsep=0pt}

\setlist[enumerate,1]{label=\arabic*.,
                        ref=\arabic*}
\setlist[enumerate,2]{label=\emph{\alph*}),
                        ref=\theenumi.\emph{\alph*}}
\setlist[enumerate,3]{label=\roman*),
                        ref=\theenumii.\roman*}

% description
\setlist[description]{font=\bfseries, style=standard}
%\setlist[description]{font=\sffamily\bfseries, style=multiline}

% Similar code to do it manually (only as an example)
%% Redefine enumerate spacing
%\let \oldenumerate    \enumerate
%\let \oldendenumerate \endenumerate
%\RenewDocumentEnvironment{enumerate} {}%
%    {%
%      \oldenumerate
%      \setlength{\itemsep}{1pt}
%      \setlength{\parskip}{0pt}
%      \setlength{\parsep}{0pt}
%    }%
%    {\oldendenumerate}

%% ================================================================================================
\RequirePackage[final]{listings} % type­set pro­grams (pro­gram­ming code) within LATEX; the source code is read di­rectly by TEX—no front-end pro­ces­sor is needed.

% http://ctan.org/pkg/listings
% Version: 1.5c, 2013, LaTeX2e
% Load before: -
% Load after: textcomp
% Compatibility: -
% Incompatibility: -

\lstloadlanguages{C++}
\lstloadlanguages{Python}
\lstloadlanguages{XML}
\lstloadlanguages{bash}

\definecolor{mygreen}{rgb}{0,0.6,0}
\definecolor{mygray}{rgb}{0.5,0.5,0.5}
\definecolor{mymauve}{rgb}{0.58,0,0.82}

\lstset{%
    sensitive=true                                  % case sensitive
    breakatwhitespace=false,                        % sets if automatic breaks should only happen at whitespace
    breaklines=true,                                % sets automatic line breaking
    captionpos=t,                                   % sets the caption-position
    extendedchars=true,                             % lets you use non-ASCII characters; for 8-bits encodings only, does not work with UTF-8
    frame=,                                         % adds a frame around the code: single, trBL etc.
    rulecolor=\color{black},                        % if not set, the frame-color may be changed on line-breaks within not-black text (e.g. comments (green here))
    belowskip=1pt,                                  % vertical space below the displayed listings
    keepspaces=true,                                % keeps spaces in text, useful for keeping indentation of code (possibly needs columns=flexible)
    columns=flexible,                               % block alignment (fixed, flexible, fullflexible), always convert tabulators to spaces
    numbersep=5pt,                                  % how far the line-numbers are from the code
    tabsize=4,                                      % sets default tabsize to 2 spaces
    showtabs=false,                                 % show tabs within strings adding particular underscores
    showspaces=false,                               % show spaces everywhere adding particular underscores; it overrides 'showstringspaces'
    showstringspaces=false,                         % underline spaces within strings only
    xleftmargin=\parindent,                         % left margin for par-ident for book format
    backgroundcolor=\color{white},                  % choose the background color; you must add \usepackage{color} or \usepackage{xcolor}
    basicstyle=\footnotesize\ttfamily\color{black}, % the size of the fonts that are used for the code
    keywordstyle=\bfseries\color{blue},             % keyword style
    keywordstyle=[1]\color[rgb]{0,0,0.75},          % keyword style level 1
    keywordstyle=[2]\color[rgb]{0.5,0.0,0.0},       % keyword style level 2
    keywordstyle=[3]\color[rgb]{0.127,0.427,0.514}, % keyword style level 3
    keywordstyle=[4]\color[rgb]{0.4,0.4,0.4},       % keyword style level 4
    commentstyle=\ttfamily\color{mygreen},          % comment style
    identifierstyle=\color{black},                  % identifier style
    stringstyle=\ttfamily\color{orange},            % string literal style
    numberstyle=\tiny\color{mygray}\squelch,        % the style that is used for the line-numbers + protect line numbers in code from copying (accsupp package)
    numbers=left,                                   % where to put the line-numbers; possible values are (none, left, right)
    stepnumber=1,                                   % the step between two line-numbers. If it's 1, each line will be numbered
    upquote=true,                                   % determines the proper typesetting for quotes requires textcomp
    title=\lstname,                                 % show the filename of files included with \lstinputlisting; also try caption instead of title
    escapeinside={\%*}{*)},                         % if you want to add LaTeX within your code
}

\lstdefinelanguage{cxx}
{
    language=C++,
    %deletekeywords={},                       % if you want to delete keywords from the given language
    morekeywords=[1]                          % if you want to add more keywords to the set
    {
      std, vector, string, pair,
      Int_t, Double_t, Float_t, Bool_t, UInt_t,
    },
    morekeywords=[2]
    {
        radians,degrees,
        sin,cos,tan,asin,acos,atan,
        sinh,cosh,tanh,asinh,acosh,atanh,pow,
        exp,log,exp2,log2,sqrt,inversesqrt,
        min,max,abs,sign,floor,round,ceil
    },
    morekeywords=[3]
    {
        TObject, TH1, TH1F, TH2, TH2F,
        AnalysisBase, AnalysisWW, Skimmer, Event, EventBase,
        AnalysisManager, AnalysisConfig, AnalysisToolBase, AnalysisObject, Algorithm, Smearing, Scale, Factor,
        Store, Lepton, Muon, MuonBase, MuonStore, MuonStaco, MuonMuid, Electron, ElectronBase, ElectronStore, ElectronDefault, ElectronGSF, Jet, JetBase, JetAntiKt4EM, JetAntiKt4LC,
        MuonSmear, SmearingClass, CorrectCaloIso, Analysis, AnalysisMuonConfigurableScaleFactors, MuonIsolationSF, MuonTriggerMatching
    },
    morekeywords=[4]
    {
        NoAlgorithm, Staco, Muid, Chain3,
        NoSmearing, SmearingNominal, SmearingIDUp, SmearingIDDown, SmearingMSUp, SmearingMSDown,
        NoScale   , ScaleNominal   , ScaleUp     , ScaleDown,
        NoFactor  , FactorNominal  , EfficiencyUp, EfficiencyDown, IsolationUp , IsolationDown,
        Recommendation,
    },
    alsoother={\#},
    otherkeywords=
    {
      \#pragma, \#define
    },
    morecomment=[l]{//},
    morecomment=[s]{/*}{*/},
    morecomment=[s]{/**}{*/}, % Doxygen
    morestring=[b]",
    morestring=[b]'
}

\DeclareCaptionFont{white}{\color{white}}
\DeclareCaptionFormat{listing}{\colorbox{gray}{\parbox{\dimexpr\textwidth-2\fboxsep\relax}{#1#2#3}}} % \colorbox adds some space before and after the text inside it; this space is \fboxsep wide
%\parbox{\textwidth-2\fboxsep}{#1#2#3}} % using calc
\captionsetup[lstlisting]{format=listing,labelfont=white,textfont=white,singlelinecheck=false,margin=0pt,font={bf,footnotesize}}

%%% +----------------------------------------------------------------------------------------------+
%%% |                                                                                              |
%%% | Style                                                                                        |
%%% |                                                                                              |
%%% +----------------------------------------------------------------------------------------------+
\raggedbottom % declaration makes all pages the height of the text on that page. No extra vertical space is added.

% Empty page between chapter
%\patchcmd{\chapter}{plain}{empty}{}{}
\RequirePackage{emptypage}

\newtoggle{CustomStyle}
\toggletrue{CustomStyle}

% General styling
\iftoggle{CustomStyle}
{
    % Footnotes
    % ---------
    % Alphabetical footnotes
    % \renewcommand{\thefootnote}{\alph{footnote}}

    % Symbol footnotes
    \renewcommand{\thefootnote}{\fnsymbol{footnote}}
}

%% ================================================================================================
\ifPDFTeX
  \usepackage{sectsty} % Provides a set of commands for changing the font used for the various sectional headings in the standard LATEX2e document classes: article, book, and report.

  % http://www.ctan.org/pkg/sectsty
  % Version: 2.0.2, 2005, LaTexX2e
  % Load before: minitoc, fancyhdr
  % Load after: -
  % Compatibility: scrartcl, scrbook, scrreprt
  % Incompatibility: -

  \newtoggle{SectionNumberMargin}

  \togglefalse{SectionNumberMargin}

  % Custom style for this thesis
  \iftoggle{CustomStyle}
  {
    % Set formats for each heading level
    \sectionfont      {\sffamily\bfseries\Large\sectionrule{-1ex}{1pt}{0ex}{0pt}}
    \subsectionfont   {\sffamily\bfseries\large}
    \subsubsectionfont{\sffamily\bfseries\normalsize}
  }

  % Typesets section number into left margin.
  \iftoggle{SectionNumberMargin}
  {
    \def\@seccntformat#1{\protect\makebox[0pt][r]{\csname
                         the#1\endcsname\quad}}
  }
\else
  \ifLuaTeX
    \iftoggle{CustomStyle}
    {
      \usepackage{titlesec}
      % Set formats for each heading level
      \titleformat{\section}[hang]{\sffamily\bfseries}{\Large\thesection}{11pt}{\Large}[{\titlerule[1.0pt]}]
      \titleformat*{\subsection}   {\sffamily\bfseries\large}
      \titleformat*{\subsubsection}{\sffamily\bfseries\normalsize}
    }
  \fi
\fi

% ================================================================================================
\iftoggle{quotchap}
{
    \usepackage[avantgarde]{quotchap}

    % http://www.ctan.org/pkg/quotchap
    % Version: 3.1, 2008, LaTexX2e
    % Load before: -
    % Load after: sectsty
    % Compatibility: -
    % Incompatibility: -

    %% Redefine CHAPTER HEADING
    % Legacy style
    % \renewcommand{\@makechapterhead}[1]{%
    %   {\parindent \z@ \centering \reset@font
    %         \thickhrulefill\quad
    %         \scshape \@chapapp{} \thechapter
    %         \quad \thickhrulefill
    %         \par\nobreak
    %         \vspace*{10\p@}%
    %         \interlinepenalty\@M
    %         \hrule
    %         \vspace*{10\p@}%
    %         \Huge \bfseries #1\par\nobreak
    %         \par
    %         \vspace*{10\p@}%
    %         \hrule
    %         %\vskip 50\p@
    %   }}

    % Default
    % \renewcommand{\@makechapterhead}[1]{\chapterheadstartvskip%
    %   {\size@chapter{\sectfont\raggedleft
    %       {\chapnumfont
    %         \ifnum \c@secnumdepth >\m@ne%
    %         \if@mainmatter\thechapter%
    %         \fi\fi
    %         \par\nobreak}%
    %       {\raggedleft\advance\leftmargin10em\interlinepenalty\@M #1\par}}
    %     \nobreak\chapterheadendvskip}}

    % Style 1
    % \renewcommand{\@makechapterhead}[1]{%
    %   {\size@chapter{\sectfont\raggedleft
    %     {\chapnumfont
    %       \ifnum \c@secnumdepth >\m@ne%
    %         \if@mainmatter\parindent \z@ \centering \thickhrulefill[1.5ex]\,\thechapter\,\thickhrulefill[1.5ex]\else\phantom{\thechapter}%
    %       \fi\else\phantom{\thechapter}\fi
    %       \par\nobreak}%
    %     {\parindent \z@ \centering \reset@font
    %         \scshape \Huge #1 \par\nobreak
    %         \par
    %         \vspace*{10\p@}%
    %         %\hrule
    %         }}
    %   \nobreak\chapterheadendvskip}}

    % Style 2
    \renewcommand{\@makechapterhead}[1]{%
      {\size@chapter{\sectfont\raggedleft
      {\chapnumfont
      \ifnum \c@secnumdepth >\m@ne%
      \if@mainmatter\thechapter%
      \fi\fi
      \par\nobreak}%
      {\raggedleft\advance\leftmargin10em\color[gray]{0.5}\thickhrulefill[1.5ex]\color[gray]{0.0}\quad\interlinepenalty\@M\scshape\Huge #1\par}}
      \nobreak\chapterheadendvskip}%
    }
}

%% ================================================================================================
\usepackage{fancyhdr} % Allows you to customize in LaTeX your page headers and footers in an easy way.

% http://www.ctan.org/pkg/fancyhdr
% Version: 3.1, 2008, LaTexX2e
% Load before: -
% Load after: geometrty, sectsty
% Compatibility: lastpage, chappg, extramarks, afterpage, flafter, longtable
% Incompatibility: -

% \fancypagestyle{plain}{%
% \fancyhf{} % nuke all the default values
% \fancyfoot[C]{\bfseries \thepage} % except the center
% \renewcommand{\headrulewidth}{0pt}
% \renewcommand{\footrulewidth}{0pt}}

%% We will completely define our own header strings, so switch to the fancy pagestyle
\iftoggle{CustomStyle}
{
  \pagestyle{fancy}
  \fancyhf{} % nuke all the default values
  \renewcommand{\chaptermark}[1]{\markboth{\MakeUppercase{#1}}{}}
  \renewcommand{\sectionmark}[1]{\markright{\MakeUppercase{#1}}{}}
  \renewcommand{\headrulewidth}{1pt}
  \setlength{\headheight}{15pt}

  %% Configuration of the header strings
  \fancyhead[RO]{\squelch{\hspace{2em}\thepage}} % right odd
  \fancyhead[LO]{\squelch{\footnotesize{\leftmark}}} % left odd
  \fancyhead[RE]{\squelch{\footnotesize{\rightmark}}} % right even
  \fancyhead[LE]{\squelch{\thepage\hspace{2em}}} % left even
}

%% ================================================================================================
\usepackage[tight,nohints]{minitoc} % allows creating mini-table of contents (a “minitoc”) at the beginning/end of each part/chapter/section of a document.
% tight   ... reduce spacing in mini-tables
% nohints ... supress warnings

% http://www.ctan.org/pkg/minitoc
% Version: 60, 2008, LaTexX2e
% Load before: -
% Load after: sectsty, varsects, fncychap, hangcaption, quotchap, romannum, sfheaders, alnumsec, captcont, hyperref
% Compatibility: -
% Incompatibility: memoir

%% ================================================================================================
\usepackage{lettrine} % allows lettrine/initial, i.e. letter at the beginning of a word, a chapter, or a paragraph that is larger than the rest of the text

% http://www.ctan.org/pkg/lettrine
% Version: 1.64, 2012, LaTexX2e
% Load before: keyval
% Load after: graphicx, color (if used)
% Compatibility: -
% Incompatibility: -

\setcounter{DefaultLines}{3} % lettrine vertical size in lines
\renewcommand{\LettrineTextFont}{\scshape} % default font
\renewcommand{\LettrineFontHook}{\color[gray]{0.5}}
% \renewcommand{\LettrineFontHook}{\fontfamily{ppl}\fontseries{bx}\fontshape{sl}}

%% ================================================================================================
\ifpdf

    \usepackage{lastpage} % last page referable

  %% ================================================================================================
  \usepackage[bookmarks,unicode,final,hyperindex=false,pageanchor]{hyperref} % PDF bookmarks with page back reference
  %        \usepackage[pdftex,unicode,pagebackref,pageanchor]{hyperref} % PDF bookmarks with page back reference

  % http://www.ctan.org/pkg/hyperref
  % Version: 6.83m, 2012, LaTexX2e
  % Load before: glossaries, hypcap, amsrefs, eforms, pdfcomment, bookmark
  % Load after: everything else
  % Compatibility: -
  % Incompatibility: -

  \hypersetup%
  {
    % PDF-specific display options
    %bookmarks       =true,            % show or hide the bookmarks bar when displaying the document. Must be specified as part of the \usepackage{} statement.
    bookmarksopen    =false,           % show bookmarks unrolled
    bookmarksnumbered=false,           % numbering for bookmarks
    unicode          =true,            % allows to use characters of non-Latin based languages in Acrobat’s bookmarks
    pdftoolbar       =true,            % show or hide Acrobat toolbar
    pdfmenubar       =true,            % show or hide Acrobat menu
    pdffitwindow     =true,            % resize document window to fit document size
    %pdfstartview    ={FitH},{FitV},etc[3]. % fit the width of the page to the window
    pdftitle         ={\TitleTOC},     % define the title that gets displayed in the "Document Info" window of Acrobat
    pdfauthor        ={\Authors},      % the name of the PDF’s author, it works like the one above
    pdfsubject       ={\Subject},      % subject of the document, it works like the one above
    pdfcreator       ={\Authors},      % creator of the document, it works like the one above
    pdfproducer      ={\Authors},      % producer of the document, it works like the one above
    pdfkeywords      ={\Keywords},     % list of keywords, separated by brackets, example below
    pdfnewwindow     =true,            % define if a new window should get opened when a link leads out of the current document
    %pagebackref     =false,           % activate back references inside bibliography. Must be specified as part of the \usepackage{} statement, superseeded by biblatex
    %hidelinks,                        % hide links (removing color and border)
    colorlinks       =true,            % surround the links by color frames (false) or colors the text of the links (true). The color can be configured using the following options (default colors are shown):
    linktoc          =all,             % defines which part of an entry in the table of contents is made into a link: none,section,page,all
    linkcolor        =[rgb]{.0 .0 .5}, % color of internal links (sections, pages, etc.)
    citecolor        =[rgb]{.0 .5 .0}, % color of citation links (bibliography)
    filecolor        =[rgb]{.5 .0 .0}, % color of file links
    urlcolor         =[rgb]{.5 .0 .0}, % color of URL links (mail, web)
    %pdfhighlight    =/P,
    linkbordercolor  ={.0 .0 .5},      % color of frame around internal links (if colorlinks=false)
    citebordercolor  ={.0 .5 .0},      % color of frame around citations
    urlbordercolor   ={.5 .0 .0},      % color of frame around URL links
    pdfborder        ={0 0 1},         % {RadiusH RadiusV Width [Dash-Pattern]} set the style of the border around a link. The first two parameters (RadiusH, RadiusV) have no effect in most pdf viewers. Width defines the thickness of the border. Dash-Pattern is a series of numbers separated by space and enclosed by box-brackets. It is an optional parameter to specify the length of each line & gap in the dash pattern. For example, {0 0 0.5 [3 3]} is supposed to draw a square box (no rounded corners) of width 0.5 and a dash pattern with a dash of length 3 followed by a gap of length 3. There is no uniformity in whether/how different pdf viewers render the dash pattern.
  }

  %% ================================================================================================
  \usepackage[all]{hypcap} % point table and figure reference to \begin{} not to \caption{}
                           % BEWARE, this will ruin your attempts to put two figures side-by-side
                           % \capstart needs to be used to correct the figure counter

\else
    % make the command \href from hyperref available as a 'print only'
    \newcommand{\href}[2]{#2}

\fi

%% ================================================================================================
\usepackage[xindy={language=english, codepage=utf8},toc,nopostdot,shortcuts,acronym,symbols,numbers]{glossaries} % sanitize=none,sanitizesort=false
%\newglossary[alg]{acronym}{acr}{acn}{\acronymname}         % equivalent to option acronym
%\newglossary[slg]{symbols}{sls}{slo}{\glssymbolsgroupname} % equivalent to option symbols
%\newglossary[nlg]{numbers}{nls}{nlo}{\glsnumbersgroupname} % equivalent to option numbers
%\newglossary[ilg]{index}{ind}{idx}{\indexname}             % equivalent to option index

%\glsSetSuffixF{\nohyperpage{f.}}
%\glsSetSuffixFF{\nohyperpage{ff.}}
\GlsSetXdyLanguage{english} % applies to all glossaries
\GlsSetXdyMinRangeLength{1} % applies to all glossaries
\GlsSetXdyCodePage{utf8} % applies to all glossaries

\setlength{\glsdescwidth}{0.75\linewidth}


%\ifpdf
%\else
%  % Need an extra line break in the html version
%  % (Don't have time to fiddle with cfg files!)
%  \renewcommand*{\glossentry}[2]{%
%    \item[\glsentryitem{#1}\glstarget{#1}{\glossentryname{#1}}]\mbox{}\newline
%      \glossentrydesc{#1}\glspostdescription\space #2\newline}%
%\fi


% \renewcommand \newacronym \newglossaryentry{#1}[type=acronym,name={#1},description=\nopostdesc,⟨options⟩]
% \renewcommand \newterm \newglossaryentry{⟨term⟩}[type=index,name={⟨term⟩},description=\nopostdesc,⟨options⟩]
\newcommand*{\newsym}[3][]{\newglossaryentry{#1}{type=symbols,name={#2},long={#3},description=\nopostdesc}}
\renewcommand*{\glssymbolsgroupname}{Symbols}

% Command that makes the entry appear both in the main glossary and in the list of acronyms
% glsadd ensures crossreferencing, when acronym is references, the glossary entry is also referenced
\newcommand*{\newdualentry}[5][]{%
  \newglossaryentry{main-#2}{name={#4},%
  text={#3\glsadd{#2}},%
  description={#5},%
  #1
  }%
  \newacronym{#2}{#3\glsadd{main-#2}}{#4}%
}

% Usage:
% \newdualentry{svm}% label = 2
%   {SVM}% abbreviation = 3
%   {support vector machine}% long form = 4
%   {Statistical pattern recognition technique}% description = 5

% \renewcommand*{\glshyperlink}[2][\gls{\@glo@label}]{%
% \def\@glo@label{#2}%
% \@glslink{glo:#2}{#1}}

\DeclareDocumentCommand{\glsflagfirst} { m } {\glsdisp*{#1}{\empty}}




%% ================================================================================================
\usepackage[xindy]{imakeidx}

%\def\xindylangopt{-M lang/czech/utf8-lang}

\makeindex[title=Index,%
           columns=2,%
           intoc,%
           program=xindy,%
           options={-L english -M ../atlasindex.xdy}]

% xindy: -M path to xindy module .xdy,
% makeindex: -s path makeindex style .ist

% If you see this: ERROR: Could not find file "tex/inputenc/utf8.xdy" !
% If you use pdftex and LaTeX, your raw index file is not in UTF-8, but uses an encoding named LICR (LaTeX Internal Character Representation). Therefore the option "-c utf8" is not necessary. Just leave it off, it will work. The documentation should be better and explicitely note this -- in the case of pdftex/LaTeX, the index sort encoding (that's what -c is about) has nothing to do with the encoding of the original document.

%\usepackage[columns=2,totoc]{idxlayout}
%\indexprologue{\chapter*{\indexname}

\def\myheadingstart{%\def\indexspace{}%\justify\hfil
  \centering\begingroup\dayheadfont\large\bfseries-- }
\def\myheadingend{ --\endgroup\nopagebreak\vspace{0.5\baselineskip}\par\raggedright}
\def\mallettergroup#1{\myheadingstart#1\myheadingend}

%% ================================================================================================
% Reset fonts

% Enable hyphenation of sc and tt fonts in PDFLaTeX
% http://tex.stackexchange.com/questions/44361/how-to-automatically-hyphenate-within-texttt
\ifPDFTeX
    \DeclareRobustCommand\origttfamily
            {\not@math@alphabet\ttfamily\mathtt
             \fontfamily\ttdefault\selectfont\hyphenchar\font=-1}
    \DeclareTextFontCommand{\texttorig}{\origttfamily}
    \DeclareRobustCommand\ttfamily
            {\not@math@alphabet\ttfamily\mathtt
             \fontfamily\ttdefault\selectfont\hyphenchar\font=`\-}
\fi

%\usepackage{etex}
%\reserveinserts{100}



% LATEX can, by de­fault, only cope with 18 out­stand­ing floats; any more, and you get the er­ror “too many un­pro­cessed floats”. This pack­age re­leases the limit; TEX it­self im­poses lim­its (which are in­de­pen­dent of the help of­fered by e-TEX).
% How­ever, if your floats can’t be placed any­where, ex­tend­ing the num­ber of floats merely de­lays the ar­rival of the in­evitable er­ror mes­sage.
\usepackage{morefloats}


% Bibliography hack for subfiles
%\newrobustcmd*{\nobibliography}{%
%  \@ifnextchar[%]
%    {\blx@nobibliography}
%    {\blx@nobibliography[]}}
%
%\def\blx@nobibliography[#1]{}
%
%\appto{\skip@preamble}{\let\printbibliography\nobibliography}
%
%\bibliographystyle{plain}
%\bibliography{../../../Archive/BibTeX/References}

%\usepackage{comment}
%\excludecomment{thebibliography}


% However, care must be taken when using cleveref in conjunction with other packages that modify LATEX’s referencing system (see Section 13). Basically, cleveref must be loaded last.
\usepackage[nameinlink]{cleveref}

% COUNTERS
\newcounter{totfigures}
\newcounter{tottables}
\newcounter{totequations}

\providecommand\totfig{}
\providecommand\tottab{}
\providecommand\toteqn{}

\AtEndDocument{%
  \addtocounter{totfigures}{\value{figure}}%
  \addtocounter{tottables}{\value{table}}%
  \addtocounter{totequations}{\value{equation}}%
  \immediate\write\@mainaux{%
    \string\gdef\string\totfig{\number\value{totfigures}}%
    \string\gdef\string\tottab{\number\value{tottables}}%
    \string\gdef\string\toteqn{\number\value{totequations}}%
  }%
}

\pretocmd{\chapter}{\addtocounter{totfigures}{\value{figure}}\setcounter{figure}{0}}{}{}
\pretocmd{\chapter}{\addtocounter{tottables}{\value{table}}\setcounter{table}{0}}{}{}
\pretocmd{\chapter}{\addtocounter{totequations}{\value{equation}}\setcounter{equation}{0}}{}{}

\usepackage{fmtcount} % ordinals and dialects
\let \nth \ordinalnum

\IfFileExists{euscript.sty}
  {%
    \ifPDFTeX
        \usepackage[mathcal]{euscript}
    \fi
    \newcommand{\EUmathcal}[1]{\usefont{U}{eus}{m}{n}##1}
  }%
  {}

\IfFileExists{mbboard.sty}
  {%
    \newcommand{\MBBmathbb}[1]{\usefont{OT1}{mbb}{m}{n}##1}
  }%
  {}

\IfFileExists{bbold.sty}
  {%
    \newcommand{\BBmathbb}[1]{\usefont{U}{bbold}{m}{n}##1}
  }%
  {}

% Force Error log
\errorcontextlines=\maxdimen

\endinput
