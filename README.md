# gbt9704 — LaTeX Class for GB/T 9704-2012

LaTeX 文档类，严格遵循 **GB/T 9704—2012**《党政机关公文格式》标准，实现红头文件、标题分级、附件、版记等公文的自动化排版。

## 快速开始

```latex
\documentclass[redline,fzfonts]{gbt9704}
\begin{document}
\makeheader{发文机关}{发文字号〔2026〕1 号}{}
\mainreceiver{主送机关：}
正文内容...
\signature{发文机关}
\signdate{2026 年 7 月 31 日}
\end{document}
```

推荐使用 **LuaLaTeX** 编译（XeLaTeX 也可）：

```bash
lualatex document.tex
```

## 布局参数定制

`gbt9704-layout.json` 是布局参数的唯一规范源。修改此文件后运行生成器，即可调整红头字号/颜色/间距等，无需手动编辑 `.cls`。

```bash
python3 tools/json2def.py gbt9704/gbt9704-layout.json > gbt9704/gbt9704-layout.def
```

`.def` 文件由 `.cls` 自动加载（`\InputIfFileExists`）。若 `.def` 缺失，`.cls` 使用内置回退默认值。

可定制参数包括：

| 参数 | 说明 |
|------|------|
| `colors.chinese_red` | 红头及红线颜色（RGB） |
| `header_org.font_size` / `horizontal_scale` / `space_above` | 红头字号、紧缩比例、上间距 |
| `header_number.font_size` / `space_after_header_org` | 发文字号字号、与红头间距 |
| `redline.thickness` / `space_before` / `space_after` | 红线粗细、前后间距 |
| `title.font_size` | 大标题字号 |
| `mainreceiver.font_size` | 主送机关字号（长主送宜略小） |
| `signature.font_size` / `signdate.font_size` | 落款字号 |
| `page_number.font_size` | 页码字号 |

## 安装

将 `gbt9704.cls` 与 `gbt9704-layout.def` 放入工作目录，或复制到：

```
$TEXMF/tex/latex/gbt9704/
```

## 仓库

- **Codeberg**: https://codeberg.org/songwupei/latex-gbt9704
- **GitHub**: https://github.com/songwupei/gbt9704-latex

## 许可证

LPPL-1.3c
