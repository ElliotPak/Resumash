%% Taken from https://www.sharelatex.com/blog/2012/03/27/how-to-write-a-latex-class-file-and-design-your-own-cv.html

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{elliot-cv}[2018/09/24 Elliots Custom CV Class]

\LoadClass[9pt]{extarticle}

\RequirePackage{titlesec}
\RequirePackage[T1]{fontenc}
\RequirePackage{fontspec}
\RequirePackage{enumitem}
\RequirePackage{lmodern}
\RequirePackage{array}
\RequirePackage{extsizes}
\RequirePackage{anyfontsize}
\RequirePackage[margin=0.75in]{geometry}

\renewcommand{\familydefault}{\sfdefault}
\setsansfont{Overpass}
\pagenumbering{gobble}

\titleformat{\section}
  {\huge\bfseries\raggedright}
  {}{0em}
  {}
[\titlerule]

\newcommand{\datedsection}[2]{%
  \section[#1]{#1 \hfill #2}%
}

\newcommand{\entryposition}[1]{
    \textsc{#1}
}

\newcommand{\entrydate}[1]{
    \textit{#1}
}

\newcommand{\entrytitle}[1]{
    \Large \textbf{#1} \normalsize
}

\newcommand{\entrylocation}[1]{
    \textit{#1}
}

\newcommand{\cventry}[4]{
    \entrytitle{#2} \hfill \entrylocation{#3} \\
    \entryposition{#1} \hfill \entrydate{#4}
}

\newcommand{\project}[2]{
    \entrytitle{#1} \hfill \entrylocation{#2}
}

\newenvironment{entryitems}{
    \begin{itemize}[topsep=0.5em, partopsep=0em, parsep=0em]
}{
    \end{itemize}
}

\newcommand{\name}[1]{
    \centerline{\bfseries\fontsize{25}{30}\selectfont #1}
}

\newcommand{\contactsmall}[4]{
    \begin{center}
    {\Large} #1
    {\large\textperiodcentered} {\Large} #2\\
    \vspace{0.5em}
    #3 {\large\textperiodcentered} #4
    \end{center}
}

\newcommand{\contact}[5]{
    \begin{center}
    {\Large} #1
    {\large\textperiodcentered} {\Large} #2\\
    \vspace{0.5em}
    #3 {\large\textperiodcentered} #4 {\large\textperiodcentered} #5
    \end{center}
}

\newcommand{\contactaddress}[8]{
    \begin{center}
    #1, #2 #3
    {\large\textperiodcentered} {\Large} #4
    {\large\textperiodcentered} {\Large} #5\\
    \vspace{0.5em}
    #6 {\large\textperiodcentered} #7 {\large\textperiodcentered} #8
    \end{center}
}

\newenvironment{skillset3}{
    \renewcommand{\arraystretch}{1.4}
    \begin{tabular}{l r l}}
            {\end{tabular}}

\newcommand{\skillmajor}[2]{
    \multicolumn{2}{l}{\bfseries{\scshape{#1}}} &  \multicolumn{1}{l}{#2} \\
}

\newcommand{\skillminor}[2]{
    & \multicolumn{1}{l}{\scshape#1} & \multicolumn{1}{l}{#2} \\
}

\newcommand{\skillboth}[3]{
    \multicolumn{1}{l}{\bfseries{\scshape{#1}}} & \multicolumn{1}{l}{\scshape#2} & \multicolumn{1}{l}{#3} \\
}

\newcommand{\award}[4]{
    \textsc{#1} \textbf{#2}, #3 \hfill \textit{#4}
}
