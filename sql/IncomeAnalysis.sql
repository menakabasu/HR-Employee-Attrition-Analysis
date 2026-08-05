--Monthly Income Attrition
USE HRAnalytics;

/*Business Question:

Does monthly income affect employee attrition?
Which income ranges have the highest attrition?
Should the company review its compensation strategy?*/
--Analysis 1: Average Monthly Income of Employees Who Left vs Stayed--
SELECT 
	case
	when attrition = 1 then 'Left'
	else 'Stayed'
	end as attrition,
	 Min(MonthlyIncome) as Minimum_Salary,
	 Max(MonthlyIncome) as Maximun_Salary,
	avg(MonthlyIncome) AS Avg_Salary
	,attrition
	,count(*) AS No_Employee
FROM EmployeeAttrition
GROUP BY attrition;

--Analysis 2: Attrition by Income Band--
SELECT incomecategory
	,count(*) AS Total_Employee
	,sum(cast(attrition AS INT)) AS Left_the_Company
	,cast(round(sum(cast(Attrition AS INT) * 100.0) / count(*), 2) AS DECIMAL(5, 2)) AS Attrition_Percentage
FROM EmployeeAttrition
GROUP BY incomecategory
ORDER BY Attrition_Percentage DESC;

--Analysis 3: Monthly Income by Department--
SELECT department
	,sum(cast(attrition AS INT)) AS left_the_company
	,avg(monthlyincome) AS AvgIncome
	,cast(round(sum(cast(Attrition AS INT) * 100.0) / count(*), 2) AS DECIMAL(5, 2)) AS Attrition_Percentage
FROM EmployeeAttrition
GROUP BY department
ORDER BY Attrition_Percentage DESC;

--Analysis 4: Monthly Income by Job Role--
SELECT JobRole,
	count(*) as No_Of_Employee
	,sum(cast(attrition AS INT)) AS left_the_company
	,avg(monthlyincome) AS AvgIncome
	,cast(round(sum(cast(Attrition AS INT) * 100.0) / count(*), 2) AS DECIMAL(5, 2)) AS Attrition_Percentage
FROM EmployeeAttrition
GROUP BY JobRole
ORDER BY Attrition_Percentage DESC

/*Business Insights You Might Find

Employees earning below £5,000 have the highest attrition rate.
Higher-income employees are more likely to remain with the company.
Sales and Human Resources have lower average salaries and higher attrition.
Employees with both low income and frequent overtime show particularly high attrition.

These findings can guide decisions around compensation, career progression, and retention strategies.*/