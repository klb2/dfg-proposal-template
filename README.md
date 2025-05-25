# LaTeX DFG template 

**Last updated: May 2022**

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
Hölzer](https://github.com/hoelzer/dfg) (**last accessed in December 2022**) and
mimicks the RTF template and PDF guidelines provided by
[DFG with a focus on a "Sachbeihilfe" grant](https://www.dfg.de/foerderung/programme/einzelfoerderung/sachbeihilfe/formulare_merkblaetter/index.jsp).

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

Since DFG template version 09/22, all references are listed in section 3.

### Bib Style

To change the style of your bibliography you have to change the following code snippet in the ``dfgproposal.cls`` file:

```latex
\RequirePackage[%
    backend = biber,
    style = numeric-comp, %numeric, alphabetic
    giveninits = true,
    hyperref = true,
    maxbibnames = 10, % number of authors shown
    url=false,
    doi=true,
    eprint=true,
    isbn=false,
    defernumbers=true,
    labelnumber,
    sorting=none, % remove this to have things sorted, and use style=alphabetic
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

Furthermore, please be aware that since May 2020 the proposal is split into a more research focused part (sections 1-3, max. 17 pages) and all the supplementary information (starting with section 4, max. 8 pages).
Please also always check if there are any changes to the [DFG template](https://www.dfg.de/foerderung/programme/einzelfoerderung/sachbeihilfe/formulare_merkblaetter/index.jsp)!


