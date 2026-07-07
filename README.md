# gbt9704 — LaTeX Class for GB/T 9704-2012

LaTeX 文档类，严格遵循 **GB/T 9704—2012**《党政机关公文格式》标准，实现红头文件、标题分级、附件、版记等公文的自动化排版。

## 快速开始

```latex
\documentclass[redline,zhlineskip]{gbt9704}
\title{文件标题}
\begin{document}
\maketitle
\section{一、总体要求}
正文内容...
\end{document}
```

使用 **XeLaTeX** 编译：

```bash
xelatex document.tex
```

## 安装

将 `gbt9704.cls` 放入工作目录，或复制到：

```
$TEXMF/tex/latex/gbt9704/
```

## 仓库

- **Codeberg**: https://codeberg.org/songwupei/latex-gbt9704
- **GitHub**: https://github.com/songwupei/gbt9704-latex

## 许可证

LPPL-1.3c
