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


# FontFamily
# ----------
#
# Arguments:
#
#   $(1)  the font family name;
#   $(2)  the available font styles;
#   $(3)  a single 4-letter script tag, following ISO 15924 (e.g., `Arab');
#   $(4)  two or more 2-letter language tags (following ISO 639-1, e.g., `ar
#         fa'), or 3-letter tags if there doesn't exist a 2-letter tag
#         (following ISO 639-2, e.g., `yao').
#
# The following variables must be set; see the top-level `Makefile' for
# explanations.
#
#   FTDUMP
#   HINTING_MODES
#   SAMPLE_TEXT_SUFFIX
#   TTFAUTOHINT
#   TTFAUTOHINT_FLAGS
#
# We create a subdirectory `f' for all output files of font family `f'.
#
# For example, the expansion of
#
#    $(call FontFamily, NotoSansHebrew, Regular Bold, Hebr, he yi)
#
# gives
#
#   all: \
#     NotoSansHebrew/NotoSansHebrew-Regular-G.ttf \
#     NotoSansHebrew/NotoSansHebrew-Regular-gGD.ttf \
#     NotoSansHebrew/NotoSansHebrew-Bold-G.ttf \
#     NotoSansHebrew/NotoSansHebrew-Bold-gGD.ttf \
#   \
#     NotoSansHebrew/NotoSansHebrew-Regular-G-he.html \
#     NotoSansHebrew/NotoSansHebrew-Regular-G-yi.html \
#     NotoSansHebrew/NotoSansHebrew-Regular-gGD-he.html \
#     NotoSansHebrew/NotoSansHebrew-Regular-gGD-yi.html \
#     NotoSansHebrew/NotoSansHebrew-Bold-G-he.html \
#     NotoSansHebrew/NotoSansHebrew-Bold-G-yi.html \
#     NotoSansHebrew/NotoSansHebrew-Bold-gGD-he.html \
#     NotoSansHebrew/NotoSansHebrew-Bold-gGD-yi.html \
#   \
#     NotoSansHebrew/NotoSansHebrew-Regular-G-he-win8.1_firefox_37.0.png \
#     NotoSansHebrew/NotoSansHebrew-Regular-G-he-win8.1_chrome_42.0.png \
#     NotoSansHebrew/NotoSansHebrew-Regular-G-he-win8.1_ie_11.0.png \
#     NotoSansHebrew/NotoSansHebrew-Regular-G-yi-win8.1_firefox_37.0.png \
#     NotoSansHebrew/NotoSansHebrew-Regular-G-yi-win8.1_chrome_42.0.png \
#     NotoSansHebrew/NotoSansHebrew-Regular-G-yi-win8.1_ie_11.0.png \
#     NotoSansHebrew/NotoSansHebrew-Regular-gGD-he-win8.1_firefox_37.0.png \
#     NotoSansHebrew/NotoSansHebrew-Regular-gGD-he-win8.1_chrome_42.0.png \
#     NotoSansHebrew/NotoSansHebrew-Regular-gGD-he-win8.1_ie_11.0.png \
#     NotoSansHebrew/NotoSansHebrew-Regular-gGD-yi-win8.1_firefox_37.0.png \
#     NotoSansHebrew/NotoSansHebrew-Regular-gGD-yi-win8.1_chrome_42.0.png \
#     NotoSansHebrew/NotoSansHebrew-Regular-gGD-yi-win8.1_ie_11.0.png \
#     NotoSansHebrew/NotoSansHebrew-Bold-G-he-win8.1_firefox_37.0.png \
#     NotoSansHebrew/NotoSansHebrew-Bold-G-he-win8.1_chrome_42.0.png \
#     NotoSansHebrew/NotoSansHebrew-Bold-G-he-win8.1_ie_11.0.png \
#     NotoSansHebrew/NotoSansHebrew-Bold-G-yi-win8.1_firefox_37.0.png \
#     NotoSansHebrew/NotoSansHebrew-Bold-G-yi-win8.1_chrome_42.0.png \
#     NotoSansHebrew/NotoSansHebrew-Bold-G-yi-win8.1_ie_11.0.png \
#     NotoSansHebrew/NotoSansHebrew-Bold-gGD-he-win8.1_firefox_37.0.png \
#     NotoSansHebrew/NotoSansHebrew-Bold-gGD-he-win8.1_chrome_42.0.png \
#     NotoSansHebrew/NotoSansHebrew-Bold-gGD-he-win8.1_ie_11.0.png \
#     NotoSansHebrew/NotoSansHebrew-Bold-gGD-yi-win8.1_firefox_37.0.png \
#     NotoSansHebrew/NotoSansHebrew-Bold-gGD-yi-win8.1_chrome_42.0.png \
#     NotoSansHebrew/NotoSansHebrew-Bold-gGD-yi-win8.1_ie_11.0.png \
#   \
#     NotoSansHebrew/index.html \
#     index.html
#
#
#   NotoSansHebrew/NotoSansHebrew-%-G.ttf: \
#     NotoSansHebrew-%.ttf \
#     | NotoSansHebrew; \
#   \
#       $(TTFAUTOHINT) $(TTFAUTOHINT_FLAGS) -w G -F "-G" $< $@
#
#   ...more rules for similar .ttf files...
#
#
#   NotoSansHebrew/NotoSansHebrew-%-G-he.html: \
#     waterfall.html.in \
#     he-Hebr_$(SAMPLE_TEXT_SUFFIX) \
#     NotoSansHebrew/NotoSansHebrew-%-G.ttf \
#     | NotoSansHebrew; \
#   \
#       version=`$(FTDUMP) -n $(word 3,$^) \
#                | sed -n '/; ttfautohint/ { s/ *"//g; p }'` \
#       next="$(filter-out G,$(HINTING_MODES))"; \
#       sed -e "s|@font-family@|NotoSansHebrew|g" \
#           -e "s|@font-name@|NotoSansHebrew-$*-G| \
#           -e "s|@font-version@|$$version|" \
#           -e "s|@font-next@|NotoSansHebrew-$*-$$next|" \
#           -e "s|@html-next@|NotoSansHebrew-$*-$$next-he.html|" \
#           -e "s|@lang@|he|" \
#           -e "s|@text@|`cat $(word 2,$^)`|" \
#           < $< \
#           > $@
#
#   ...more rules for similar .html files...
#
#
#   NotoSansHebrew/NotoSansHebrew-%-G-he-win8.1_firefox_37.0.png: \
#     NotoSansHebrew/NotoSansHebrew-%-G-he.html \
#     win8.1_firefox_37.0.yaml \
#     | NotoSansHebrew; \
#   \
#       screenshot_url=`$(SCREENSHOOTER) shoot \
#                         --url=$(RAWGIT)/$< \
#                         --wait \
#                        win8.1_firefox_37.0.yaml`; \
#       test $? -eq 0 \
#         && curl -o $@.$$$$ $$screenshot_url/win8.1_firefox_37.0.png \
#         && cat $@.$$$$ \
#         | pngtopnm \
#         | pnmcrop -top -margin=8 \
#         | pnmtopng \
#         > $@; \
#       rm -f $@.$$$$
#
#   ...more rules for similar .png files...
#
#
#   NotoSansHebrew/index.html: \
#     index-sub.html.in \
#     NotoSansHebrew/NotoSansHebrew-Regular-G-he.html \
#     NotoSansHebrew/NotoSansHebrew-Regular-G-yi.html \
#     NotoSansHebrew/NotoSansHebrew-Regular-gGD-he.html \
#     NotoSansHebrew/NotoSansHebrew-Regular-gGD-yi.html \
#     NotoSansHebrew/NotoSansHebrew-Bold-G-he.html \
#     NotoSansHebrew/NotoSansHebrew-Bold-G-yi.html \
#     NotoSansHebrew/NotoSansHebrew-Bold-gGD-he.html \
#     NotoSansHebrew/NotoSansHebrew-Bold-gGD-yi.html \
#     | NotoSansHebrew; \
#   \
#       sed -e "s|@font-family@|NotoSansHebrew|" \
#           -e "s|@font-list@|$(foreach f,$(wordlist 2,$(words $^),$^), \
#               <li><a href=\"$(notdir $(f))\">$(notdir $(basename $(f)))</a></li>\\$(Newline))|" \
#           -e "s|@date@|`LANG= date \"+%Y-%b-%d\"`|" \
#           < $< \
#           > $@
#
#   INDEX_ENTRIES += NotoSansHebrew/index.html
#
#   NotoSansHebrew: ; \
#       -mkdir $@


# We use temporary variables to make the code more readable.  Note, however,
# that we have to use macro arguments like `$(1)' directly in recipes since
# they are executed after variable expansion has happened: At that time
# those temporary variables normally have different values (from later calls
# to `FontFamily').
#
# The body (i.e., the third argument) of the `foreach' function that create
# multiple targets must be encapsulated in separate multi-line variables;
# otherwise you get syntax warnings related to newline issues.
#
# To be able to create make targets at all, we have to use the `eval'
# function; this further implies to use `$$' instead `$' (except for macro
# arguments) in the called macros to avoid premature expansion.
#
# The pattern character (`%') in the created rules is used to match the font
# style (`Regular', `Bold', etc.).


Snapshots = $(eval $(call Snapshots_, $(1), $(2), $(3), $(4), $(5)))

define Snapshots_ =
  s_fam := $$(strip $(1))
  s_hmode := $$(strip $(2))
  s_lang := $$(strip $(3))
  s_brwsr := $$(strip $(4))

  # After requesting and downloading the snapshot, we create a consistent
  # top margin of 8px in the image to harmonize the appearance between
  # different browsers: Firefox snapshots of the waterfall pages start two
  # pixels lower...

  $$(s_fam)/$$(s_fam)-%-$$(s_hmode)-$$(s_lang)-$$(s_brwsr).png: \
    $$(s_fam)/$$(s_fam)-%-$$(s_hmode)-$$(s_lang).html \
    $$(s_brwsr).yaml \
    | $$(s_fam); \
\
      screenshot_url=`$$(SCREENSHOOTER) shoot \
                        --url=$$(RAWGIT)/$$< \
                        --wait \
                        $$(strip $(4)).yaml`; \
      test $$$$? -eq 0 \
        && curl -o $$@.$$$$$$$$ $$$$screenshot_url/$$(strip $(4)).png \
        && cat $$@.$$$$$$$$ \
        | pngtopnm \
        | pnmcrop -top -margin=8 \
        | pnmtopng \
        > $$@; \
      rm -f $$@.$$$$$$$$
endef


HtmlSnapshots = $(eval $(call HtmlSnapshots_, $(1), $(2), $(3), $(4)))

define HtmlSnapshots_ =
  hs_fam := $$(strip $(1))
  hs_scr := $$(strip $(2))
  hs_hmode := $$(strip $(3))
  hs_lang := $$(strip $(4))

  $$(hs_fam)/$$(hs_fam)-%-$$(hs_hmode)-$$(hs_lang).html: \
    waterfall.html.in \
    $$(hs_lang)-$$(hs_scr)_$$(SAMPLE_TEXT_SUFFIX) \
    $$(hs_fam)/$$(hs_fam)-%-$$(hs_hmode).ttf \
    | $$(hs_fam); \
\
      version=`$$(FTDUMP) -n $$(word 3,$$^) \
               | sed -n '/; ttfautohint/ { s/ *"//g; p }'` \
      next="$$(filter-out $$(strip $(3)),$$(HINTING_MODES))"; \
      sed -e "s|@font-family@|$$(strip $(1))|g" \
          -e "s|@font-name@|$$(strip $(1))-$$*-$$(strip $(3))|g" \
          -e "s|@font-version@|$$$$version|" \
          -e "s|@font-next@|$$(strip $(1))-$$*-$$$$next|" \
          -e "s|@html-next@|$$(strip $(1))-$$*-$$$$next-$$(strip $(4)).html|" \
          -e "s|@lang@|$$(strip $(4))|g" \
          -e "s|@text@|`cat $$(word 2,$$^)`|g" \
          < $$< \
          > $$@

  $$(foreach b,$$(BROWSERS), \
    $$(call Snapshots, $(1), $(3), $(4), $$(b)))
endef


FontHtmlSnapshots = $(eval $(call FontHtmlSnapshots_, $(1), $(2), $(3), $(4)))

define FontHtmlSnapshots_ =
  fh_fam := $$(strip $(1))
  fh_scr := $$(strip $(2))
  fh_lang := $$(strip $(3))
  fh_hmode := $$(strip $(4))

  $$(fh_fam)/$$(fh_fam)-%-$$(fh_hmode).ttf: \
    $$(fh_fam)-%.ttf \
    | $$(fh_fam); \
\
      $$(TTFAUTOHINT) $$(TTFAUTOHINT_FLAGS) \
        -w $$(strip $(4)) -F "-$$(strip $(4))" $$< $$@

  $$(foreach l,$$(fh_lang), \
    $$(call HtmlSnapshots, $(1), $(2), $(4), $$(l)))
endef


# Note the double-colon rule to have one recipe per `FontFamily' call for
# target `all'.

FontFamily = $(eval $(call FontFamily_, $(1), $(2), $(3), $(4)))

define FontFamily_ =
  ff_fam := $$(strip $(1))
  ff_sty := $$(strip $(2))
  ff_scr := $$(strip $(3))
  ff_lang := $$(strip $(4))

  all:: \
    $$(foreach s,$$(ff_sty), \
      $$(foreach hm,$$(HINTING_MODES), \
        $$(ff_fam)/$$(ff_fam)-$$(s)-$$(hm).ttf \
\
        $$(foreach l,$$(ff_lang), \
          $$(ff_fam)/$$(ff_fam)-$$(s)-$$(hm)-$$(l).html \
\
          $$(foreach b,$$(BROWSERS), \
            $$(ff_fam)/$$(ff_fam)-$$(s)-$$(hm)-$$(l)-$$(b).png)))) \
\
    $$(ff_fam)/index.html \
    index.html

  $$(ff_fam)/index.html: \
    index-sub.html.in \
    $$(foreach s,$$(ff_sty), \
      $$(foreach hm,$$(HINTING_MODES), \
        $$(foreach l,$$(ff_lang), \
          $$(ff_fam)/$$(ff_fam)-$$(s)-$$(hm)-$$(l).html))) \
    | $$(ff_fam); \
\
      sed -e "s|@font-family@|$$(strip $(1))|" \
          -e "s|@font-list@|$$(foreach f,$$(wordlist 2,$$(words $$^),$$^), \
              <li><a href=\"$$(notdir $$(f))\">$$(notdir $$(basename $$(f)))</a></li>\\$$(Newline))|" \
          -e "s|@date@|`LANG= date \"+%Y-%b-%d\"`|" \
          < $$< \
          > $$@

  INDEX_ENTRIES += $$(ff_fam)/index.html

  $$(foreach hm,$$(HINTING_MODES), \
    $$(call FontHtmlSnapshots, $(1), $(3), $(4), $$(hm)))

  $$(ff_fam): ; \
    -mkdir $$@
endef


define Newline


endef


Index = $(eval $(Index_))

define Index_ =
  index.html: \
    index.html.in \
    $$(INDEX_ENTRIES); \
\
      sed -e "s|@font-list@|$$(foreach f,$$(INDEX_ENTRIES), \
              <li><a href=\"$$(f)\">$$(subst /index.html,,$$(f))</a></li>\\$$(Newline))|" \
          -e "s|@date@|`LANG= date \"+%Y-%b-%d\"`|" \
          < $$< \
          > $$@
endef


.PHONY: all
.DEFAULT_GOAL := all

VPATH += $(NOTO_DIR) \
         $(SAMPLE_TEXT_DIR)

# We have to initialize INDEX_ENTRIES as being simply expanded so that the
# `+=' operator in `FontFamily' works correctly.
INDEX_ENTRIES :=

# eof
