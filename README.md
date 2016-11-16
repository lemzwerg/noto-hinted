# noto-hinted

## Noto fonts hinted with ttfautohint.

This repository contains

  * hinted versions of (some) Noto fonts generated with
    [ttfautohint](http://freetype.org/ttfautohint),

  * HTML test pages that embed the created fonts,

  * snapshot images of all HTML test pages, as rendered by Firefox, Chrome,
    and IE on MS Windows, and

  * a Makefile and some auxiliary files to (re)create the fonts, HTML
    test pages, and the snapshots.

Go to

  https://rawgit.com/lemzwerg/noto-hinted/master/

or

  http://htmlpreview.github.io/?https://github.com/lemzwerg/noto-hinted/blob/master/index.html

to view the top-level index file of the HTML test pages.

The snapshots are created automatically by
[BrowserStack](http://browserstack.com), kindly providing an account to
access its screenshot API.


## Adding new fonts

* Add a call to the `FontFamily` function to the existing ones at the end of
  `GNUmakefile`.  The last two arguments `FontFamily` are a four-letter
  script tag (like `Ethi`) and a two- or three-letter language tag (like
  `am`), respectively.

* Say `make html` to run ttfautohint on the fonts (which must be present in
  the `unhinted` directory of the `noto-fonts` git repository) and to generate
  the HTML webpages.

* Commit the changes to the repository.

* Say `make` to run the [screenshooter
  program](https://github.com/bennylope/screenshooter) which takes screen
  snapshots from BrowserStack.  This can easily fail so it might be
  necessary to repeat `make` until all screen shots are taken.

  Note that you need a BrowserStack account to make this step work; user
  name and password in the form `username:password` should be put into a
  file `.browserstack` in your home directory.
