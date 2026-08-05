/*
Project: HR Employee Attrition Analysis
File: DepartmentAnalysis.sql

Business Questions:
1. Which department has the highest employee attrition?
2. Which age group has the highest attrition rate?

Tools:
SQL Server
*/
use HRAnalytics;
--Department Wise Attrition
SELECT 
    e.Department,
    COUNT(*) AS Employee_Count,
    SUM(CAST(e.Attrition AS INT)) AS Attrition_Count,
    CAST(
        ROUND(
            SUM(CAST(e.Attrition AS INT))*100.0/COUNT(*),
            2
        ) AS DECIMAL(5,2)
    ) AS Attrition_Percentage
FROM EmployeeAttrition e
GROUP BY e.Department
ORDER BY Attrition_Percentage DESC;

--which age group leaves Most
select agegroup ,sum(cast(attrition as int)) as Attrition, 
cast(
		round(
			sum(cast(Attrition as int)*100.0)/count(*),
			2 
	 )as decimal(5,2)) as  Attrition_Percentage
from EmployeeAttrition
group by agegroup
order by Attrition_Percentage desc;


