% ==================================================
%  gbt9704.cls  v0.1.2 20260727
%  SPDX-License-Identifier: LPPL-1.3c
%  基于 memoir 文档类，符合 GB/T 9704-2012 公文格式标准
% ==================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gbt9704}[2026-07-27 v0.1.2 GB/T 9704-2012 Document Class]

% ------------------ 引擎检测 ------------------
\RequirePackage{iftex}
\ifLuaTeX\else
  \ClassWarning{gbt9704}{LuaLaTeX is recommended. Colored emoji requires LuaLaTeX+Harfbuzz.}
\fi

% ------------------ 选项处理 ------------------
\newif\if@gbt@redline
\@gbt@redlinefalse
\newif\if@gbt@titleindent
\@gbt@titleindenttrue  % 默认开启缩进（符合国标）
\newif\if@gbt@zhlineskip
\@gbt@zhlineskipfalse
\newif\if@gbt@emoji
\@gbt@emojitrue

\DeclareOption{redline}{\@gbt@redlinetrue}
\DeclareOption{noredline}{\@gbt@redlinefalse}
\DeclareOption{titleindent}{\@gbt@titleindenttrue}
\DeclareOption{notitleindent}{\@gbt@titleindentfalse}
\DeclareOption{zhlineskip}{\@gbt@zhlineskiptrue}
\DeclareOption{noemoji}{\@gbt@emojifalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}
\ProcessOptions\relax

% ------------------ 基础类与中文 ------------------
\LoadClass[article, a4paper, 12pt, oneside]{memoir}
\RequirePackage[UTF8, scheme=plain, heading=true, fontset=none]{ctex}

% ------------------ zhlineskip 行距支持 ------------------
% GB/T 9704 要求正文三号（16pt）行距 28pt
%   bodytextleadingratio = 28pt / 16pt = 1.75
%   数学公式恢复西文行距（restoremathleading）
\if@gbt@zhlineskip
  \RequirePackage[
    bodytextleadingratio = 1.75,
    footnoteleadingratio = 1.75,
    restoremathleading,
    quiet
  ]{zhlineskip}
\fi

% ------------------ 字体回退机制（修复致命依赖） ------------------
\RequirePackage{fontspec}
\IfFontExistsTF{FZDaBiaoSong-B06}{
  \setCJKfamilyfont{dabiaosong}{FZDaBiaoSong-B06}
}{
  \setCJKfamilyfont{dabiaosong}{SimHei}[AutoFakeBold=*]
  \ClassWarning{gbt9704}{FZDaBiaoSong-B06 not found, using SimHei as fallback}
}

\setCJKmainfont{FangSong}[AutoFakeBold=3.17, AutoFakeSlant=0.2]
\setCJKsansfont{SimHei}
\setCJKmonofont{FangSong}
\setCJKfamilyfont{zhfs}{FangSong}
\setCJKfamilyfont{zhkai}{KaiTi}
\setCJKfamilyfont{zhsong}{SimSun}

% 字体切换命令
\newcommand{\heiti}{\sffamily}
\newcommand{\kaishu}{\CJKfamily{zhkai}}
\newcommand{\fangsong}{\CJKfamily{zhfs}}
\newcommand{\songti}{\CJKfamily{zhsong}}
\newcommand{\dabiaosong}{\CJKfamily{dabiaosong}}

% ------------------ 彩色 Emoji 支持（需 LuaLaTeX） ------------------
% 底层使用 bxcoloremoji → twemojis 渲染管线，输出 PDF 彩色矢量图形
\if@gbt@emoji
  \ifLuaTeX
    \IfFileExists{bxcoloremoji.sty}{%
      \RequirePackage{bxcoloremoji}
    }{%
      \ClassWarning{gbt9704}{bxcoloremoji package not found. Install via: tlmgr install bxcoloremoji}
      \@gbt@emojifalse
    }
    % Lua 辅助函数：十进制 Unicode 码点 → 十六进制字符串
    \directlua{
      function gbt_cp2hex(cp)
        local h = string.format("\@percentchar X", cp)
        tex.sprint(h)
      end
    }
  \else
    \ClassWarning{gbt9704}{Colored emoji requires LuaLaTeX. Disabling emoji support.}
    \@gbt@emojifalse
  \fi
\fi

% 用户命令：\emoji{<Unicode 字符>}
%   通过 TeX 获取字符十进制码点，Lua 转十六进制，再由 bxcoloremoji 渲染
\newcommand{\emoji}[1]{%
  \if@gbt@emoji
    \edef\@gbt@emoji@cp{\number`#1}%
    \edef\@gbt@emoji@hex{\directlua{gbt_cp2hex(\@gbt@emoji@cp)}}%
    \ifx\@gbt@emoji@hex\@empty
      \ClassWarning{gbt9704}{Emoji conversion failed: \detokenize{#1}}%
      [#1]%
    \else
      \expandafter\coloremojicode\expandafter{\@gbt@emoji@hex}%
    \fi
  \else
    \ClassWarning{gbt9704}{Emoji not available: \detokenize{#1}}%
    [#1]%
  \fi
}

% ------------------ 页面布局 ------------------
\setstocksize{297mm}{210mm}
\settrimmedsize{\stockheight}{\stockwidth}{*}
\settrims{0pt}{0pt}
\settypeblocksize{225mm}{156mm}{*}
\setlrmargins{28mm}{*}{1}
\setulmargins{37mm}{*}{1}
\checkandfixthelayout
\setcounter{secnumdepth}{0}

% ------------------ 段落与颜色 ------------------
\RequirePackage{indentfirst}
\setlength{\parindent}{2em}
\setlength{\parskip}{0pt}
\setlength{\baselineskip}{28pt}
\RequirePackage{xcolor}
\definecolor{chinese-red}{RGB}{200,16,46}
\RequirePackage[normalem]{ulem} % 替代soul，提供更安全的CJK删除线

% ------------------ 表格与图片 ------------------
\RequirePackage{graphicx, array, booktabs, longtable}
\RequirePackage{caption, subcaption}
\DeclareCaptionFont{sanhao}{\zihao{3}\fangsong}
\captionsetup{font=sanhao, labelsep=quad, justification=centering, singlelinecheck=false, skip=8pt}

% ------------------ 标题命令 ------------------
\let\@gongwentitle\@empty
\renewcommand{\title}[1]{\def\@gongwentitle{#1}}
\renewcommand{\maketitle}{%
  \ifx\@gongwentitle\@empty\else\gongwentitle{\@gongwentitle}\fi
}
\newcommand{\gongwentitle}[1]{%
  \begingroup\zihao{2}\dabiaosong\setlength{\baselineskip}{28pt}
  \begin{center}#1\par\end{center}\endgroup
}
\newcommand{\gongwensubtitle}[1]{%
  \begingroup\zihao{3}\fangsong\setlength{\baselineskip}{28pt}
  \begin{center}#1\par\end{center}\endgroup
}

% ------------------ 章节格式（使用 memoir 原生接口，兼容 hyperref） ------------------
\setbeforesecskip{0pt}\setaftersecskip{0pt}
\setbeforesubsecskip{0pt}\setaftersubsecskip{0pt}
\setbeforesubsubsecskip{0pt}\setaftersubsubsecskip{0pt}

\AtBeginDocument{%
  \zihao{3}\setlength{\baselineskip}{28pt}%
  \setlength{\parindent}{2\ccwd}%

  % 标题缩进控制
  \if@gbt@titleindent
    \setsecindent{2\ccwd}%
    \setsubsecindent{2\ccwd}%
    \setsubsubsecindent{2\ccwd}%
  \else
    \setsecindent{0pt}%
    \setsubsecindent{0pt}%
    \setsubsubsecindent{0pt}%
  \fi

  % 一级标题（黑体）
  \setsecheadstyle{\zihao{3}\heiti\raggedright}%
  % 二级标题（楷体加粗）
  \setsubsecheadstyle{\zihao{3}\kaishu\bfseries\raggedright}%
  % 三级标题（仿宋加粗）
  \setsubsubsecheadstyle{\zihao{3}\normalfont\bfseries\raggedright}%
}

% ------------------ 公文组件命令 ------------------
\newcommand{\makeheader}[3]{%
  \thispagestyle{gongwen}%
  \begin{center}\vspace*{1.2cm}
    \parbox{\textwidth}{\centering\zihao{2}\dabiaosong\textcolor{chinese-red}{\makebox[\textwidth][s]{#1}}}%
    \vspace{0.5cm}
    \parbox{\textwidth}{\centering\zihao{-3}\songti #2 \\[0.2cm] \zihao{-3}\songti #3}%
    \vspace{0.5cm}
    \if@gbt@redline\textcolor{chinese-red}{\rule{\textwidth}{1.5pt}}\fi
    \vspace{0.3cm}
  \end{center}
}

\newcommand{\mainreceiver}[1]{%
  \begingroup\zihao{3}\setlength{\baselineskip}{28pt}\noindent #1\par\endgroup
}

% 单附件
\newcommand{\attachmentHZ}[1]{%
  \par\vspace{0.3cm}\begingroup\zihao{3}\fangsong
  \setlength{\baselineskip}{28pt}\setlength{\parindent}{2\ccwd}
  附件：#1\par\endgroup
}
\newcommand{\attachmentNOHZ}[1]{%
  \par\vspace{0.3cm}\begingroup\zihao{3}\fangsong
  \setlength{\baselineskip}{28pt}\setlength{\parindent}{5\ccwd}
  #1\par\endgroup
}

% 多附件环境
\newenvironment{attachments}{%
  \par\vspace{0.3cm}\zihao{3}\fangsong\setlength{\baselineskip}{28pt}%
  \setlength{\parindent}{2\ccwd}\noindent\hspace{2\ccwd}附件：%
}{\par}
\newcommand{\attachmentitem}[2][4.9]{%
  \par\vspace{0.3cm}\noindent\hspace*{#1\ccwd}%
  \parbox[t]{\dimexpr\linewidth-#1\ccwd\relax}{\setlength{\baselineskip}{28pt}#2\strut}\par
}

\newcommand{\signature}[1]{%
  \begingroup\zihao{3}\setlength{\baselineskip}{28pt}\flushright #1\hspace{2\ccwd}\endflushright\endgroup
}
\newcommand{\signdate}[1]{%
  \begingroup\zihao{3}\setlength{\baselineskip}{28pt}\flushright #1\hspace{2\ccwd}\endflushright\endgroup
}
\newcommand{\notes}[1]{%
  \begingroup\zihao{3}\setlength{\baselineskip}{28pt}\noindent （#1）\par\endgroup
}
\newcommand{\seprule}{\noindent\rule{\textwidth}{0.5pt}\par}
\newcommand{\copyto}[1]{%
  \begingroup\zihao{3}\setlength{\baselineskip}{28pt}\noindent 抄送：#1\par\endgroup
}
\newcommand{\issueinfo}[2]{%
  \begingroup\zihao{3}\setlength{\baselineskip}{28pt}\noindent #1\hfill #2\par\endgroup
}

% ------------------ 页面风格（页码） ------------------
\makepagestyle{gongwen}
\makeevenfoot{gongwen}{\zihao{4}\thepage}{}{}
\makeoddfoot{gongwen}{}{}{\zihao{4}\thepage}
\makeevenhead{gongwen}{}{}{}\makeoddhead{gongwen}{}{}{}
\pagestyle{gongwen}

\endinput
