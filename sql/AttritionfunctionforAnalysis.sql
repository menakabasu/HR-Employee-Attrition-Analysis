USE HRAnalytics;
DROP FUNCTION dbo.AttritionRate;

CREATE FUNCTION dbo.AttritionRate()
RETURNS DECIMAL(5,2)
AS
BEGIN
    RETURN
    (
        SELECT 
            100.0 * SUM(cast (attrition as int)) / COUNT(*)
        FROM EmployeeAttrition
    )

END;

SELECT dbo.AttritionRate() AS Attrition_Percentage;
CREATE INDEX IX_Department
ON EmployeeAttrition(Department);