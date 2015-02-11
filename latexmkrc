print("Iniatializing latexmkrc\n");

$recorder = 1;

# PDFTeX
# Legacy LaTeX compiler
# To support packages like epstopdf, the feature \write18 must be enabled. This allows the running of external programs during TEX’s compile run. Keep in mind that this is a security risk. The feature is an addition to \TeX. MikTEX, teTEX, TEX Live support it. In Web2C based TEX distributions (teTEX, TEX Live) it can be enabled in the configuration file texmf.cnf:
#$pdflatex = "pdflatex --shell-escape %O %S";

# LuaLaTeX
# Modern compiler uses Unicode and "supporting modern font technologies such as OpenType or Apple Advanced Typography.
# Since lualatex only produces pdf files, it is a replacement for pdflatex.  To make it your default typesetting engine within latexmk you will not only need to set the $pdflatex variable to require the use of lualatex, but also to turn on production of pdf files and to turn off the production of dvi and ps files, as in the following
$pdflatex = "ulimit -n 2048 && lualatex --shell-escape %O %S";
$postscript_mode = $dvi_mode = 0;

# PDF Mode
# 0 ... do NOT generate a pdf version of the document.
# 1 ... generate a pdf version of the document using pdflatex
# 2 ... generate a pdf version of the document from the ps file, by using the command specified by the $ps2pdf variable.
# 3 ... generate a pdf version of the document from the dvi file, by using the command specified by the $dvipdf variable.
$pdf_mode = 1;

# BibTeX settings
# 0 ... never use BibTeX.
# 1 ... only use BibTeX if the bib files exist.
# 2 ... run BibTeX whenever it appears necessary to update the bbl files, without testing for the existence of the bib files.
$bibtex_use = 2;

# User biber instead of bibtex
$biber = 'biber --debug %O %S';

# PREVIEW
$pdf_previewer = "start open -a preview %O %S";

# Xindy
$makeindex = "texindy %O -o %D %S";

print("Open files limit (ulimit -n): ");
system("ulimit -n");

add_cus_dep('idx', 'ind', 0, 'texindy');
add_cus_dep('glo', 'gls', 0, 'makeglossaries');
add_cus_dep('acn', 'acr', 0, 'makeglossaries');
show_cus_dep();

sub makeglossaries
{
    my ($base_name, $path) = fileparse( $_[0] );
    pushd $path;
    if ( $silent )
    {
        my $return = system("makeglossaries -q $base_name");
    }
    else
    {
        my $return = system("makeglossaries $base_name");
    };
    popd;
    return $return;
}

sub texindy
{
    my ($base_name, $path) = fileparse( $_[0] );
    pushd $path;
    my $return = system("texindy $base_name");
    popd;
    return $return;
}

push @generated_exts, 'idx', 'ind', 'ilg';
push @generated_exts, 'glo', 'gls', 'glg';
push @generated_exts, 'acn', 'acr', 'alg';

$clean_ext = '%R.run.xml %R.synctex.gz %R.ist %R.xdy'
