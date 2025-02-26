capture program drop drawregs
program define drawregs, rclass
version 18
	
	
	**输入参数与校验报错
	syntax varname [if] [in], startnum(integer) endnum(integer) [xtitle(string) CV(varlist numeric)]
	
	
	cap confirm variable `varlist'
	if _rc {
        di as error "DV必须是数据集中存在的变量，且只能有一个"
        error 198
    }
	cap confirm integer number `startnum'
    if _rc | (`startnum' <= 0) {
        di as error "startnum必须是正整数"
        error 198
    }
	cap confirm integer number `endnum'
    if _rc | (`endnum' <= 0) {
        di as error "endnum必须是正整数"
        error 198
    }
	if `endnum' <= `startnum' {
        di as error "endnum必须大于startnum"
        error 198
    }
	
	
// 	di "Dependent Variable: `varlist' "
//     di "Start Number: `startnum'"
//     di "End Number: `endnum'"
//     di "X Title: `xtitle'"
//     di "Control Variables (CV): `cv' "
	
	
	quietly {
		
		
		**回归运行与解析
		gen N = _n
		local DV = "`varlist'"
		mat `DV' = [1,1,1,1]
		forvalues i = `startnum'(1)`endnum'{
			
			reghdfe `varlist' dummy`i' `CV', vce(r)
			mat `DV'_`i' = r(table)
			mat list `DV'_`i'
			local b_`i' = `DV'_`i'[1,1]
			local ll_`i' = `DV'_`i'[5,1]
			local ul_`i' = `DV'_`i'[6,1]
			local p_`i' = `DV'_`i'[4,1]
			mat `DV'_`i' = [ `b_`i'' , `ll_`i'' , `ul_`i'' , `p_`i'' ]
			mat rownames `DV'_`i' = `i'
			mat `DV' = `DV' \ `DV'_`i'
			
			if `i' == `startnum'{
				mat `DV' = `DV'_`startnum'
			}
			
		}
		
		mat colnames `DV' = `DV'_系数估计值 `DV'_置信区间下限 `DV'_置信区间上限 `DV'_p值
		dis "回归结果储存矩阵：" 
		mat list `DV'
		
		svmat `DV', names(col) 
// 		drop if missing(`DV'_系数估计值)
		replace N = N + (`startnum' - 1)
		
// 		save ForGraph.dta, replace
		
		
		
		**画图
// 		use ForGraph.dta, clear
// 		graph drop _all
		
		local xlabel_options ""
		forvalues i = `startnum'(1)`endnum'{
			local label: var label dummy`i'
			local xlabel_options `"`xlabel_options' `i' "`label'" "'
		}
		
		graph tw ///
		(rcap `DV'_置信区间下限 `DV'_置信区间上限 N, lc(navy) ) ///
		(scatter  `DV'_系数估计值 N, mcolor(black)) /// 
		(lfit `DV'_系数估计值 N) ///
		if !missing(`DV'_系数估计值) ///
		, yline(0, lcolor(gs10)) xlabel(`xlabel_options') ylabel(, format(%3.1f)) legend(off) name(`DV') title(`DV', margin(medium)) xtitle(`xtitle') graphregion(color("none"))
		graph save `DV', replace
			
	}

	
	
	**提示
	di "Dependent Variable: `varlist' "
    di "Start Number: `startnum'"
    di "End Number: `endnum'"
    di "X Title: `xtitle'"
    di "Control Variables (CV): `cv' "
	
	
// 	clear
	drop N *_系数估计值 *_置信区间下限 *_置信区间上限 *_p值
	cap erase ForGraph.dta
	
	
end
	