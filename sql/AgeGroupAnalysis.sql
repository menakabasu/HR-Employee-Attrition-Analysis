

USE HRAnalytics;
--which age group leaves Most
SELECT agegroup AS AGE_Group
	,sum(cast(attrition AS INT)) AS Attrition
	,cast(round(sum(cast(Attrition AS INT) * 100.0) / count(*), 2) AS DECIMAL(5, 2)) AS Attrition_Percentage
FROM EmployeeAttrition
GROUP BY agegroup
ORDER BY Attrition_Percentage DESC;
