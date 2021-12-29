# LaTeX DFG template 

**Last updated: December 2021**

A LaTeX template for a basic DFG (Deutsche Forschungsgemeinschaft, German
Research Foundation) grant proposal.

__Attention__: you need ``pdflatex`` and
``biber`` (not ``bibtex``) to compile the document. 

**Code autocompletion:** If you are using
[TeXstudio](https://www.texstudio.org/), there exists an autocomplete file
(`.cwl`) for the `dfgproposal.cls` class, which can be found
[here](https://gist.github.com/klb2/c0ba8ab7e4d2a7a62f39965cb0efdad0).

## Acknowledgements

This template is based on the template of [Martin
Hölzer](https://github.com/hoelzer/dfg) and based on the RTF
[DFG form 53_01_en 11/20](http://www.dfg.de/formulare/53_01_elan/53_01_en_elan.rtf), __last accessed in September 2021__.

## Compilation

```bash
pdflatex
biber
pdflatex
pdflatex
```

### Biber

If you do not have ``biber`` installed try to install it from the package sources of your system. There is also a ``conda`` install that you can try:

```bash
conda create -n biber -c malramsay biber 
conda activate biber
```

## Customization

Most of customization (citation style, etc.) can be done by changes in the
`dfgproposal.cls`.

## Bibliography

To add references to different parts of the proposal, you can define categories:

```latex
\DeclareBibliographyCategory{reviewed}
\addtocategory{reviewed}{Hoelzer:16}
```

that can be later used in the sections:

```latex
\printbibliography[category=reviewed, heading=none]
```

### Bib Style

To change the style of your bibliography you have to change the following code snippet in the ``dfgproposal.cls`` file:

```latex
\usepackage[backend = biber,
    style = numeric, %numeric, alphabetic
    firstinits = true,
    natbib = true,
    hyperref = true,
    maxbibnames = 11, % number of authors shown
    sorting=none, % remove this to have things sorted, e.g. use style=alphabetic
    ]{biblatex}
```

## Sum up costs

The environment `funds` can be used to automatically sum up all costs specified like this:

```latex
\begin{funds}[funding for staff]

\positionmul{Research associate, TV-L 13, 36 months}{5375}{36}
\positionmul{Student assistant, TV-L 13, 12 months}{450}{12}

\end{funds}
```

## Disclaimer

Furthermore, please be aware that since May 2020 the proposal is split into a more research focused part (sections 1-4, max. 15 pages) and all the supplementary information (starting section 5, max. 10 pages). Please also always check if there are any changes to the [DFG template](https://www.dfg.de/foerderung/programme/einzelfoerderung/sachbeihilfe/formulare_merkblaetter/index.jsp)!


