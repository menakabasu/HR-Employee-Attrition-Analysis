USE HRAnalytics;

--"Which employees earn significantly above or below the average salary of their department?"--
WITH salaryAnalysis
AS (
	SELECT EmployeeNumber
		,Department
		,MonthlyIncome
		,attrition
		,AVG(MonthlyIncome) OVER (PARTITION BY Department) AS Department_Average
		,MonthlyIncome - AVG(MonthlyIncome) OVER (PARTITION BY Department) AS Salary_Difference
		,CASE 
			WHEN MonthlyIncome > AVG(MonthlyIncome) OVER (PARTITION BY Department)
				THEN 'Above Average'
			WHEN MonthlyIncome < AVG(MonthlyIncome) OVER (PARTITION BY Department)
				THEN 'Below Average'
			ELSE 'Equal to Average'
			END AS Salary_Status
	FROM EmployeeAttrition
	)
SELECT Salary_Status
	,count(*) AS Employee
	,sum(cast(attrition AS INT)) AS Attrition
	,cast(round(sum(cast(Attrition AS INT) * 100.0) / count(*), 2) AS DECIMAL(5, 2)) AS Attrition_Percentage
FROM salaryAnalysis
GROUP BY Salary_Status