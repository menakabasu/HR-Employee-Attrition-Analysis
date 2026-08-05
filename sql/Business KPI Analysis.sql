USE HRAnalytics;

/*Level 2 – Business KPI Analysis

These answer key HR questions.*/
--Over All Attrition Rate
SELECT cast(round(sum(cast(Attrition AS INT) * 100.0) / count(*), 2) AS DECIMAL(5, 2)) AS Attrition_Percentage
FROM employeeattrition;

--Attrition by Department--
SELECT department
	,sum(cast(attrition AS INT)) AS left_the_company
	,cast(round(sum(cast(Attrition AS INT) * 100.0) / count(*), 2) AS DECIMAL(5, 2)) AS Attrition_Percentage
FROM EmployeeAttrition
GROUP BY department
ORDER BY Attrition_Percentage DESC;

--Attrition by Gender--
SELECT gender
	,sum(cast(attrition AS INT)) AS left_the_company
	,cast(round(sum(cast(Attrition AS INT) * 100.0) / count(*), 2) AS DECIMAL(5, 2)) AS Attrition_Percentage
FROM EmployeeAttrition
GROUP BY gender
ORDER BY Attrition_Percentage DESC;

--Attrition by Job Role
SELECT JobRole
	,COUNT(*) AS No_Of_Employee
	,sum(cast(attrition AS INT)) AS left_the_company
	,cast(round(sum(cast(Attrition AS INT) * 100.0) / count(*), 2) AS DECIMAL(5, 2)) AS Attrition_Percentage
FROM EmployeeAttrition
GROUP BY JobRole
ORDER BY Attrition_Percentage DESC

--Attrition by Education--
SELECT EducationField
	,COUNT(*) AS No_Of_Employee
	,sum(cast(attrition AS INT)) AS left_the_company
	,cast(round(sum(cast(Attrition AS INT) * 100.0) / count(*), 2) AS DECIMAL(5, 2)) AS Attrition_Percentage
FROM EmployeeAttrition
GROUP BY EducationField
ORDER BY Attrition_Percentage DESC

--Attrition by Age Group--
SELECT agegroup AS AGE_Group
	,COUNT(*) AS No_Of_Employee
	,sum(cast(attrition AS INT)) AS Attrition
	,cast(round(sum(cast(Attrition AS INT) * 100.0) / count(*), 2) AS DECIMAL(5, 2)) AS Attrition_Percentage
FROM EmployeeAttrition
GROUP BY agegroup
ORDER BY Attrition_Percentage DESC;

--Attrition by Marital Status--
SELECT MaritalStatus AS MartialStatus
	,COUNT(*) AS No_Of_Employee
	,sum(cast(attrition AS INT)) AS Attrition
	,cast(round(sum(cast(Attrition AS INT) * 100.0) / count(*), 2) AS DECIMAL(5, 2)) AS Attrition_Percentage
FROM EmployeeAttrition
GROUP BY MaritalStatus
ORDER BY Attrition_Percentage DESC;

--Attrition by Business Travel--
SELECT BusinessTravel
	,count(*) AS Employee
	,sum(cast(attrition AS INT)) AS Attrition
	,cast(round(sum(cast(Attrition AS INT) * 100.0) / count(*), 2) AS DECIMAL(5, 2)) AS Attrition_Percentage
FROM employeeAttrition
GROUP BY BusinessTravel
ORDER BY Attrition_Percentage DESC

--Attrition by Overtime--
SELECT CASE 
		WHEN overtime = 1
			THEN 'Yes'
		ELSE 'No'
		END AS OverTime
	,count(*) AS Employee
	,sum(cast(attrition AS INT)) AS Attrition
	,cast(round(sum(cast(Attrition AS INT) * 100.0) / count(*), 2) AS DECIMAL(5, 2)) AS Attrition_Percentage
FROM employeeAttrition
GROUP BY overtime
ORDER BY Attrition_Percentage DESC

--Attrition by TenureBand--
SELECT TenureBand
	,count(*) AS Employee
	,sum(cast(attrition AS INT)) AS Attrition
	,cast(round(sum(cast(Attrition AS INT) * 100.0) / count(*), 2) AS DECIMAL(5, 2)) AS Attrition_Percentage
FROM employeeAttrition
GROUP BY TenureBand
ORDER BY Attrition_Percentage DESC
/*Insight

Most employees leave in the first two years.

Company Action

Improve onboarding and mentoring.*/
--Attrition by PromotionAnalysis--
WITH PromotionAnalysis AS (
		SELECT attrition
			,CASE 
				WHEN YearsSinceLastPromotion BETWEEN 0
						AND 1
					THEN '0-1'
				WHEN YearsSinceLastPromotion BETWEEN 2
						AND 4
					THEN '2-4'
				ELSE '5+'
				END AS YearsSinceLastPromotiongroup
		FROM employeeAttrition
		)

SELECT YearsSinceLastPromotiongroup
	,count(*) AS Employee
	,sum(cast(attrition AS INT)) AS Attrition
	,cast(round(sum(cast(Attrition AS INT) * 100.0) / count(*), 2) AS DECIMAL(5, 2)) AS Attrition_Percentage
FROM PromotionAnalysis
GROUP BY YearsSinceLastPromotiongroup
ORDER BY Attrition_Percentage DESC

--Satisfaction Score Analysis--
/*Columns

JobSatisfaction--
EnvironmentSatisfaction
RelationshipSatisfaction
WorkLifeBalance

Business Question

Which satisfaction factor has the strongest relationship with attrition?*/
with SatisfactionAnalysis as 
(

select 
	'Jobsatisfaction' as Satisfaction_Factor,
	case 
		when Jobsatisfaction=1 then 'Low'
		when Jobsatisfaction=2 then 'Medium'
		when Jobsatisfaction=3 then 'High'
		else 'Very High'
	end as satisfying_Level
	,count(*) AS Employee
	,sum(cast(attrition AS INT)) AS Attrition
	,cast(round(sum(cast(Attrition AS INT) * 100.0) / count(*), 2) AS DECIMAL(5, 2)) AS Attrition_Percentage
FROM employeeAttrition
group by Jobsatisfaction


UNION ALL

select 
	'EnvironmentSatisfaction' as Satisfaction_Factor,
	case 
		when EnvironmentSatisfaction=1 then 'Low'
		when EnvironmentSatisfaction=2 then 'Medium'
		when EnvironmentSatisfaction=3 then 'High'
		else 'Very High'
	end as satisfying_Level
	,count(*) AS Employee
	,sum(cast(attrition AS INT)) AS Attrition
	,cast(round(sum(cast(Attrition AS INT) * 100.0) / count(*), 2) AS DECIMAL(5, 2)) AS Attrition_Percentage
FROM employeeAttrition
group by EnvironmentSatisfaction


UNION ALL

select 
	'RelationshipSatisfaction' as Satisfaction_Factor,
	case 
		when RelationshipSatisfaction=1 then 'Low'
		when RelationshipSatisfaction=2 then 'Medium'
		when RelationshipSatisfaction=3 then 'High'
		else 'Very High'
	end as satisfying_Level
	,count(*) AS Employee
	,sum(cast(attrition AS INT)) AS Attrition
	,cast(round(sum(cast(Attrition AS INT) * 100.0) / count(*), 2) AS DECIMAL(5, 2)) AS Attrition_Percentage
FROM employeeAttrition
group by RelationshipSatisfaction


UNION ALL

select 
	'WorkLife_Balance' as Satisfaction_Factor,
	case 
		when WorkLifeBalance=1 then 'Bad'
		when WorkLifeBalance=2 then 'Good'
		when WorkLifeBalance=3 then 'Better'
		else 'Best'
	end as satisfying_Level
	,count(*) AS Employee
	,sum(cast(attrition AS INT)) AS Attrition
	,cast(round(sum(cast(Attrition AS INT) * 100.0) / count(*), 2) AS DECIMAL(5, 2)) AS Attrition_Percentage
FROM employeeAttrition
group by WorkLifeBalance

)
select * ,
	ROW_NUMBER() over(order by Attrition_Percentage desc) as Attrition_Rank
from SatisfactionAnalysis;