
USE HRAnalytics;

SELECT BusinessTravel
	,count(*) AS Employee
	,sum(cast(attrition AS INT)) AS Attrition
	,cast(round(sum(cast(Attrition AS INT) * 100.0) / count(*), 2) AS DECIMAL(5, 2)) AS Attrition_Percentage
FROM employeeAttrition
GROUP BY BusinessTravel
ORDER BY Attrition_Percentage DESC
	/*Business Insight


Employees who travel frequently have the highest attrition rate (24.91%).
Employees who travel rarely have a moderate attrition rate (14.96%).
Employees who do not travel have the lowest attrition rate (8.00%).

This suggests that frequent business travel may be associated with a higher likelihood of employees leaving the company.

Business Recommendation

HR could consider:

Reviewing travel schedules to avoid excessive travel.
Offering flexible work arrangements after business trips.
Providing additional support for employees who travel frequently.
Monitoring work-life balance for travelling*/