% ==================================================
%  gbt9704.cls  v0.1 20260622
%  SPDX-License-Identifier: LPPL-1.3c
%  基于 memoir 文档类，符合 GB/T 9704-2012 公文格式标准
%  当前状态: Beta - 欢迎反馈
% ==================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gbt9704}[2026-06-22 v0.1 GB/T 9704-2012 Document Class (Beta)]

% ------------------ 选项处理 ------------------
\newif\if@gbt@redline
\@gbt@redlinefalse
\newif\if@gbt@titleindent
\@gbt@titleindenttrue  % 默认开启缩进（符合国标）

\DeclareOption{redline}{\@gbt@redlinetrue}
\DeclareOption{noredline}{\@gbt@redlinefalse}
\DeclareOption{titleindent}{\@gbt@titleindenttrue}
\DeclareOption{notitleindent}{\@gbt@titleindentfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}
\ProcessOptions\relax

% ------------------ 基础类与中文 ------------------
\LoadClass[article, a4paper, 12pt, oneside]{memoir}
\RequirePackage[UTF8, scheme=plain, heading=true, fontset=none]{ctex}

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
  % 二级标题（楷体）
  \setsubsecheadstyle{\zihao{3}\kaishu\raggedright}%
  % 三级标题（仿宋）
  \setsubsubsecheadstyle{\zihao{3}\normalfont\raggedright}%
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
  \begingroup\zihao{3}\setlength{\baselineskip}{28pt}\flushright #1\endflushright\endgroup
}
\newcommand{\signdate}[1]{%
  \begingroup\zihao{3}\setlength{\baselineskip}{28pt}\flushright #1\endflushright\endgroup
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
