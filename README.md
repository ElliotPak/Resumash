# Resumash

*Note that Resumash is **NOT BEING ACTIVELY MAINTAINED** from this point
onward. An more powerful and easier-to-use alternative will be built by me at
some point, however.*

Resumash builds multiple versions of your LaTeX resume in 77 lines of bash
script. It can build multiple versions of your resume (an alternate version for
your site over a version you apply with elsewhere, for example) and it can also
build more "verbose" versions with extra entries for each of those versions.

I've included a sample, along with a LaTeX template, for you to play
around with. If you don't want to read all of this, just type `./resuma.sh
parts-example` and get to it!

Resumash requires only `bash` and `xelatex` to be installed.

## How to Use

Firstly, create your resume parts in a directory in this folder. Each of them
is a `.tex` file which will be concatenated with every other part. The parts
that Resumash searches for are defined in the `PARTS` variable in the script,
and are concatenated in order. To add or remove parts, change that variable.

To specify things to be added in the extra version, use `.extra.tex` as a file
extension. This will be concatenated after the regular entry.  
For an alternate version (like the site example above), prepend the extensions
in the previous section with `.site`. The alternate versions are defined in
`TYPES` in the script: feel free to add your own.

Finally, to compile, run `./resuma.sh PARTSDIR`, where `PARTSDIR` is the directory
where all of your resume parts are installed. The final PDFs will be placed
in `pdf/PARTSDIR`.  
You can also remove all directories created by Resumash with `./resuma.sh clean`.
