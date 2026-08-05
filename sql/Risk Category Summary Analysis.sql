USE HRAnalytics;

--Risk Category Summary Analysis-
/*Business Question:

"How many employees are classified as Low, Medium, and High attrition risk?"*/
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

department,

count(*) as No_Of_employees



from RiskCategoryAnalysis
where RiskCategory ='High Risk'
group by department
order by No_Of_employees desc;
