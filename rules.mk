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
#   BROWSERS
#   FTDUMP
#   HINTED_FONT_DIR
#   HINTED_FONT_URL
#   HINTING_MODES
#   LABEL_FONT
#   RAWGIT
#   SAMPLE_TEXT_DIR
#   SAMPLE_TEXT_SUFFIX
#   SCREENSHOOTER
#   TOP
#   TTFAUTOHINT
#   TTFAUTOHINT_FLAGS
#   UNHINTED_FONT_DIR
#   UNHINTED_FONT_URL
#
# We create a subdirectory `f' for all output files of font family `f'.
#
# For example, the expansion of
#
#    $(call FontFamily, NotoSansHebrew, Regular Bold, Hebr, he yi)
#
# gives
#
#   TTF_FILES += \
#     NotoSansHebrew/NotoSansHebrew-Regular-G.ttf \
#     NotoSansHebrew/NotoSansHebrew-Regular-gGD.ttf \
#     NotoSansHebrew/NotoSansHebrew-Bold-G.ttf \
#     NotoSansHebrew/NotoSansHebrew-Bold-gGD.ttf
#
#   HTML_FILES += \
#     NotoSansHebrew/NotoSansHebrew-Regular-unhinted-he.html \
#     NotoSansHebrew/NotoSansHebrew-Regular-unhinted-yi.html \
#     NotoSansHebrew/NotoSansHebrew-Regular-manual-he.html \
#     NotoSansHebrew/NotoSansHebrew-Regular-manual-yi.html \
#     NotoSansHebrew/NotoSansHebrew-Regular-G-he.html \
#     NotoSansHebrew/NotoSansHebrew-Regular-G-yi.html \
#     NotoSansHebrew/NotoSansHebrew-Regular-gGD-he.html \
#     NotoSansHebrew/NotoSansHebrew-Regular-gGD-yi.html \
#     NotoSansHebrew/NotoSansHebrew-Bold-unhinted-he.html \
#     NotoSansHebrew/NotoSansHebrew-Bold-unhinted-yi.html \
#     NotoSansHebrew/NotoSansHebrew-Bold-manual-he.html \
#     NotoSansHebrew/NotoSansHebrew-Bold-manual-yi.html \
#     NotoSansHebrew/NotoSansHebrew-Bold-G-he.html \
#     NotoSansHebrew/NotoSansHebrew-Bold-G-yi.html \
#     NotoSansHebrew/NotoSansHebrew-Bold-gGD-he.html \
#     NotoSansHebrew/NotoSansHebrew-Bold-gGD-yi.html \
#     \
#     NotoSansHebrew/index.html
#
#   PNG_FILES += \
#     NotoSansHebrew/NotoSansHebrew-Regular-unhinted-he-win8.1_firefox_37.0.png \
#     NotoSansHebrew/NotoSansHebrew-Regular-unhinted-he-win8.1_chrome_42.0.png \
#     NotoSansHebrew/NotoSansHebrew-Regular-unhinted-he-win8.1_ie_11.0.png \
#     NotoSansHebrew/NotoSansHebrew-Regular-unhinted-yi-win8.1_firefox_37.0.png \
#     NotoSansHebrew/NotoSansHebrew-Regular-unhinted-yi-win8.1_chrome_42.0.png \
#     NotoSansHebrew/NotoSansHebrew-Regular-unhinted-yi-win8.1_ie_11.0.png \
#     NotoSansHebrew/NotoSansHebrew-Regular-manual-he-win8.1_firefox_37.0.png \
#     NotoSansHebrew/NotoSansHebrew-Regular-manual-he-win8.1_chrome_42.0.png \
#     NotoSansHebrew/NotoSansHebrew-Regular-manual-he-win8.1_ie_11.0.png \
#     NotoSansHebrew/NotoSansHebrew-Regular-manual-yi-win8.1_firefox_37.0.png \
#     NotoSansHebrew/NotoSansHebrew-Regular-manual-yi-win8.1_chrome_42.0.png \
#     NotoSansHebrew/NotoSansHebrew-Regular-manual-yi-win8.1_ie_11.0.png \
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
#     NotoSansHebrew/NotoSansHebrew-Bold-unhinted-he-win8.1_firefox_37.0.png \
#     NotoSansHebrew/NotoSansHebrew-Bold-unhinted-he-win8.1_chrome_42.0.png \
#     NotoSansHebrew/NotoSansHebrew-Bold-unhinted-he-win8.1_ie_11.0.png \
#     NotoSansHebrew/NotoSansHebrew-Bold-unhinted-yi-win8.1_firefox_37.0.png \
#     NotoSansHebrew/NotoSansHebrew-Bold-unhinted-yi-win8.1_chrome_42.0.png \
#     NotoSansHebrew/NotoSansHebrew-Bold-unhinted-yi-win8.1_ie_11.0.png \
#     NotoSansHebrew/NotoSansHebrew-Bold-manual-he-win8.1_firefox_37.0.png \
#     NotoSansHebrew/NotoSansHebrew-Bold-manual-he-win8.1_chrome_42.0.png \
#     NotoSansHebrew/NotoSansHebrew-Bold-manual-he-win8.1_ie_11.0.png \
#     NotoSansHebrew/NotoSansHebrew-Bold-manual-yi-win8.1_firefox_37.0.png \
#     NotoSansHebrew/NotoSansHebrew-Bold-manual-yi-win8.1_chrome_42.0.png \
#     NotoSansHebrew/NotoSansHebrew-Bold-manual-yi-win8.1_ie_11.0.png \
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
#
#   NotoSansHebrew/NotoSansHebrew-Regular-G.ttf: \
#     NotoSansHebrew-Regular.ttf \
#     | NotoSansHebrew; \
#   \
#       $(TTFAUTOHINT) $(TTFAUTOHINT_FLAGS) -w G -F "-G" $< $@
#
#   ...more rules for similar .ttf files...
#
#
#   NotoSansHebrew/NotoSansHebrew-Regular-G-he.html: \
#     waterfall.html.in \
#     he-Hebr_$(SAMPLE_TEXT_SUFFIX) \
#     NotoSansHebrew/NotoSansHebrew-Regular-G.ttf \
#     | NotoSansHebrew; \
#   \
#       version=`$(FTDUMP) -n $(word 3,$^) \
#                | sed -n '/version string/ { n; s/ *" *//g; p; q }'` \
#       next=`echo unhinted manual G gGD unhinted manual G gGD \
#             | sed "s/.*G \([^ ][^ ]*\).*/\1/"` \
#       pngstem="$(notdir $(basename $@))" \
#       title="NotoSansHebrew-Regular, \
#              G hinting \
#              (language he)" \
#       fontname="NotoSansHebrew-Regular" \
#       fonturl="NotoSansHebrew-Regular-G.ttf" \
#       linkline="<a href=\"../index.html\">$(TOP)</a>\&nbsp;\&rsaquo;\\$(Newline) \
#                 <a href=\"index.html\">NotoSansHebrew</a>\&nbsp;\&rsaquo;\\$(Newline) \
#                 $$title" \
#       links="$$linkline\&nbsp;\&rsaquo;\\$(Newline) \
#               <a href=\"$$pngstem-win8.1_ie_11.0.png\">win8.1_ie_11.0</a> \
#                <br>\\$(Newline) \
#                <span class=\"hidden\">\\$(Newline) \
#                  $$linkline</span>\&nbsp;\&rsaquo;\\$(Newline) \
#                <a href=\"$$pngstem-win8.1_firefox_37.0.png\">win8.1_firefox_37.0</a>\\$(Newline) \
#                <br>\\$(Newline) \
#                <span class=\"hidden\">\\$(Newline) \
#                  $$linkline</span>\&nbsp;\&rsaquo;\\$(Newline) \
#                <a href=\"$$pngstem-win8.1_chrome_42.0.png\">win8.1_chrome_42.0</a>\\$(Newline)"; \
#       sed -e "s|@top@|$(TOP)|g" \
#           -e "s|@title@|$$title|" \
#           -e "s|@font-name@|$$fontname-G| \
#           -e "s|@font-version@|$$version|" \
#           -e "s|@font-next@|$$fontname-$$next|" \
#           -e "s|@font-url@|$$fonturl|" \
#           -e "s|@html-next@|$$fontname-$$next-he.html|" \
#           -e "s|@links@|$$links|" \
#           -e "s|@lang@|he|" \
#           -e "s|@text@|`cat $(word 2,$^)`|" \
#           < $< \
#           > $@
#
#   ...more rules for similar .html files...
#
#
#   NotoSansHebrew/NotoSansHebrew-Regular-G-he-win8.1_firefox_37.0.png: \
#     NotoSansHebrew/NotoSansHebrew-Regular-G-he.html \
#     win8.1_firefox_37.0.yaml \
#     | NotoSansHebrew; \
#   \
#       screenshot_url=`$(SCREENSHOOTER) shoot \
#                         --quiet \
#                         --url=$(RAWGIT)/$< \
#                         --wait \
#                        win8.1_firefox_37.0.yaml`; \
#       test $? -eq 0 \
#         && curl -s -o $@-img.$$$$ $$screenshot_url/win8.1_firefox_37.0.png \
#         && convert -font $(LABEL_FONT) -pointsize 20 label:$(notdir $@) pnm:- \
#         | pnmcrop -margin=8 \
#         > $@-text.$$$$ \
#         && cat $@-img.$$$$ \
#         | pngtopnm \
#         | pamcut -top=70 \
#         | pnmcrop -top -margin=40 \
#         | pamcomp -align=left -valign=top $@-text.$$$$ \
#         | pnmtopng \
#         > $@; \
#       rm -f $@-text.$$$$ $@-img.$$$$
#
#   ...more rules for similar .png files...
#
#
#   NotoSansHebrew/index.html: \
#     index-sub.html.in \
#     NotoSansHebrew/NotoSansHebrew-Regular-unhinted-he.html \
#     NotoSansHebrew/NotoSansHebrew-Regular-unhinted-yi.html \
#     NotoSansHebrew/NotoSansHebrew-Regular-manual-he.html \
#     NotoSansHebrew/NotoSansHebrew-Regular-manual-yi.html \
#     NotoSansHebrew/NotoSansHebrew-Regular-G-he.html \
#     NotoSansHebrew/NotoSansHebrew-Regular-G-yi.html \
#     NotoSansHebrew/NotoSansHebrew-Regular-gGD-he.html \
#     NotoSansHebrew/NotoSansHebrew-Regular-gGD-yi.html \
#     NotoSansHebrew/NotoSansHebrew-Bold-unhinted-he.html \
#     NotoSansHebrew/NotoSansHebrew-Bold-unhinted-yi.html \
#     NotoSansHebrew/NotoSansHebrew-Bold-manual-he.html \
#     NotoSansHebrew/NotoSansHebrew-Bold-manual-yi.html \
#     NotoSansHebrew/NotoSansHebrew-Bold-G-he.html \
#     NotoSansHebrew/NotoSansHebrew-Bold-G-yi.html \
#     NotoSansHebrew/NotoSansHebrew-Bold-gGD-he.html \
#     NotoSansHebrew/NotoSansHebrew-Bold-gGD-yi.html \
#     | NotoSansHebrew; \
#   \
#       sed -e "s|@top@|$(TOP)|g" \
#           -e "s|@font-family@|NotoSansHebrew|g" \
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
# arguments) in the called macros to avoid premature expansion.  Note that
# within `$(if ...)' we even have to use `$$$$' for the recipe part.

define Newline


endef


Snapshots = $(eval $(call Snapshots_, $(1), $(2), $(3), $(4), $(5)))

define Snapshots_ =
  s_fam := $$(strip $(1))
  s_sty := $$(strip $(2))
  s_lang := $$(strip $(3))
  s_hmode := $$(strip $(4))
  s_brwsr := $$(strip $(5))

  # After requesting and downloading the snapshot, we replace the link
  # section at the top of the image with the file name.

  $$(s_fam)/$$(s_fam)-$$(s_sty)-$$(s_hmode)-$$(s_lang)-$$(s_brwsr).png: \
    $$(s_fam)/$$(s_fam)-$$(s_sty)-$$(s_hmode)-$$(s_lang).html \
    $$(s_brwsr).yaml \
    | $$(s_fam); \
\
      screenshot_url=`$$(SCREENSHOOTER) shoot \
                        --quiet \
                        --url=$$(RAWGIT)/$$< \
                        --wait \
                        $$(strip $(5)).yaml`; \
      test $$$$? -eq 0 \
        && curl -s -o $$@-img.$$$$$$$$ $$$$screenshot_url/$$(strip $(5)).png \
        && convert -font $$(LABEL_FONT) -pointsize 20 label:$$(notdir $$@) pnm:- \
        | pnmcrop -margin=8 \
        > $$@-text.$$$$$$$$ \
        && cat $$@-img.$$$$$$$$ \
        | pngtopnm \
        | pamcut -top=70 \
        | pnmcrop -top -margin=40 \
        | pamcomp -align=left -valign=top $$@-text.$$$$$$$$ \
        | pnmtopng \
        > $$@; \
      rm -f $$@-text.$$$$$$$$ $$@-img.$$$$$$$$
endef


HtmlSnapshots = $(eval $(call HtmlSnapshots_, $(1), $(2), $(3), $(4), $(5), $(6)))

define HtmlSnapshots_ =
  hs_fam := $$(strip $(1))
  hs_sty := $$(strip $(2))
  hs_scr := $$(strip $(3))
  hs_lang := $$(strip $(4))
  hs_hmode := $$(strip $(5))
  hs_hmodes := $$(strip $(6))

  # Depending on the hinting mode we have to select different input TrueType
  # font files.
  $$(hs_fam)/$$(hs_fam)-$$(hs_sty)-$$(hs_hmode)-$$(hs_lang).html: \
    waterfall.html.in \
    $$(hs_lang)-$$(hs_scr)_$$(SAMPLE_TEXT_SUFFIX) \
    $$(if $$(filter unhinted,$$(hs_hmode)), \
      $$(UNHINTED_FONT_DIR)/$$(hs_fam)-$$(hs_sty).ttf, \
      $$(if $$(filter manual,$$(hs_hmode)), \
        $$(HINTED_FONT_DIR)/$$(hs_fam)-$$(hs_sty).ttf, \
        $$(hs_fam)/$$(hs_fam)-$$(hs_sty)-$$(hs_hmode).ttf \
      ) \
    ) \
    | $$(hs_fam); \
\
      version=`$$(FTDUMP) -n $$(word 3,$$^) \
               | sed -n '/version string/ { n; s/ *" *//g; p; q }'` \
      next=`echo $$(strip $(6)) $$(strip $(6)) \
            | sed "s/.*$$(strip $(5)) \([^ ][^ ]*\).*/\1/"` \
      pngstem="$$(notdir $$(basename $$@))" \
      title="$$(strip $(1))-$$(strip $(2)), \
             $$(strip $$(subst unhinted,no,$(5))) hinting \
             (language $$(strip $(4)))" \
      fontname="$$(strip $(1))-$$(strip $(2))" \
      fonturl="$$(strip $$(if $$(filter manual,$$(strip $(5))), \
                              $$(HINTED_FONT_URL)/$$$$fontname.ttf, \
                              $$(if $$(filter unhinted,$$(strip $(5))), \
                                $$(UNHINTED_FONT_URL)/$$$$fontname.ttf, \
                                $$$$fontname-$$(strip $(5)).ttf)))" \
      linkline="<a href=\"../index.html\">$$(TOP)</a>\&nbsp;\&rsaquo;\\$$(Newline) \
                <a href=\"index.html\">$$(strip $(1))</a>\&nbsp;\&rsaquo;\\$$(Newline) \
                $$$$title" \
      links="$$$$linkline\&nbsp;\&rsaquo;\\$$(Newline) \
              <a href=\"$$$$pngstem-$$(firstword $$(BROWSERS)).png\">$$(firstword $$(BROWSERS))</a> \
             $$(foreach b,$$(wordlist 2,$$(words $$(BROWSERS)),$$(BROWSERS)), \
               <br>\\$$(Newline) \
               <span class=\"hidden\">\\$$(Newline) \
                 $$$$linkline</span>\&nbsp;\&rsaquo;\\$$(Newline) \
               <a href=\"$$$$pngstem-$$(b).png\">$$(b)</a>\\$$(Newline))"; \
      sed -e "s|@top@|$$(TOP)|g" \
          -e "s|@title@|$$$$title|" \
          -e "s|@font-name@|$$$$fontname-$$(strip $(5))|g" \
          -e "s|@font-version@|$$$$version|" \
          -e "s|@font-next@|$$$$fontname-$$$$next|" \
          -e "s|@font-url@|$$$$fonturl|" \
          -e "s|@html-next@|$$$$fontname-$$$$next-$$(strip $(4)).html|" \
          -e "s|@links@|$$$$links|" \
          -e "s|@lang@|$$(strip $(4))|g" \
          -e "s+@text@+`cat $$(word 2,$$^)`+g" \
          < $$< \
          > $$@

  $$(foreach b,$$(BROWSERS), \
    $$(call Snapshots, $(1), $(2), $(4), $(5), $$(b)))
endef


FontHtmlSnapshots = $(eval $(call FontHtmlSnapshots_, $(1), $(2), $(3), $(4), $(5), $(6)))

define FontHtmlSnapshots_ =
  fh_fam := $$(strip $(1))
  fh_sty := $$(strip $(2))
  fh_scr := $$(strip $(3))
  fh_lang := $$(strip $(4))
  fh_hmode := $$(strip $(5))
  fh_hmodes := $$(strip $(6))

  $$(if $$(filter-out unhinted manual,$$(fh_hmode)), \
    $$(fh_fam)/$$(fh_fam)-$$(fh_sty)-$$(fh_hmode).ttf: \
      $$(fh_fam)-$$(fh_sty).ttf \
      | $$(fh_fam); \
\
        $$$$(TTFAUTOHINT) $$$$(TTFAUTOHINT_FLAGS) \
          -w $$$$(strip $(5)) -F "-$$$$(strip $(5))" $$$$< $$$$@ \
  )

  $$(foreach l,$$(fh_lang), \
    $$(call HtmlSnapshots, $(1), $(2), $(3), $$(l), $(5), $(6)))
endef


AddFile = $(eval $(call AddFile_, $(1), $(2)))

define AddFile_
  $(1) += $(2)
endef

# We must filter out the `manual' hinting mode if there is no manually
# hinted TrueType font.
CheckHinted = $(eval $(call CheckHinted_))

define CheckHinted_
  # It's necessary here to use the `shell' function instead of backticks,
  # synchronizing the moment of expansion with the other stuff.
  ch_hinted := $$(shell ls "$$(HINTED_FONT_DIR)/$$(ff_fam)-$$(s).ttf" 2> /dev/null)

  ff_hmodes := $$(if $$(ch_hinted),$$(HINTING_MODES), \
                                   $$(filter-out manual,$$(HINTING_MODES)))
endef


FontFamily = $(eval $(call FontFamily_, $(1), $(2), $(3), $(4)))

define FontFamily_ =
  ff_fam := $$(strip $(1))
  ff_sty := $$(strip $(2))
  ff_scr := $$(strip $(3))
  ff_lang := $$(strip $(4))

  $$(foreach s,$$(ff_sty), \
    $$(call CheckHinted) \
\
    $$(foreach hm,$$(ff_hmodes), \
      $$(if $$(filter-out unhinted manual,$$(hm)), \
        $$(call AddFile, \
                TTF_FILES, \
                $$(ff_fam)/$$(ff_fam)-$$(s)-$$(hm).ttf) \
      ) \
\
      $$(foreach l,$$(ff_lang), \
        $$(call AddFile, \
                HTML_FILES, \
                $$(ff_fam)/$$(ff_fam)-$$(s)-$$(hm)-$$(l).html) \
\
        $$(foreach b,$$(BROWSERS), \
          $$(call AddFile, \
                  PNG_FILES, \
                  $$(ff_fam)/$$(ff_fam)-$$(s)-$$(hm)-$$(l)-$$(b).png)))))

  HTML_FILES += $$(ff_fam)/index.html

  $$(ff_fam)/index.html: \
    index-sub.html.in \
    $$(foreach s,$$(ff_sty), \
      $$(call CheckHinted) \
\
      $$(foreach hm,$$(ff_hmodes), \
        $$(foreach l,$$(ff_lang), \
          $$(ff_fam)/$$(ff_fam)-$$(s)-$$(hm)-$$(l).html))) \
    | $$(ff_fam); \
\
      sed -e "s|@top@|$$(TOP)|g" \
          -e "s|@font-family@|$$(strip $(1))|g" \
          -e "s|@font-list@|$$(foreach f,$$(wordlist 2,$$(words $$^),$$^), \
              <li><a href=\"$$(notdir $$(f))\">$$(notdir $$(basename $$(f)))</a></li>\\$$(Newline))|" \
          -e "s|@date@|`LANG= date \"+%Y-%b-%d\"`|" \
          < $$< \
          > $$@

  INDEX_ENTRIES += $$(ff_fam)/index.html

  $$(foreach s,$$(ff_sty), \
    $$(call CheckHinted) \
\
    $$(foreach hm,$$(ff_hmodes), \
      $$(call FontHtmlSnapshots, $(1), $$(s), $(3), $(4), $$(hm), $$(ff_hmodes))))

  $$(ff_fam): ; \
    -mkdir $$@
endef


GenerateTargets = $(eval $(GenerateTargets_))

define GenerateTargets_ =
  index.html: \
    index.html.in \
    $$(INDEX_ENTRIES); \
\
      sed -e "s|@top@|$$(TOP)|" \
          -e "s|@font-list@|$$(foreach f,$$(INDEX_ENTRIES), \
              <li><a href=\"$$(f)\">$$(subst /index.html,,$$(f))</a></li>\\$$(Newline))|" \
          -e "s|@date@|`LANG= date \"+%Y-%b-%d\"`|" \
          < $$< \
          > $$@

  HTML_FILES += index.html

  html: $$(HTML_FILES)
  ttf: $$(TTF_FILES)
  png: $$(PNG_FILES)

  all: html ttf png

  .PHONY: all html ttf png
  .DEFAULT_GOAL := all
endef


VPATH += $(UNHINTED_FONT_DIR) \
         $(SAMPLE_TEXT_DIR)


# We have to initialize some variables as being simply expanded so that the
# `+=' operator in `FontFamily' works correctly.
INDEX_ENTRIES :=
TTF_FILES :=
HTML_FILES :=
PNG_FILES :=

# eof
