USE HRAnalytics;
GO
--Find the 10 employees who are earning below their department's average salary.

;WITH SalaryAnalysis AS
(
    SELECT
        EmployeeNumber,
        Attrition,
        Department,
        MonthlyIncome,
         
        AVG(MonthlyIncome) OVER (PARTITION BY Department) AS Department_Average,
        MonthlyIncome - AVG(MonthlyIncome) OVER (PARTITION BY Department) AS Salary_Difference
    FROM EmployeeAttrition
),
RankedEmployees AS
(
    SELECT
        EmployeeNumber,
        Attrition,
        Department,
        MonthlyIncome,
        Department_Average,
        Salary_Difference,
      
        ROW_NUMBER() OVER (
            PARTITION BY Department
            ORDER BY Salary_Difference ASC
        ) AS Rank_No
    FROM SalaryAnalysis
    WHERE MonthlyIncome < Department_Average
)
SELECT
    EmployeeNumber,
     Attrition,
    Department,
    MonthlyIncome,
    Department_Average,
    Salary_Difference,
    
    Rank_No
FROM RankedEmployees
WHERE Rank_No <= 10 
ORDER BY Department, Rank_No;