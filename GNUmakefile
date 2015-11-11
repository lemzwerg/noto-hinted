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


include rules.mk


# The directory where the unhinted Noto fonts reside.
NOTO_DIR ?= ../noto-fonts/unhinted

# The directory where the sample texts are stored.  The name of the files
# must be of the form `<lang>-<script>_$(SAMPLE_TEXT_SUFFIX)', where <lang>
# is a two-letter tag (given as the fourth argument to the `FontFamily'
# macro below) and <script> a four-letter tag (the third argument).
#
# Example: `ar-Arab_uhdr.txt'.
#
SAMPLE_TEXT_DIR ?= ../nototools/sample_texts
SAMPLE_TEXT_SUFFIX ?= udhr.txt

# The ttfautohint binary.
#
TTFAUTOHINT ?= ../ttfautohint/frontend/ttfautohint

# ttfautohint flags (except `-F' and `-w', which we add separately).
#
TTFAUTOHINT_FLAGS ?= -t

# The ftdump binary, a FreeType demo program.
#
FTDUMP ?= ftdump

# Hinting modes for ttfautohint.  This sets ttfautohint option `-w'.  The
# modes are also added as a suffix to both the output font name (ttfautohint
# option `-F') and the output font's file name (via Makefile rules).
#
# `G' means strong hinting for GDI ClearType only, `gGD' indicates strong
# hinting for all hinting modes (grayscale, GDI, and DWrite ClearType).
#
# [If you use more than two hinting modes, there is a harmless buglet: Some
# links to the `same font, next hinting mode' links on the waterfall pages
# will not be correctly set.]
#
HINTING_MODES ?= G gGD


# Add new fonts here.
#
$(call FontFamily, NotoSans,         Regular Bold Italic BoldItalic, Latn, en cs vi)
$(call FontFamily, NotoSerif,        Regular Bold Italic BoldItalic, Latn, en cs vi)

$(call FontFamily, NotoSansHebrew,   Regular Bold, Hebr, he yi)

$(call FontFamily, NotoSansThai,     Regular Bold, Thai, th)
$(call FontFamily, NotoSerifThai,    Regular Bold, Thai, th)

$(call FontFamily, NotoNaskhArabic,  Regular Bold, Arab, ar fa)
$(call FontFamily, NotoNastaliqUrdu, Regular,      Arab, ur)

$(call FontFamily, NotoSansLao,      Regular Bold, Laoo, lo)
$(call FontFamily, NotoSerifLao,     Regular Bold, Laoo, lo)

# This macro regenerates `index.html' if necessary.
#
$(Index)

# eof
