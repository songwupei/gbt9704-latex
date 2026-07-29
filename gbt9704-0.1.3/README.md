Package: gbt9704
Version: 0.1.3
Date: 2026-07-28
License: LPPL-1.3c

========================================
LaTeX Class for GB/T 9704-2012
Chinese Official Document Format
========================================

This package provides a LaTeX document class for typesetting
documents according to the Chinese national standard
GB/T 9704-2012 (Format of official documents of party and
government organs).

REQUIREMENTS
------------
* TeX Live 2020 or later (LuaLaTeX recommended)
* CTEX package (included in TeX Live)
* memoir class (included in TeX Live)
* Required LaTeX packages (all in TeX Live):
  - iftex, fontspec, xcolor, graphicx, array, booktabs, longtable,
    caption, subcaption, ulem, alltt, indentfirst, fcolumn
* Required: bxcoloremoji + twemojis for colored emoji (LuaLaTeX).
  Install via: tlmgr install bxcoloremoji twemojis
  The emoji are rendered as colored PDF vector graphics — no emoji
  system fonts required. When using XeLaTeX, falls back to system
  emoji fonts (Segoe UI Emoji or NotoEmoji).
* Fonts:
  - FangSong, SimHei, KaiTi, SimSun (standard Windows/Chinese fonts)
  - FZDaBiaoSong-B06 (FangZheng DaBiaoSong) for red headers.
    If not installed, the class will automatically fall back
    to SimHei with fake bold, with a warning message.
  - Sarasa Mono SC (CJK monospace) + DejaVu Sans Mono (box-drawing)
* Optional: zhlineskip (2026/06/30+) for CJK-aware line spacing
  control. Install via: tlmgr install zhlineskip

OPTIONS
-------
* redline / noredline : Enable/disable red separator line under
  the red header. (Default: noredline)
* titleindent / notitleindent : Enable/disable first-line indentation
  for section titles. (Default: titleindent, complying with standard)
* zhlineskip : Enable zhlineskip package for CJK-aware proportional
  line spacing. Sets bodytextleadingratio=1.75 (28pt/16pt) and
  restores Western math leading. (Default: off)
* emoji / noemoji : Enable/disable emoji support. (Default: emoji)
  - LuaLaTeX: colored PDF vector graphics via bxcoloremoji→twemojis.
  - XeLaTeX: black-and-white via Segoe UI Emoji / NotoEmoji font fallback.

USAGE EXAMPLE
-------------
\documentclass[redline,zhlineskip]{gbt9704}
\title{文件标题}
\begin{document}
\maketitle
\section{一、总体要求}
\subsection{（一）指导思想}
正文内容...
\end{document}

MAIN COMMANDS
-------------
* \gongwentitle{...}     - Main title (No.2 DaBiaoSong, centered)
* \gongwensubtitle{...}  - Subtitle (No.3 FangSong, centered)
* \makeheader{Org}{Num}{Sig} - Red header with issuing organ,
                           document number, and signatory
* \mainreceiver{...}     - Main receiver (left-aligned, no indent)
* \attachmentHZ{...}     - Single attachment (with "附件：" prefix,
                           2-character indent)
* \attachmentNOHZ{...}   - Single attachment (without prefix,
                           5-character indent, aligned with first)
* attachments environment - Multiple attachments with \attachmentitem
* \signature{...}        - Signature (right-aligned, 2-char indent)
* \signdate{...}         - Date (right-aligned, 2-char indent)
* \notes{...}            - Notes in parentheses (no indent)
* \copyto{...}           - CC list (no indent, "抄送：" prefix)
* \issueinfo{Org}{Date}  - Issuing organ and date (left+right)
* \seprule               - Separator line for page footer area
* \emoji{...}            - Insert a colored emoji (LuaLaTeX only). Uses
                           bxcoloremoji → twemojis pipeline: each emoji
                           is a colored PDF vector graphic. Example:
                           \emoji{👍} renders as 👍. No system emoji
                           font required. Use 'noemoji' option to disable.

HEADING FORMATS (GB/T 9704-2012)
---------------------------------
* Heading 1 (一、): SimHei (黑体), No.3, 2-char indent
* Heading 2 (（一）): KaiTi bold (楷体加粗), No.3, 2-char indent
* Heading 3 (1.): FangSong bold (仿宋加粗), No.3, 2-char indent

RECOMMENDED COMPANION PACKAGES
------------------------------
* zhlineskip (2026/06/30+) — CJK-aware proportional line spacing
  with independent bodytext/footnote/math leading control.
  Built-in support via the zhlineskip class option.
  Install via: tlmgr install zhlineskip

KNOWN ISSUES / LIMITATIONS
--------------------------
* The class requires LuaLaTeX (recommended) or XeLaTeX; pdflatex is not
  supported due to font encoding requirements.
* Colored emoji (\emoji{}) requires LuaLaTeX. Uses bxcoloremoji→twemojis
  pipeline (PDF vector graphics), not system emoji fonts. Emoji inside
  verbatim environments will not render — use \emoji{} outside verbatim.

INSTALLATION
------------
Copy gbt9704.cls to:
$TEXMF/tex/latex/gbt9704/
or simply place it in the same folder as your .tex file.

Compile with LuaLaTeX:
lualatex document.tex

CONTRIBUTION & FEEDBACK
-----------------------
Bugs, feature requests, and contributions are welcome.
Please submit via https://codeberg.org/songwupei/latex-gbt9704
or email: songwupei@163.com

CHANGELOG
---------
v0.1.3 (2026-07-28) - Dual-engine emoji and financial tables.
- Unified cls supports both LuaLaTeX (colored vectors) and XeLaTeX (font fallback).
- Dual-engine emoji: bxcoloremoji→twemojis (LuaLaTeX) or Segoe UI Emoji/NotoEmoji (XeLaTeX).
- Built-in financial table support via fcolumn package (C and N column types).
- Added gongwenbody environment and \setgongwenlinespread command.
- New dependencies: fcolumn, alltt, Sarasa Mono SC, DejaVu Sans Mono.
- Font fallback for FZDaBiaoSong (graceful degradation to SimHei).
- Memoir-native title indent via \setsecindent (cleaner, hyperref-compatible).
- Soul/ulem CJK compatibility fix in \AtBeginDocument.

v0.1.2 (2026-07-28) - Engine upgrade and colored emoji support.
- Switch primary engine from XeLaTeX to LuaLaTeX.
- Add colored emoji support via bxcoloremoji → twemojis pipeline:
  each emoji renders as a colored PDF vector graphic (no system
  emoji fonts required). Uses TeX \number + Lua dec-to-hex
  conversion to bridge Unicode input to twemojis name lookup.
- Add \emoji{<character>} command and noemoji class option.
- Update documentation: two-column code/render layout for all
  emoji examples (verbatim+emoji incompatibility resolved).

v0.1.1 (2026-07-06) - Feature update.
- Add zhlineskip class option for CJK-aware proportional line spacing
  (bodytextleadingratio=1.75, footnoteleadingratio=1.75,
   restoremathleading).
- H2 (subsection): 楷体加粗 (\kaishu\bfseries).
- H3 (subsubsection): 仿宋加粗 (\normalfont\bfseries).
- \signature and \signdate: add 2-character right indent.

v0.1 (2026-06-22) - Initial Beta release.
- Core functionality for GB/T 9704-2012 compliance.
- Font fallback mechanism for FZDaBiaoSong.
- Options: redline, titleindent.
- Commands: title, section/subsection, attachments, signature, etc.
