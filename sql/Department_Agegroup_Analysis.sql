
use HRAnalytics;
--Department Wise Attrition
select department,count(*) as Employee,
sum(cast(attrition as int)) as Attrition,
 cast(round(sum(cast(Attrition as int)*100.0)/count(*),2) as decimal(5,2)) as  Attrition_Percentage

from employeeAttrition 
group by department
order by  Attrition_Percentage
 desc

--which age group leaves Most
select agegroup as AGE_Group ,sum(cast(attrition as int)) as Attrition, 
cast(
		round(
			sum(cast(Attrition as int)*100.0)/count(*),
			2 
	 )as decimal(5,2)
) as  Attrition_Percentage
from EmployeeAttrition

group by agegroup
order by Attrition_Percentage desc;


