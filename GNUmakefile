# Copyright 2015 by
# Werner Lemberg <wl@gnu.org>.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License.  You may obtain a
# copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
# License for the specific language governing permissions and limitations
# under the License.


# Possible targets:
#
#   ttf    generate TrueType files with ttfautohint
#   html   generate HTML pages (this also needs generated TTF files)
#   png    generate PNG images from HTML pages via browserstack
#
#   all    make `ttf', `html', and `png' targets

include rules.mk


# The following programs are expected to be in $PATH.
#
#   cat
#   convert (from the ImageMagick package)
#   curl
#   date
#   mkdir
#   pamcut, pamcomp, pngtopnm, pnmtopng, pnmcrop (from the netpbm package)
#   rm
#   sed


# The name assigned in links to the repository's top-level `index.html'
# file.
#
TOP ?= Noto

# The directory where the unhinted fonts reside.
#
UNHINTED_FONT_DIR ?= ../noto-fonts/unhinted

# A URL to access the unhinted fonts.
#
UNHINTED_FONT_URL ?= https://rawgit.com/googlei18n/noto-fonts/master/unhinted

# The directory where the manually hinted fonts reside.  If there is no
# manually hinted version of a font, it gets ignored.
#
HINTED_FONT_DIR ?= ../noto-fonts/hinted

# A URL to access the manually hinted fonts.
#
HINTED_FONT_URL ?= https://rawgit.com/googlei18n/noto-fonts/master/hinted

# The directory where the sample texts are stored.  The name of the files
# must be of the form `<lang>-<script>_$(SAMPLE_TEXT_SUFFIX)', where <lang>
# is a two-letter or three-letter tag (given as the fourth argument to the
# `FontFamily' macro below) and <script> a four-letter tag (the third
# argument).
#
# Example: `ar-Arab_uhdr.txt'.
#
SAMPLE_TEXT_DIR    ?= ../nototools/sample_texts
SAMPLE_TEXT_SUFFIX ?= udhr.txt

# The ttfautohint binary.
#
TTFAUTOHINT ?= ../ttfautohint/frontend/ttfautohint

# ttfautohint flags (except `-F' and `-w', which we add separately).
#
TTFAUTOHINT_FLAGS ?= -t

# A font for labeling PNG images with ImageMagick's `convert' program.
#
LABEL_FONT ?= Times-Roman

# The ftdump binary, a FreeType demo program.  We use it to extract a font's
# version string from its `name' table.
#
FTDUMP ?= ftdump

# The URL prefix to access HTML pages for the repository we are going to
# fill with created files.  Note that directly accessing `github.com'
# doesn't work since HTML pages (intentionally) get a `Content-Type' of
# `text/plain'.
#
RAWGIT ?= https://rawgit.com/lemzwerg/noto-hinted/master

# A program to access the browserstack API on the command line.  We are
# using a Ruby gem called `screenshooter'; see
#
#  https://github.com/bennylope/screenshooter
#
# for more.
#
SCREENSHOOTER ?= screenshooter.ruby2.1

# Hinting modes for ttfautohint.  This sets ttfautohint option `-w'.  The
# modes are also added as a suffix to both the output font name (ttfautohint
# option `-F') and the output font's file name (via Makefile rules).
#
# `G' means strong hinting for GDI ClearType only, `gGD' indicates strong
# hinting for all hinting modes (grayscale, GDI, and DWrite ClearType).
#
# Two values are special: `manual' and `unhinted'.  They are not options for
# ttfautohint; instead, they refer to already existing fonts located in the
# directories given by `HINTED_FONT_DIR' and `UNHINTED_FONT_DIR',
# respectively.
#
# This Makefile generates separate HTML test pages for each value in
# `HINTING_MODES'.
#
HINTING_MODES ?= unhinted manual G gGD

# The browsers, as set up in the `*.yaml' files, which are also used by
# browserstack for `*.png' snapshot file names.
#
BROWSERS ?= win8.1_ie_11.0 \
            win8.1_firefox_37.0 \
            win8.1_chrome_42.0


# Add new fonts here.
#
$(call FontFamily, NotoSans,           Regular Bold Italic BoldItalic, Latn, en cs vi)
$(call FontFamily, NotoSerif,          Regular Bold Italic BoldItalic, Latn, en cs vi)

$(call FontFamily, NotoSansHebrew,     Regular Bold, Hebr, he yi)

$(call FontFamily, NotoSansThai,       Regular Bold, Thai, th)
$(call FontFamily, NotoSerifThai,      Regular Bold, Thai, th)

$(call FontFamily, NotoNaskhArabic,    Regular Bold, Arab, ar fa)
$(call FontFamily, NotoNastaliqUrdu,   Regular,      Arab, ur)

$(call FontFamily, NotoSansLao,        Regular Bold, Laoo, lo)
$(call FontFamily, NotoSerifLao,       Regular Bold, Laoo, lo)

$(call FontFamily, NotoSansKhmer,      Regular Bold, Khmr, km)
$(call FontFamily, NotoSerifKhmer,     Regular Bold, Khmr, km)

$(call FontFamily, NotoSansMyanmar,    Regular Bold, Mymr, my)

$(call FontFamily, NotoSansBengali,    Regular Bold, Beng, bn)
$(call FontFamily, NotoSerifBengali,   Regular Bold, Beng, bn)

$(call FontFamily, NotoSansDevanagari, Regular Bold, Deva, hi)

$(call FontFamily, NotoSansKannada,    Regular Bold, Knda, kn)
$(call FontFamily, NotoSerifKannada,   Regular Bold, Knda, kn)

$(call FontFamily, NotoSansMalayalam,  Regular Bold, Mlym, ml)
$(call FontFamily, NotoSerifMalayalam, Regular Bold, Mlym, ml)

$(call FontFamily, NotoSansSinhala,    Regular Bold, Sinh, si)

$(call FontFamily, NotoSansTamil,      Regular Bold, Taml, ta)
$(call FontFamily, NotoSerifTamil,     Regular Bold, Taml, ta)

$(call FontFamily, NotoSansTelugu,     Regular Bold, Telu, te)
$(call FontFamily, NotoSerifTelugu,    Regular Bold, Telu, te)

$(call FontFamily, NotoSansGeorgian,   Regular Bold, Geor, ka)
$(call FontFamily, NotoSerifGeorgian,  Regular Bold, Geor, ka)

$(call FontFamily, NotoSansGujarati,   Regular Bold, Gujr, gu)
$(call FontFamily, NotoSerifGujarati,  Regular Bold, Gujr, gu)

$(call FontFamily, NotoSansGurmukhi,   Regular Bold, Guru, pa)

$(call FontFamily, NotoSansArmenian,   Regular Bold, Armn, hy)
$(call FontFamily, NotoSerifArmenian,  Regular Bold, Armn, hy)

$(call FontFamily, NotoSansEthiopic,   Regular Bold, Ethi, am)

$(call FontFamily, NotoSansCherokee,   Regular,      Cher, chr)

# This macro generates the top-level targets.
#
$(GenerateTargets)

# eof
