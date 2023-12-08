\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ExamJHSMath}[templates]

\LoadClass[11pt]{book}
\usepackage[fontset=ubuntu]{ctex}
\usepackage[bodytextleadingratio=1.5,restoremathleading=true]{zhlineskip}
\usepackage{geometry}
\geometry{
    papersize = {182mm, 257mm},
    inner = 22mm, outer = 18mm,
    % left = 20mm, right = 20mm,
    top = 16mm, bottom = 20mm
}


% ----- 功能调试 -----

%% 显示框线
% \usepackage{showframe}


% ----- 预留功能 -----

% \usepackage{xcolor} % 颜色
% \usepackage{graphbox} 


% ----- 字体配置 -----

\usepackage[T1]{fontenc}
\setmainfont{TeX Gyre Termes}
\newfontfamily\Serif{TeX Gyre Termes}


% Overleaf 字体
\newCJKfontfamily\Kai{FandolKai}
\newCJKfontfamily\Hei{FandolHei}
\newCJKfontfamily\Song{Noto Serif CJK SC}
% 上传 GBK 字体
\setCJKmainfont[Path="fonts/"]{FZNewShuSong-Z10.ttf}
\setCJKfamilyfont{FZXBSong}[Path="fonts/"]{FZXiaoBiaoSong-B05S.ttf}
\newcommand{\XBSong}{\CJKfamily{FZXBSong}}

%% 指定某些标点符号不使用 GBK 字体
\catcode`“=\active
\protected\def “{{\Serif\char`“}}
\catcode`”=\active
\protected\def ”{{\Serif\char`”}}
\catcode`—=\active
\protected\def —{{\Serif\char`\—}}
\catcode`℃=\active
\protected\def ℃{{\Serif\char`\℃}}
\catcode`《=\active
\protected\def 《{{\Hei\char`\《}}
\catcode`》=\active
\protected\def 》{{\Hei\char`\》}}

%% 修正圆圈序号字体不匹配而无法显示的错误
\usepackage{pifont}
\xeCJKDeclareCharClass{CJK}{%
  "24EA,        % ⓪
  "2460->"2473, % ①–⑳
  "3251->"32BF, % ㉑–㊿
  "24FF,        % ⓿
  "2776->"277F, % ❶–❿
  "24EB->"24F4  % ⓫–⓴
}


% ----- 章节与项目格式 -----

\usepackage{titlesec, titletoc}
\usepackage[shortlabels]{enumitem}

%% 设置各级文本格式
\setcounter{secnumdepth}{3}
\titleformat{\chapter}{\zihao{5}}{}{0em}{}
\titleformat{\section}{\zihao{4}\Hei\centering}{
    第\Roman{section}卷\quad
}{0em}{}
\titleformat{\subsection}{\linespread{1}\zihao{5}\Hei}{
    \chinese{subsection}、
}{0em}{}
\titleformat{\subsubsection}{\zihao{5}\Hei}{
    第{\chinese{subsubsection}}节\quad
}{0em}{}
\titlespacing*{\chapter}{0mm}{0mm}{-10mm}
\titlespacing*{\section}{0em}{1.25em}{0.5em}
\titlespacing*{\subsection}{-0.25em}{0em}{0em}
\titlespacing*{\subsubsection}{0em}{0.1em}{0.1em}

%% 设置各级文本的编号格式
\setlist{itemsep=0.2em,topsep=0.25em,partopsep=0pt,parsep=0pt}
\setenumerate[1]{label=\arabic*.,leftmargin=1.2em,itemindent=0em,labelsep=0.2em,ref={\arabic*}}
\setenumerate[2]{label=(\arabic*),leftmargin=1.2em,itemindent=0em,labelsep=0.25em,}
\setenumerate[3]{label=(\alph*),leftmargin=1.2em,itemindent=0em,labelsep=0.25em,}


% ----- 对齐、浮动与并排 -----

%% 横向并排布局
\usepackage{tasks}
\settasks{
    label=(\arabic*),
    item-indent={1em},
    label-width=1.5em,
    label-offset=0pt
}

%% 页面垂直顶端分布
\raggedbottom

%% 图片右侧浮动显示（可用于 enumerate 环境下）
\usepackage{packages/sidefig}
\usepackage{float}

%% 修正元素间距过大问题
% \usepackage{setspace}
% \setlength{\parskip}{0.2em}

%% 选择题选项自动排版
\usepackage{hlist}
\usepackage{ifthen}

\newlength{\lengthA} \newlength{\lengthB} \newlength{\lengthC} \newlength{\lengthD}
\newlength{\lengthHalf} \newlength{\lengthQuarter} \newlength{\lengthMax}

\newcommand{\options}[4]{
    \setlength{\lengthHalf}{0.48\linewidth} \setlength{\lengthQuarter}{0.24\linewidth}
    \settowidth{\lengthA}{A.#1} \settowidth{\lengthB}{B.#2} \settowidth{\lengthC}{C.#3} \settowidth{\lengthD}{D.#4}

    \ifthenelse{\lengthtest{\lengthA > \lengthB}} {
        \setlength{\lengthMax}{\lengthA}
    }{
        \setlength{\lengthMax}{\lengthB}
    }
    \ifthenelse{\lengthtest{\lengthMax < \lengthC}} {
        \setlength{\lengthMax}{\lengthC}
    }{}
    \ifthenelse{\lengthtest{\lengthMax < \lengthD}} {
        \setlength{\lengthMax}{\lengthD}
    }{}
    \ifthenelse{\lengthtest{\lengthMax > \lengthHalf}} {
        \begin{hlist}[\parskip=0pt,pre skip=0pt,post skip=0pt,item skip=0pt,item offset={1.15em}, label=\Alpha {hlisti}.,pre label={}]1
            \hitem #1
            \hitem #2
            \hitem #3
            \hitem #4
        \end{hlist}
    }{
        \ifthenelse{\lengthtest{\lengthMax > \lengthQuarter}} {
            \begin{hlist}[\parskip=0pt,pre skip=0pt,post skip=0pt,item skip=0pt,item offset={1.15em}, label=\Alpha {hlisti}.,pre label={}]2
                \hitem #1
                \hitem #2
                \hitem #3
                \hitem #4
            \end{hlist}
        }{
            \begin{hlist}[\parskip=0pt,pre skip=0pt,post skip=0pt,item skip=0pt,item offset={1.15em}, label=\Alpha {hlisti}.,pre label={}]4
                \hitem #1
                \hitem #2
                \hitem #3
                \hitem #4
            \end{hlist}
        }
    }
}


% ----- 页码、页眉与页脚 -----

\usepackage{lastpage} % 页码
\usepackage{fancyhdr} % 设置页眉页脚

\fancypagestyle{plain}{\pagestyle{fancy}}
\pagestyle{fancy}
\fancyhf{}
\fancyfoot[CE,CO]{\small{
    数学试卷~第~\thepage~页（共 \pageref{LastPage} 页）
}}
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\renewcommand{\headrulewidth}{0mm} % 页眉线宽，设置为 0 时不显示页眉线


% ----- TiKZ 绘图信息配置 -----

\usepackage{tikz}
\usepackage{tkz-euclide}
\usetikzlibrary{shapes.geometric}


% ----- 国标数学字体宏包 -----

\xeCJKsetup{CJKmath}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{times}
\usepackage{newtxtext, newtxmath}

%% 调整数学符号间距
\thinmuskip=1.3mu
\medmuskip=1.65mu
\thickmuskip=1.85mu

%% 国标数学命令定义
\newcommand{\abs}[1]{\ensuremath{\left\lvert#1\right\rvert}}
\renewcommand*{\parallel}{\varparallel}
\renewcommand*{\le}{\leqslant}
\renewcommand*{\leq}{\leqslant}
\renewcommand*{\ge}{\geqslant}
\renewcommand*{\geq}{\geqslant}

%% 根指数字号增大
\let\sqrto\sqrt
\renewcommand\sqrt[2][\relax]{%
\ifx\relax#1\relax\sqrto{#2}\else{\sqrto[\leftroot{0}\uproot{2}\scriptstyle #1]{#2}}\fi}

%% 国标数学符号绘制
\newcommand*\parallelogram{
    \mathord{
        \tikz[baseline,line width=0.1ex,line join=round]
        \draw (0,.05ex) -- (.7em,.05ex) -- (.9em,1.4ex) -- (.2em,1.4ex) -- cycle; }}

\renewcommand*\triangle{
    \mathbin{
        \tikz[baseline,line width=0.12ex,line join=round]
        \draw(0,.05ex) -- (.7em,.05ex) -- (.35em,1.55ex) -- cycle; }}

\renewcommand*\angle{
    \mathbin{
        \tikz[baseline,line width=0.12ex,line cap=round]
        \draw (0,.08ex) -- (.72em,.08ex)
        (0, .08ex) -- (.68em,1.4ex); }}

\newcommand*\parallelequal{
    \mathrel{
        \tikz[baseline,line width=0.1ex,line cap=round]
        \draw (0,0) -- (.7em,0)
        (0,.45ex) -- (.7em,.45ex)
        (.25em,.55ex) -- (.35em,1.6ex)
        (.45em,.55ex) -- (.55em,1.6ex); }}

\renewcommand*\perp{
    \mathrel{
        \tikz[baseline,line width=0.12ex,line cap=round]
        \draw (0,0) -- (.8em,0)
        (.4em, 0) -- (.4em,1.5ex); }}

\renewcommand*\backsim{
    \mathrel{
        \tikz[baseline,line width=0.11ex,line cap=round]
        \draw (-.25em,1.15ex) .. controls (-.55em,1.15ex) and (-.51em,.23ex) .. (-.275em,.23ex) .. controls (0,.23ex) and (0,1.15ex) .. (.275em,1.15ex) .. controls (.51em,1.15ex) and (.55em,.23ex) .. (.25em,.23ex); }}

\renewcommand*\cong{
    \mathrel{
        \tikz[baseline,line width=0.11ex,line join=round]
        \draw (-.2em,1.35ex) .. controls (-.46em,1.6ex) and (-.54em,.65ex) .. (-.25em,.65ex) .. controls (-.06em,.65ex) and (.06em,1.35ex) .. (.25em,1.35ex) .. controls (.54em,1.35ex) and (.46em,.4ex) .. (.2em,.65ex) (-.46em,.4ex) -- (.46em,.4ex) (-.46em,0ex) -- (.46em,0ex); }}

\newcommand*\Odot[1][1.1]{
    \mathbin{
        \tikz[baseline,scale=#1]{
            \draw(0,0.32em) circle(0.35em);
            \fill(0,0.32em) circle(0.7pt);
        }
    }}

 \renewcommand*\odot{
    \mathchoice{\Odot}{\Odot}{\Odot[0.7]}{\Odot[0.7]}
 }


% ----- 全局符号替换 -----

\usepackage{newunicodechar}

%% 禁用空心句号
\newunicodechar{。}{．}


% ----- 图表及题号引用 -----

\usepackage{caption}
\captionsetup[figure]{name={Fig.},labelsep=space} 
\captionsetup{font=small}
\setlength{\abovecaptionskip}{0.05ex}

\usepackage{cleveref}
\crefname{enumi}{}{}
\crefdefaultlabelformat{\Kai {（第~#1~题图）}}
\lineskiplimit=12pt
\lineskip=6pt
\captionsetup[figure]{skip=6pt}


% ----- 试卷总标题 -----

\newcommand{\headLine}[4]{
    \vspace*{-4em}
    \begin{center}
        \zihao{3} #1#2 \\
        \vspace*{0.25em}
        \makebox[4em][s]{\zihao{-2}{\XBSong #3}} \\
        \zihao{4} #4
        \vspace*{0.75em}
    \end{center}
}

\newcommand{\headLineSecret}[4]{
    \vspace*{-5em}
    \begin{flushleft}
        {\Hei 绝密$\bigstar$启用前 }    
    \end{flushleft}
    \vspace{-1em}
    \begin{center}
        \zihao{3} #1#2 \\
        \vspace*{0.25em}
        \makebox[4em][s]{\zihao{-2}{\XBSong #3}} \\
        \zihao{4} #4
        \vspace*{0.75em}
    \end{center}
}


% ----- 题目括号、填空 -----

\usepackage{ulem}

\newif\ifshowAnswer
\newcommand{\showAnswer}[1]{\ifthenelse{\isodd{#1}}{\showAnswertrue}{}}

\newcommand{\annotation}{\Kai}
\newcommand{\hint}[1]{{\Kai (#1)}}
\newcommand{\score}[1]{{\Kai (#1分)}}
\newcommand{\scores}[1]{{\Hei （本小题满分#1分）}}

\newcommand{\choice}[1]{
    \ifshowAnswer
        { \nolinebreak\noindent\hfill\mbox{\upshape(\makebox[1cm][c]{\textcolor{red}{#1}}) }}
    \else
        { \nolinebreak\noindent\hfill\mbox{\upshape(\makebox[1.2cm][r])} }
    \fi
    \par % 防止 choice 与 options 不双换行时影响括号右对齐
}
\newcommand{\blank}[2][1.25]{
    \ifshowAnswer
        \uline{\makebox[#1cm][c]{\textcolor{red}{#2}}}
    \else
        \uline{\makebox[#1cm][c]{}}
    \fi
}


% ----- 题目章节文本与描述 -----

\newcommand{\Scores}[2]{本题包括#1小题，每小题#2分，共 \the\numexpr #1 * #2 \relax 分}
\newcommand{\ScoresText}[3]{本题包括#1小题，#3，共#2分}

\newcommand{\Choices}[2]{\Hei {选择题：本题共#1小题，每小题#2分，共 \the\numexpr #1 * #2 \relax 分。在每小题给出的四个选项中，只有一项是符合题目要求的。}}
\newcommand{\Completions}[2]{\Hei {填空题：本题共#1小题，每小题#2分，共 \the\numexpr #1 * #2 \relax 分。}}
\newcommand{\Explanations}[2]{\Hei {解答题：本题共#1小题，共#2分，解答应写出文字说明、证明过程或演算步骤。}}
