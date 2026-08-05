USE HRAnalytics;
with RiskScoreAnalysis as
(
select employeenumber,
department,
attrition,
(
case 
	when overtime = 1 then 2
	else 0
end

+
case 
	when jobsatisfaction =1 then 2
	else 0
end
+
case 
	when Environmentsatisfaction =1 then 2
	else 0
end
+
case 
	when worklifebalance =1 then 2
	else 0
end
+
case 
	when yearsatcompany <2 then 1
	else 0
end
) as risk_score
from EmployeeAttrition

),

RiskCategoryAnalysis as

(
select employeenumber,
	department,
	case 
		when risk_score >=6 then 'High Risk'
		when risk_score between 3 and 5 then 'Medium Risk'
	else 'LowRisk'
	end as RiskCategory
	from RiskScoreAnalysis
)


select 
count(*) as No_Of_employees,
RiskCategory

from RiskCategoryAnalysis

group by RiskCategory
order by No_Of_employees desc;



