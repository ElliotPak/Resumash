%% Taken from https://www.sharelatex.com/blog/2011/03/27/how-to-write-a-latex-class-file-and-design-your-own-cv.html

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{elliot-cv}[2018/09/24 Elliots Custom CV Class]

\LoadClass[8pt]{extarticle}

\RequirePackage{titlesec}
\RequirePackage[T1]{fontenc}
\RequirePackage{enumitem}
\RequirePackage{lmodern}
\RequirePackage{array}
\RequirePackage{extsizes}
\RequirePackage[margin=1in]{geometry}

\titleformat{\section}
  {\Large\scshape\raggedright}
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
    \large \textsc{#1} \normalsize
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
  \centerline{\Huge{#1}}
}

\newcommand{\contact}[8]{
    \begin{center}
    #1, #2 #3
    {\large\textperiodcentered} {\Large} #4
    {\large\textperiodcentered} {\Large} #5\\
    \vspace{0.5em}
    #6 {\large\textperiodcentered} #7 {\large\textperiodcentered} #8
    \end{center}
}

\newcommand{\longcontact}[5]{
    \center{#1 \hfill {\large\textperiodcentered} \hfill #2 \hfill {\large\textperiodcentered} \hfill #3} \\
    \center{ {\Large} #4 \hfill {\Large} #5}
}

\newenvironment{skillset}{
    \renewcommand{\arraystretch}{1.4}
    \begin{flushleft}\begin{tabular}{c c c}}
            {\end{tabular}\end{flushleft}}

\newcommand{\skillmajor}[2]{
    \multicolumn{2}{l}{\textbf{\textsc{#1}}} &  \multicolumn{1}{l}{#2} \\
}

\newcommand{\skillminor}[2]{
    & \multicolumn{1}{l}{\scshape#1} & \multicolumn{1}{l}{#2} \\
}

\newcommand{\skillboth}[3]{
    \multicolumn{1}{l}{\textbf{\textsc{#1}}} & \multicolumn{1}{l}{\scshape#2} & \multicolumn{1}{l}{#3} \\
}

\newcommand{\award}[4]{
    \textsc{#1} \textbf{#2}, #3 \hfill \textit{#4}
}
