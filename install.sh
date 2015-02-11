#!/bin/bash
local TEXMFHOME=$(kpsewhich -var-value TEXMFHOME)

# Link to texmf
ln -sf "$(pwd)/"*.sty "${TEXMFHOME}/tex/latex"
ln -sf "$(pwd)/"*.cls "${TEXMFHOME}/tex/latex"
