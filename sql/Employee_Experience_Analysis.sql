USE HRAnalytics;

--Average Years at Company--
SELECT avg(yearsatcompany)
FROM EmployeeAttrition;

--Promotion Analysis
SELECT yearssincelastpromotion
	,count(*) AS No_Of_Employee
FROM EmployeeAttrition
GROUP BY yearssincelastpromotion
ORDER BY yearssincelastpromotion DESC;

--Training Analysis--
SELECT TrainingTimesLastYear
	,count(*) AS No_Of_Employee
FROM EmployeeAttrition
GROUP BY TrainingTimesLastYear
ORDER BY TrainingTimesLastYear DESC;

--Work-Life Balance--
SELECT CASE 
		WHEN WorkLifeBalance = 1
			THEN 'Bad'
		WHEN WorkLifeBalance = 2
			THEN 'Good'
		WHEN WorkLifeBalance = 3
			THEN 'Better'
		ELSE 'Best'
		END AS WorkLifeBalance
	,count(*) AS No_Of_Employee
	,cast(round(sum(cast(Attrition AS INT) * 100.0) / count(*), 2) AS DECIMAL(5, 2)) AS Attrition_Percentage
FROM EmployeeAttrition
GROUP BY WorkLifeBalance
ORDER BY Attrition_Percentage DESC;

--Environment Satisfaction--
SELECT CASE 
		WHEN EnvironmentSatisfaction = 1
			THEN 'Low'
		WHEN EnvironmentSatisfaction = 2
			THEN 'Medium'
		WHEN EnvironmentSatisfaction = 3
			THEN 'High'
		ELSE 'Very High'
		END AS WorkLifeBalance
	,count(*) AS No_Of_Employee
	,cast(round(sum(cast(Attrition AS INT) * 100.0) / count(*), 2) AS DECIMAL(5, 2)) AS Attrition_Percentage
FROM EmployeeAttrition
GROUP BY EnvironmentSatisfaction
ORDER BY Attrition_Percentage DESC;

--Job Satisfaction--
SELECT CASE 
		WHEN EnvironmentSatisfaction = 1
			THEN 'Low'
		WHEN EnvironmentSatisfaction = 2
			THEN 'Medium'
		WHEN EnvironmentSatisfaction = 3
			THEN 'High'
		ELSE 'Very High'
		END AS WorkLifeBalance
	,count(*) AS No_Of_Employee
	,cast(round(sum(cast(Attrition AS INT) * 100.0) / count(*), 2) AS DECIMAL(5, 2)) AS Attrition_Percentage
FROM EmployeeAttrition
GROUP BY EnvironmentSatisfaction
ORDER BY Attrition_Percentage DESC;

--Tenture analysis--
SELECT TenureBand
	,count(*) AS No_Of_Employee
	,cast(round(sum(cast(Attrition AS INT) * 100.0) / count(*), 2) AS DECIMAL(5, 2)) AS Attrition_Percentage
FROM EmployeeAttrition
GROUP BY TenureBand
ORDER BY Attrition_Percentage DESC;