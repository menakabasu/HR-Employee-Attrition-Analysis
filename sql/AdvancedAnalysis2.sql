use HRAnalytics;
USE HRAnalytics;

-- Below-Average Salary Attrition Analysis
WITH salaryAnalysis
AS (
	SELECT employeenumber
		,department
		,attrition
		,monthlyincome
		,avg(monthlyincome) OVER (PARTITION BY department) AS Department_Average
	FROM employeeattrition
	)
SELECT department
	,count(*) AS NO_OF_EMPLOYEE
	,sum(cast(attrition AS INT)) AS Attrition
	,cast(round(sum(cast(Attrition AS INT) * 100.0) / count(*), 2) AS DECIMAL(5, 2)) AS Attrition_Percentage
FROM salaryAnalysis
WHERE MonthlyIncome < Department_Average
GROUP BY department
ORDER BY Attrition_Percentage DESC