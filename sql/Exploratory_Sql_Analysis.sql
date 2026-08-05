USE HRAnalytics;

SELECT TOP (1000) [Age]
	,[Attrition]
	,[BusinessTravel]
	,[DailyRate]
	,[Department]
	,[DistanceFromHome]
	,[Education]
	,[EducationField]
	,[EmployeeCount]
	,[EmployeeNumber]
	,[EnvironmentSatisfaction]
	,[Gender]
	,[HourlyRate]
	,[JobInvolvement]
	,[JobLevel]
	,[JobRole]
	,[JobSatisfaction]
	,[MaritalStatus]
	,[MonthlyIncome]
	,[MonthlyRate]
	,[NumCompaniesWorked]
	,[Over18]
	,[OverTime]
	,[PercentSalaryHike]
	,[PerformanceRating]
	,[RelationshipSatisfaction]
	,[StandardHours]
	,[StockOptionLevel]
	,[TotalWorkingYears]
	,[TrainingTimesLastYear]
	,[WorkLifeBalance]
	,[YearsAtCompany]
	,[YearsInCurrentRole]
	,[YearsSinceLastPromotion]
	,[YearsWithCurrManager]
	,[AgeGroup]
	,[TenureBand]
	,[IncomeCategory]
	,[DistanceCategory]
	,[RiskScore]
	,[RiskCategory]
FROM [HRAnalytics].[dbo].[EmployeeAttrition]

SELECT TOP 10 *
FROM dbo.employeeattrition;

/*Executive Questions
What is the attrition rate?
Which departments lose the most employees?
Which job roles resign the most?
Which age group leaves the company?
Are males or females leaving more?
Does overtime increase attrition?
Does salary affect attrition?
Does work-life balance affect attrition?
Does business travel increase resignations?
Which managers should HR focus on?
Which employees are at high risk?
What is the estimated replacement cost?*/
--Data Quality Checks--
--Duplicate Employees
SELECT employeenumber
	,count(*) AS TOTAL
FROM dbo.employeeattrition
GROUP BY employeenumber
HAVING count(*) > 1;

--Missing Values
SELECT count(*) TotalRows
	,count(age) age
	,count(MonthlyIncome) Income
	,count(jobrole) JobRole
FROM employeeattrition;

--Check unique Values
SELECT DISTINCT jobrole
FROM dbo.employeeattrition;

SELECT DISTINCT Department
FROM dbo.employeeattrition;

--Total Employees
SELECT count(*) AS Total_Employees
FROM employeeattrition;

--Total Attrition
SELECT count(*)
FROM employeeattrition
WHERE Attrition = 1;

SELECT Attrition
	,count(*)
FROM employeeattrition
GROUP BY Attrition

SELECT DISTINCT Attrition
FROM employeeattrition;

--Attrition Rate
SELECT dbo.AttritionRate() AS Attrition_Percentage;
