Package: gbt9704
Version: 0.1.1
Date: 2026-07-06
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
* TeX Live 2020 or later (XeLaTeX required)
* CTEX package (included in TeX Live)
* memoir class (included in TeX Live)
* Fonts:
  - FangSong, SimHei, KaiTi, SimSun (standard Windows fonts)
  - FZDaBiaoSong-B06 (FangZheng DaBiaoSong) for red headers.
    If not installed, the class will automatically fall back
    to SimHei with fake bold, with a warning message.
* Optional: zhlineskip (2026/06/30+) for CJK-aware line spacing
  control with independent bodytext/footnote/math leading.
  Install via: tlmgr install zhlineskip

OPTIONS
-------
* redline / noredline : Enable/disable red separator line under
  the red header. (Default: noredline)
* titleindent / notitleindent : Enable/disable first-line indentation
  for section titles. (Default: titleindent, complying with standard)
* zhlineskip : Enable zhlineskip package for CJK-aware proportional
  line spacing. Sets bodytextleadingratio=1.75 (28pt/16pt) and
  restores Western math leading. (Default: off)

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

HEADING FORMATS (GB/T 9704-2012)
---------------------------------
* Heading 1 (一、): SimHei (黑体), No.3, 2-char indent
* Heading 2 (（一）): KaiTi bold (楷体加粗), No.3, 2-char indent
* Heading 3 (1.): FangSong bold (仿宋加粗), No.3, 2-char indent

RECOMMENDED COMPANION PACKAGES
------------------------------
The following packages are recommended for use with gbt9704
(load them in your document preamble, not in the class file):

* fcolumn (v1.5+) — Financial table typesetting with automatic
  thousand separators, decimal alignment, and \sumline.
  Example: \usepackage[strict]{fcolumn}
           \newcolumntype{Y}{F.,{3,2}{}}
  Note: fcolumn uses European input format (, as decimal).
  For Chinese .-decimal input, consider siunitx as an alternative.

* zhlineskip (2026/06/30+) — CJK-aware proportional line spacing
  with independent bodytext/footnote/math leading control.
  Built-in support via the zhlineskip class option.

KNOWN ISSUES / LIMITATIONS
--------------------------
* The class relies on XeLaTeX; pdflatex is not supported due to
  font encoding requirements.

INSTALLATION
------------
Copy gbt9704.cls to:
$TEXMF/tex/latex/gbt9704/
or simply place it in the same folder as your .tex file.

Compile with XeLaTeX:
xelatex document.tex

CONTRIBUTION & FEEDBACK
-----------------------
Bugs, feature requests, and contributions are welcome.
Please submit via https://codeberg.org/songwupei/latex-gbt9704
or email: songwupei@163.com

CHANGELOG
---------
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
