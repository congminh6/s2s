{smcl}
{hline}
help for {cmd:s2s}
{right:Minh Cong Nguyen}
{right:Hai-Anh Hoang Dang}
{right:Ksenia Abanokova}
{hline}

{title:{cmd:s2s} - survey to survey imputation tool}

{p 8 16 2}
{opt s2s} {depvar} {indepvars} {ifin} [{it:{help weight##weight:weight}}]
{cmd:,} by{cmd:(}{it:varname numeric}{cmd:)} from{cmd:(}{it:numlist max=1}{cmd:)} 
to{cmd:(}{it:numlist max=1}{cmd:)} pline{cmd:(}{it:varname numeric}{cmd:)} method{cmd:(}{it:string}{cmd:)} cluster{cmd:(}{it:varname numeric}{cmd:)} [{it:options}]

{title:Description}

{p 4 4 2} Obtaining consistent estimates on poverty over time as well as monitoring poverty trends 
on a timely basis is essential for poverty reduction. However, these objectives are not readily 
achieved in practice when household consumption data are neither frequently collected, nor constructed 
using consistent and transparent criteria. The challenge can be broadly regarded as one involving 
missing data: consumption (or income) data are available in one period but in the next period(s) are 
either not available, or are not comparable. Dang, Lanjouw, and Serajuddin (2014) propose a framework 
that offers poverty imputation in these settings; {cmd:s2s} implements their poverty imputation procedures.
{p_end}

{p 4 4 2} This program is designed for datasets with two or more cross sectional survey round, where 
consumption data in the survey round of interest are missing but the control variables are non-missing. 
{p_end}

{marker options}{...}
{title:Options}

{dlgtab:Required}

{phang}
{opt by(varname)} specifies the variable that indicates the survey year (or round).

{phang}
{opt from(#)} specifies the survey year (or round) that has consumption data and 
that provides the underlying regression for imputation. The number for this base 
survey year takes one of the values specified in the variable used in the {opt by(varname)} 
option. For example, if the year variable has two values 2008 and 2010, either of 
which can be specified as a number to be used.

{phang}
{opt to(#)} specifies the survey year (or round) that has missing consumption data and needs 
to be imputed into. The number for this survey year takes one of the values specified in the 
variable used in the {opt by(varname)} option. For example, if the year variable has two values 2008 
and 2010, either of which can be specified as a number to be used.

{phang}
{opt method(string)} specifies the imputation method. Two methods are allowed.

{pmore} 
{cmd:normal}: using the linear regression (OLS) model with the distribution of the error terms assumed to be normal.

{pmore} 
{cmd:empirical}: using the linear regression (OLS) model with the empirical distribution of the error terms.

{phang}
{opt pline(varname)} specifies the variable that indicates the poverty line.
	
{phang}
{opt cluster(varname)} specifies the cluster variable or the primary sampling unit. 

{dlgtab:Optional}

{phang}
{opt wt:stats(varname)} specifies the weight variable for the summary statistics. 
If left blank, unweighted estimates are provided. Note that weights should generally 
be used for the summary statistics unless the data are self-weighted, but unweighted 
estimates are an optional feature.  

{phang}
{opt alpha(integer)} specifies the poverty gap of power alpha as defined in the Foster–Greer–Thorbecke (FGT) measure. The defaule alpha is 1.

{phang}
{opt strata(varname)} specifies the strata variable.

{phang}
{opt pline2(varname)} specifies the variable that indicates the extreme poverty line. Often, the extreme poverty line is smaller than the normal poverty line.

{phang}
{opt vline(varname)} specifies the variable that indicates the vulnerability line. The vulnerability line is larger than the normal poverty line.

{phang}
{opt lny} specifies the left-hand side variable is expressed in logarithmic terms while the poverty line variables remain in level terms.
 
{phang}
{opt rep(#)} specifies the number of simulations. We recommend using 1,000 simulations or more for 
robust estimation of standard errors. If left blank, the default number of replication in Stata is 50.

{phang}
{opt brep(#)} specifies the number of bootstraps for standard errors. We recommend using 100 bootstraps or more for 
robust estimation of standard errors. If left blank, the default number of bootstraps in Stata is 10.

{phang}
{opt seed(#)} specifies the random seed number that can be used for replication of results. The default seed is 1234567.

{phang}
{opt bseed(#)} specifies the random seed number that can be used for bootstraps of results. The default seed is 7654321.
 
{phang}
{opt sav:ing(string)} specifies the filename and filepath to save the imputed data.

{pmore} 
{cmd:replace}: to overwrite the existing imputed data 

{title:Saved Results}

{cmd:s2s} returns results in {hi:e()} format. 
By typing {helpb ereturn list}, the following results are reported:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(cmdline)}}the code line used in the session {p_end}

{synopt:{cmd:e(pov_imp)}}poverty rates based on imputed data {p_end}
{synopt:{cmd:e(pov_var)}}variance of poverty rates based on imputed data {p_end}
   
{synopt:{cmd:e(fgt1_imp)}}poverty gap of the defined alpha based on imputed data {p_end}
{synopt:{cmd:e(fgt1_var)}}variance of poverty gap of the defined alpha based on imputed data {p_end}

{synopt:{cmd:e(pfgt1_imp)}}poverty gap of the defined alpha among the poor based on imputed data {p_end}
{synopt:{cmd:e(pfgt1_var)}}variance of poverty gap of the defined alpha among the poor based on imputed data {p_end}

{synopt:{cmd:e(exp_imp)}}extreme poverty rates based on imputed data {p_end}
{synopt:{cmd:e(exp_var)}}variance of extreme poverty rates based on imputed data {p_end}

{synopt:{cmd:e(np_imp)}}near poverty (vulnerability) rates based on imputed data {p_end}
{synopt:{cmd:e(np_var)}}variance of near poverty (vulnerability) rates based on imputed data {p_end}

{synopt:{cmd:e(mean_imp)}}mean of dependent variable (welfare/income/consumption) based on imputed data {p_end}
{synopt:{cmd:e(mean_var)}}variance of dependent variable based on imputed data {p_end}

{synopt:{cmd:e(p#_imp)}}percentile mean of dependent variable (welfare/income/consumption) based on imputed data. Available percetiles (p#) are 5, 10, 25, 50, 75, 90, 95 {p_end}
{synopt:{cmd:e(p#_var)}}variance of percentile mean of dependent variable based on imputed data {p_end}

{synopt:{cmd:e(N1)}}estimation sample in the first period, (from) {p_end}
{synopt:{cmd:e(N2)}}estimation sample in the second period, (to) {p_end}

{title:Examples}

{pstd}1) [to be updated] Assume that consumption data are available in the 2008 survey round but are either missing 
or not comparably constructed in the 2010 survey round. We can impute poverty rate from survey year 
2008 into survey year 2010 using the normal linear regression model with the distribution of the 
error terms assumed to be normal, where the poverty line in 2008 is 40.
{p_end}

{pstd}* Table 1 "Dang, H. A. H., Kilic, T., Abanokova, K., & Carletto, C. (2024). Imputing Poverty Indicators without Consumption Data./ PRWP 10867{p_end}

{phang2}{cmd:.use "C:\{path}\Tanzania_dataset.dta", clear}{p_end}

{phang2}{cmd:.svyset psu [w= hhszwt], strata(strata) singleunit(certainty)}{p_end}

{phang2}{cmd:.clonevar dep = lnpcex}{p_end}

{phang2}{cmd:.replace dep = . if round==6}{p_end}

{phang2}{cmd:.gen vline = povline*1.25}{p_end}

{pstd}* Model 1 {p_end}
{phang2}{cmd:.s2s dep hhsize age female pri lws ups age0to14sh age15to24sh age60tosh wageemp selfemp area_1 area_2 area_4, by(round) from(5) to(6) pline(povline) cluster(psu) seed(7654321) strata(strata) wt(hhszwt) method(normal) a(1) pline2(epovline) vline(vline) rep(100) b(100) lny}{p_end}
           
{pstd}* Model 9 {p_end}
{phang2}{cmd:.s2s dep hhsize age female pri lws ups age0to14sh age15to24sh age60tosh wageemp selfemp area_1 area_2 area_4 lnpcewg, by(round) from(5) to(6) pline(povline) cluster(psu) seed(7654321) strata(strata) wt(hhszwt) method(normal) a(1) pline2(epovline) vline(vline) rep(100) b(100) lny}{p_end}
		   
{title:References}

{p 4 4 2} Dang, Hai-Anh H., Peter F. Lanjouw, and Umar Serajuddin. (2014). Updating Poverty Estimates 
at Frequent Intervals in the Absence of Consumption Data: Methods and Illustration with Reference to a 
Middle-Income Country, World Bank Policy Research Paper # 7043. Washington DC: The World Bank.
{p_end}

{title:Authors}
	{p 4 4 2}Minh Cong Nguyen, Senior Economist, World Bank, USA, mnguyen3@worldbank.org{p_end}
	{p 4 4 2}Hai-Anh Hoang Dang, Senior Economist, World Bank, USA, hdang@worldbank.org{p_end}
	{p 4 4 2}Ksenia Abanokova, Economist, World Bank, USA, kabanokova@worldbank.org{p_end}

{title:Thanks for citing s2s as follows}

{p 4 4 2}{cmd: s2s} is a user-written program that is freely distributed to the research community. {p_end}

{p 4 4 2}Please use the following citation:{p_end}
{p 4 4 2}Authors.... (2014). {cmd:s2s}: Stata module to 
impute poverty in the absence of consumption data�. World Bank, Development Research Group, Poverty and Inequality Unit and Global Poverty Practice.
{p_end}

{title:Acknowledgements}

{p 4 4 2} In this package, we include user-written package "epctile" from Stas Kolenikov. The epctile is used for the means at different percentiles with survey design setting. The "epctile" package can also be downloaded from https://staskolenikov.net/stata. In Stata type "findit epctile" and click to install the package. {p_end}
	
{p 4 4 2}We would like to thank the UK Department of International Development for funding assistance through its Strategic Research Program. 
	All errors and ommissions are exclusively our responsibility.{p_end}
