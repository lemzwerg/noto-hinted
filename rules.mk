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
#   HINTING_MODES
#   TTFAUTOHINT
#   TTFAUTOHINT_FLAGS
#   SAMPLE_TEXT_DIR
#   SAMPLE_TEXT_SUFFIX
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
#     \
#     NotoSansHebrew/NotoSansHebrew-Regular-G-he.html \
#     NotoSansHebrew/NotoSansHebrew-Regular-G-yi.html \
#     NotoSansHebrew/NotoSansHebrew-Regular-gGD-he.html \
#     NotoSansHebrew/NotoSansHebrew-Regular-gGD-yi.html \
#     NotoSansHebrew/NotoSansHebrew-Bold-G-he.html \
#     NotoSansHebrew/NotoSansHebrew-Bold-G-yi.html \
#     NotoSansHebrew/NotoSansHebrew-Bold-gGD-he.html
#     NotoSansHebrew/NotoSansHebrew-Bold-gGD-yi.html
#
#   NotoSansHebrew/NotoSansHebrew-%-G.ttf: \
#     NotoSansHebrew-%.ttf | NotoSansHebrew; \
#       $(TTFAUTOHINT) $(TTFAUTOHINT_FLAGS) -w G -F "-G" $< $@
#   NotoSansHebrew/NotoSansHebrew-%-gGD.ttf: \
#     NotoSansHebrew-%.ttf | NotoSansHebrew; \
#       $(TTFAUTOHINT) $(TTFAUTOHINT_FLAGS) -w gGD -F "-gGD" $< $@
#
#   NotoSansHebrew/NotoSansHebrew-%-G-he.html: \
#     waterfall.html.in | NotoSansHebrew; \
#     sed -e "s|@font-name@|NotoSansHebrew-$*-G| \
#         -e "s|@lang@|he|" \
#         -e "s|@text@|`cat $(SAMPLE_TEXT_DIR)/he-Hebr_$(SAMPLE_TEXT_SUFFIX)`|" \
#         < $< \
#         > $@
#   NotoSansHebrew/NotoSansHebrew-%-G-yi.html: \
#     waterfall.html.in | NotoSansHebrew; \
#     sed -e "s|@font-name@|NotoSansHebrew-$*-G| \
#         -e "s|@lang@|yi|" \
#         -e "s|@text@|`cat $(SAMPLE_TEXT_DIR)/yi-Hebr_$(SAMPLE_TEXT_SUFFIX)`|" \
#         < $< \
#         > $@
#   NotoSansHebrew/NotoSansHebrew-%-gGD-he.html: \
#     waterfall.html.in | NotoSansHebrew; \
#     sed -e "s|@font-name@|NotoSansHebrew-$*-gGD| \
#         -e "s|@lang@|he|" \
#         -e "s|@text@|`cat $(SAMPLE_TEXT_DIR)/he-Hebr_$(SAMPLE_TEXT_SUFFIX)`|" \
#         < $< \
#         > $@
#   NotoSansHebrew/NotoSansHebrew-%-gGD-yi.html: \
#     waterfall.html.in | NotoSansHebrew; \
#     sed -e "s|@font-name@|NotoSansHebrew-$*-gGD| \
#         -e "s|@lang@|yi|" \
#         -e "s|@text@|`cat $(SAMPLE_TEXT_DIR)/yi-Hebr_$(SAMPLE_TEXT_SUFFIX)`|" \
#         < $< \
#         > $@
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

Html = $(eval $(call Html_, $(1), $(2), $(3), $(4)))

define Html_ =
  h_fam := $$(strip $(1))
  h_scr := $$(strip $(2))
  h_hmode := $$(strip $(3))
  h_lang := $$(strip $(4))

  $$(h_fam)/$$(h_fam)-%-$$(h_hmode)-$$(h_lang).html: waterfall.html.in | $$(h_fam); \
    sed -e "s|@font-name@|$$(strip $(1))-$$*-$$(strip $(3))|g" \
        -e "s|@lang@|$$(strip $(4))|g" \
        -e "s|@text@|`cat $$(SAMPLE_TEXT_DIR)/$$(strip $(4))-$$(strip $(2))_$$(SAMPLE_TEXT_SUFFIX)`|g" \
        < $$< \
        > $$@
endef


FontHtml = $(eval $(call FontHtml_, $(1), $(2), $(3), $(4)))

define FontHtml_ =
  fh_fam := $$(strip $(1))
  fh_scr := $$(strip $(2))
  fh_lang := $$(strip $(3))
  fh_hmode := $$(strip $(4))

  $$(fh_fam)/$$(fh_fam)-%-$$(fh_hmode).ttf: $$(fh_fam)-%.ttf | $$(fh_fam); \
    $$(TTFAUTOHINT) $$(TTFAUTOHINT_FLAGS) \
      -w $$(strip $(4)) -F "-$$(strip $(4))" $$< $$@

  $$(foreach l,$$(fh_lang), \
    $$(call Html, $(1), $(2), $(4), $$(l)))
endef


FontFamily = $(eval $(call FontFamily_, $(1), $(2), $(3), $(4)))

define FontFamily_ =
  ff_fam := $$(strip $(1))
  ff_sty := $$(strip $(2))
  ff_scr := $$(strip $(3))
  ff_lang := $$(strip $(4))

  all: $$(foreach s,$$(ff_sty), \
         $$(foreach hm,$$(HINTING_MODES), \
           $$(ff_fam)/$$(ff_fam)-$$(s)-$$(hm).ttf \
           $$(foreach l,$$(ff_lang), \
             $$(ff_fam)/$$(ff_fam)-$$(s)-$$(hm)-$$(l).html)))

  $$(foreach hm,$$(HINTING_MODES), \
    $$(call FontHtml, $(1), $(3), $(4), $$(hm)))

  $$(ff_fam): ; \
    -mkdir $$@
endef

.PHONY: all
VPATH += $(NOTO_DIR)

# eof
