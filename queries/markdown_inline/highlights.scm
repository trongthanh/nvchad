; From MDeiml/tree-sitter-markdown
; Local override of nvim-treesitter's bundled markdown_inline highlights.scm
; (a user query without "; extends" replaces the bundled one entirely).
;
; Difference vs. bundled: the generic `shortcut_link` bracket conceal is now
; conditional. The parser treats single-character markers like [/] and [-]
; (custom checkboxes) as shortcut links, so only link labels with >= 2
; characters get their brackets concealed. Real links like [foo] are
; unaffected, while [/] and [-] keep their brackets visible.
(code_span) @markup.raw @nospell

(emphasis) @markup.italic

(strong_emphasis) @markup.strong

(strikethrough) @markup.strikethrough

(shortcut_link
  (link_text) @nospell)

; Conceal backslash in backslash escapes
((backslash_escape) @conceal
  (#offset! @conceal 0 0 0 -1)
  (#set! conceal ""))

; Conceal backslash in hard line breaks
((hard_line_break
  "\\" @conceal)
  (#set! conceal ""))

; Conceal codeblock and text style markers
([
  (code_span_delimiter)
  (emphasis_delimiter)
] @conceal
  (#set! conceal ""))

; Conceal inline links
(inline_link
  [
    "["
    "]"
    "("
    (link_destination)
    ")"
  ] @markup.link
  (#set! conceal ""))

[
  (link_label)
  (link_title)
  (image_description)
] @markup.link.label

; Normal multi-character link texts keep the label styling. Single-character
; ones (custom checkbox markers like [/] and [-]) are excluded here so they
; don't overlap with the colored @custom.checkbox.* rules below.
((link_text) @markup.link.label
  (#match? @markup.link.label "^.."))

((inline_link
  (link_destination) @_url) @_label
  (#set! @_label url @_url))

((image
  (link_destination) @_url) @_label
  (#set! @_label url @_url))

; Conceal image links
(image
  [
    "!"
    "["
    "]"
    "("
    (link_destination)
    ")"
  ] @markup.link
  (#set! conceal ""))

; Conceal full reference links
(full_reference_link
  [
    "["
    "]"
    (link_label)
  ] @markup.link
  (#set! conceal ""))

; Conceal collapsed reference links
(collapsed_reference_link
  [
    "["
    "]"
  ] @markup.link
  (#set! conceal ""))

; Conceal shortcut links, except single-character ones (custom checkboxes like
; [/] and [-]). Per-capture conceal requires a highlighted capture, hence
; @markup.link on the brackets. `^..` = link_text is at least 2 characters.
((shortcut_link
  "[" @markup.link
  .
  (link_text) @_text
  .
  "]" @markup.link)
  (#match? @_text "^..")
  (#set! @markup.link conceal ""))

; Colored custom checkboxes (single-character shortcut links). The colors come
; from @custom.checkbox.* groups defined in chadrc.lua (base46 hl_add), so they
; follow the active theme.
; [/] — in progress (amber/orange)
((shortcut_link
  "[" @custom.checkbox.progress
  .
  (link_text) @_text @custom.checkbox.progress
  .
  "]" @custom.checkbox.progress)
  (#eq? @_text "/"))

; [-] — cancelled (red)
((shortcut_link
  "[" @custom.checkbox.cancelled
  .
  (link_text) @_text @custom.checkbox.cancelled
  .
  "]" @custom.checkbox.cancelled)
  (#eq? @_text "-"))

[
  (link_destination)
  (uri_autolink)
  (email_autolink)
] @markup.link.url @nospell

((uri_autolink) @_url
  (#offset! @_url 0 1 0 -1)
  (#set! @_url url @_url))

(entity_reference) @nospell

; Replace common HTML entities.
((entity_reference) @character.special
  (#eq? @character.special "&nbsp;")
  (#set! conceal " "))

((entity_reference) @character.special
  (#eq? @character.special "&lt;")
  (#set! conceal "<"))

((entity_reference) @character.special
  (#eq? @character.special "&gt;")
  (#set! conceal ">"))

((entity_reference) @character.special
  (#eq? @character.special "&amp;")
  (#set! conceal "&"))

((entity_reference) @character.special
  (#eq? @character.special "&quot;")
  (#set! conceal "\""))

((entity_reference) @character.special
  (#any-of? @character.special "&ensp;" "&emsp;")
  (#set! conceal " "))
