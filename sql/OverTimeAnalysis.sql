USE HRAnalytics;
--Department Wise Attrition
select 
		case
		when overtime=1 then 'Yes'
		else 'No'
		end as OverTime,
		count(*) as Employee,
sum(cast(attrition as int)) as Attrition,
 cast(round(sum(cast(Attrition as int)*100.0)/count(*),2) as decimal(5,2)) as  Attrition_Percentage

from employeeAttrition 
group by overtime
order by  Attrition_Percentage
 desc
 /*Recommendation

HR should investigate:

Whether employees are working excessive overtime.
Whether workload can be distributed more evenly.
Whether additional staffing or flexible working arrangements could reduce overtime and improve retention.*/