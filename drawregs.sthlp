{smcl}
{* 18 Feb 2025}{...}
{hline}
help for {hi:drawregs}
{hline}


{title:Title}

{p 4 4 2}
{bf:drawregs} —— Create Graphs for the Regressions Containing Dummies with Continuous Economic Features.

{title:Syntax}

{p 4 4 2}
{cmdab:drawregs} Dependent_Variable [if] [in], {cmdab:startnum(} {cmdab:)} {cmdab:endnum(} {cmdab:)} 
[{cmdab:xtitle}{cmd:(}text{cmd:)}]  [{cmdab:CV:}{cmd:(}numeric Control Variables{cmd:)}]

{title:Description}

{p 4 4 2}
{cmd:drawregs} is motivated totally by the author's boringness. She has utilized the code in her graduation thesis and feels a tiny waste if the code just lies there.{break}
You need the version 18 of Stata to run this command.


{title:Options}

{p 4 4 2}{cmd:startnum(}{it:integer}{cmd:)} specifies the start number of the dummies. This is a necessary option.{break}
{cmd:endnum(}{it:integer}{cmd:)} specifies the end number of the dummies. This is a necessary option.{break}
{cmd:xtitle(}{it:string}{cmd:)} specifies the title text of the X axis. This is NOT a necessary option.{break}
{cmdab:CV:}{cmd:(}{it:numeric varlist}{cmd:)} specifies the control variables of your regression. This is NOT a necessary option.{break}{p_end}


{title:Examples}

{p 4 4 2} The author apologizes for being too lazy to write an example. Sorry!{break}
But you can use the dataset, {it:adotest.dta (notice it is not a real dataset but generated by AI randomly)}, to test the command. {p_end}

{title:Author}

{p 4 4 2}
{cmd:Heng Jiang / 姜珩} {break}
School of Public Affairs, Zhejiang University {break}
Contact: Wechat official account @{it:姜瑾AXiS} {break}