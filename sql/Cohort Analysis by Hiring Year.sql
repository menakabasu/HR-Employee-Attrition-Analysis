USE HRAnalytics;
WITH HireCohort AS
(
    SELECT
        EmployeeNumber,
        Attrition,
        CASE
            WHEN (2018 - YearsAtCompany) < 2000 THEN 'Before 2000'
            WHEN (2018 - YearsAtCompany) BETWEEN 2000 AND 2004 THEN '2000-2004'
            WHEN (2018 - YearsAtCompany) BETWEEN 2005 AND 2009 THEN '2005-2009'
            WHEN (2018 - YearsAtCompany) BETWEEN 2010 AND 2014 THEN '2010-2014'
            WHEN (2018 - YearsAtCompany) BETWEEN 2015 AND 2018 THEN '2015-2018'
        END AS HireCohort
    FROM EmployeeAttrition
)

SELECT
    HireCohort,
    COUNT(*) AS TotalEmployees,
    SUM(CAST(Attrition AS INT)) AS EmployeesLeft,
    ROUND(
        100.0 * SUM(CAST(Attrition AS INT)) / COUNT(*),
        2
    ) AS AttritionPercentage
FROM HireCohort
GROUP BY HireCohort
ORDER BY AttritionPercentage DESC;