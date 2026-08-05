USE HRAnalytics;

--Salary Band Impact on Employee Attrition--
WITH salaryranking
AS (
	SELECT employeenumber
		,attrition
		,department
		,IncomeCategory
		,DENSE_RANK() OVER (
			PARTITION BY department ORDER BY IncomeCategory DESC
			) AS SALARYBANK
	FROM employeeattrition
	)
SELECT department
	,IncomeCategory
	,count(*) AS NO_OF_EMPLOYEE
	,sum(cast(attrition AS INT)) AS Attrition
	,cast(round(sum(cast(Attrition AS INT) * 100.0) / count(*), 2) AS DECIMAL(5, 2)) AS Attrition_Percentage
FROM salaryranking
GROUP BY department
	,IncomeCategory
HAVING count(*) >= 30
ORDER BY Attrition_Percentage DESC;
	/*Interpretation:

Lower salary employees generally have higher attrition, especially in Sales and HR. Higher salary employees show better retention, particularly in Research & Development.*/