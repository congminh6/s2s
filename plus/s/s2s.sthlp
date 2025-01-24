{smcl}
{hline}
help for {cmd:s2s}
{right:Hai-Anh H. Dang}
{right:Minh Cong Nguyen}
{right:Ksenia Abanokova}
{hline}

{title:{cmd:s2s} - survey to survey imputation tool}

{p 8 16 2}
{opt s2s} {depvar} {indepvars} {ifin} [{it:{help weight##weight:weight}}]
{cmd:,} by{cmd:(}{it:varname}{cmd:)} from{cmd:(}{it:numlist}{cmd:)} 
to{cmd:(}{it:numlist}{cmd:)} pline{cmd:(}{it:varname}{cmd:)} method{cmd:(}{it:string}{cmd:)} cluster{cmd:(}{it:varname}{cmd:)} [{it:options}]

{title:Description}

{p 4 4 2} Obtaining consistent estimates on poverty over time as well as monitoring poverty trends on a timely basis is essential for poverty reduction. However, these objectives are not readily achieved in practice where household consumption data are infrequently collected or not constructed using consistent and transparent criteria. The challenge can be broadly regarded as one involving missing data: consumption (or income) data are available in one period but are either unavailable or incomparable in the next period(s). {p_end}

{p 4 4 2} Dang, Lanjouw, and Serajuddin (2017) propose a method that imputes headcount poverty in these settings. Dang et al. (2024) employ this method and provide further validation evidence for other poverty indicators in the Foster–Greer–Thorbecke (FGT) family of poverty indicators, several other vulnerability indicators, and mean consumption data. {p_end}

{p 4 4 2}  s2s implements their imputation procedures.{p_end}

{p 4 4 2}  Recent papers that review this method and its applications include Dang, Jolliffe and Carletto (2019) and Dang and Lanjouw (2023).{p_end}

{p 4 4 2}  This program is designed for datasets with at least two cross-sectional surveys, where consumption data are available in the survey that we impute from (the base survey) but are missing in the survey of interest (the target survey(s) that we impute into). The control variables are non-missing in both surveys.{p_end}

{marker options}{...}
{title:Options}

{dlgtab:Required}

{phang}
{opt by(varname)} specifies the variable that indicates the survey year (or round). This variable has a numeric format.

{phang}
{opt from(#)} specifies the survey year (or round) that has consumption data and that provides the underlying regression for imputation. This is the base survey that we impute from. The number for this base survey takes one of the values specified in the variable used in the by(varname) option. For example, if the year variable has two values 2008 and 2010, either of which can be specified as a number to be used.

{phang}
{opt to(#)} specifies the survey year (or round) that has missing consumption data and needs to be imputed into. This is the target survey that we impute into. The number for this survey year takes one of the values specified in the variable used in the by(varname) option. For example, if the year variable has two values 2008 and 2010, either of which can be specified as a number to be used.

{phang}
{opt method(string)} specifies the imputation method. Two methods are allowed.

{pmore} 
{cmd:normal}: using the linear regression (OLS) model with the distributions of the error terms assumed to be normal.

{pmore} 
{cmd:empirical}: using the linear regression (OLS) model with the empirical distributions of the error terms.

{phang}
{opt pline(varname)} specifies the variable that indicates the poverty line. This variable has a numeric format.
	
{phang}
{opt cluster(varname)} specifies the cluster variable or the primary sampling unit. This variable has a numeric format.

{dlgtab:Optional}

{phang}
{opt wt:stats(varname)} specifies the weight variable for the summary statistics.  If left blank, unweighted estimates are provided. Note that weights should generally be used for the summary statistics unless the data are self-weighted, but unweighted estimates are an optional feature. This variable has a numeric format.

{phang}
{opt alpha(integer)} specifies the power of the parameter alpha as defined in the Foster–Greer–Thorbecke (FGT) family of poverty indicators. The default alpha is 1.

{phang}
{opt strata(varname)} specifies the strata variable. This variable has a numeric format.

{phang}
{opt pline2(varname)} specifies the variable that indicates the extreme poverty line. The extreme poverty line should be lower than the (regular) poverty line that is specified in the option pline(). This variable has a numeric format.

{phang}
{opt vline(varname)} specifies the variable that indicates the vulnerability line. The vulnerability line should be larger than the poverty line. This variable has a numeric format.

{phang}
{opt lny} specifies that the left-hand side variable is converted to logarithmic terms. Note that the poverty line variables remain in level terms.
 
{phang}
{opt rep(#)} specifies the number of simulations. We recommend using 1,000 simulations or more for robust estimation of standard errors. If left blank, the default number of replications in Stata is 50.

{phang}
{opt brep(#)} specifies the number of bootstraps for standard errors. We recommend using 400 bootstraps or more for robust estimation of standard errors. If left blank, the default number of bootstraps in Stata is 10.

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
By typing {it:ereturn list}, the following results are reported:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(cmdline)}}the code line used in the session {p_end}

{synopt:{cmd:e(pov_imp)}}headcount poverty rate (alpha= 0) based on imputed data {p_end}
{synopt:{cmd:e(pov_var)}}bootstrap variance of headcount poverty based on imputed data {p_end}
   
{synopt:{cmd:e(fgt1_imp)}}FGT poverty indicator with the specified alpha based on imputed data {p_end}
{synopt:{cmd:e(fgt1_var)}}bootstrap variance of FGT poverty indicator with the specified alpha based on imputed data {p_end}

{synopt:{cmd:e(pfgt1_imp)}}FGT poverty indicator with the specified alpha among the poor based on imputed data {p_end}
{synopt:{cmd:e(pfgt1_var)}}bootstrap variance of FGT poverty indicator with the specified alpha among the poor based on imputed data {p_end}

{synopt:{cmd:e(exp_imp)}}extreme poverty rate based on imputed data {p_end}
{synopt:{cmd:e(exp_var)}}bootstrap variance of extreme poverty rate based on imputed data {p_end}

{synopt:{cmd:e(np_imp)}}near poverty (vulnerability) rate based on imputed data {p_end}
{synopt:{cmd:e(np_var)}}bootstrap variance of near poverty (vulnerability) rate based on imputed data {p_end}

{synopt:{cmd:e(mean_imp)}}mean of dependent variable based on imputed data {p_end}
{synopt:{cmd:e(mean_var)}}bootstrap variance of dependent variable based on imputed data {p_end}

{synopt:{cmd:e(p#_imp)}}percentile mean of dependent variable based on imputed data. Available percetiles (p#) are 5, 10, 25, 50, 75, 90, 95 {p_end}
{synopt:{cmd:e(p#_var)}}bootstrap variance of percentile mean of dependent variable based on imputed data {p_end}

{synopt:{cmd:e(N1)}}estimation sample in the base survey {p_end}
{synopt:{cmd:e(N2)}}estimation sample in the target survey {p_end}

{title:Examples}

{pstd}1) [to be updated on description] Assume that consumption data are available in the 2008 survey round but are either missing 
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

{p 4 4 2} Dang, H.-A. H. and Lanjouw, P. F. (2023). "Regression-based Imputation for Poverty Measurement in Data Scarce Settings". In Jacques Silber. (Eds.). Handbook of Research on Measuring Poverty and Deprivation. Edward Elgar Press.{p_end}

{p 4 4 2} Dang, H.-A. H., Jolliffe, D., & Carletto, C. (2019). Data gaps, data incomparability, and data imputation: A review of poverty measurement methods for data‐scarce environments. Journal of Economic Surveys, 33(3), 757-797. {p_end}

{p 4 4 2} Dang, H.-A. H., Lanjouw, P. F., & Serajuddin, U. (2017). Updating poverty estimates in the absence of regular and comparable consumption data: methods and illustration with reference to a middle-income country. Oxford Economic Papers, 69(4), 939-962.{p_end}

{p 4 4 2} Dang, H.-A. H., Kilic, T., Abanokova, K., & Carletto, C. (2024). Imputing Poverty Indicators without Consumption Data. World Bank Policy Research Working Paper no. 10867.{p_end}

{title:Authors}
	{p 4 4 2}Hai-Anh H. Dang, Senior Economist, World Bank, USA, hdang@worldbank.org{p_end}
	{p 4 4 2}Minh Cong Nguyen, Senior Economist, World Bank, USA, mnguyen3@worldbank.org{p_end}
	{p 4 4 2}Ksenia Abanokova, Economist, World Bank, USA, kabanokova@worldbank.org{p_end}


{title:Suggested citation}

{p 4 4 2} Dang, H. A. H., Nguyen, M. C., and Abanokova, K. (2025). s2s: Stata module to impute poverty in the absence of consumption data. World Bank, Development Data Group and Global Poverty Practice. Available from (insert Repec link) {p_end}

{title:Acknowledgements}

{p 4 4 2}We use the user-written program "epctile" from https://staskolenikov.net/stata that provides estimation and inference for percentiles.{p_end}

{p 4 4 2}We would like to thank various colleagues at and outside the World Bank for comments on previous versions of the program. This is a work in progress. A previous version named "povimp" offers alternative modelling choices, including the probit and logit models, and additional test statistics for imputed headcount poverty.{p_end}

{p 4 4 2}We would like to thank the United States Agency for International Development (USAID) and UK Foreign Commonwealth and Development Office (FCDO) for funding assistance. {p_end}

{p 4 4 2}All errors and omissions are exclusively our responsibility.{p_end}

