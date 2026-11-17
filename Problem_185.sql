-- LeetCode Problem 185: Department Top Three Salaries
-- Source: LeetCode
-- https://leetcode.com/problems/department-top-three-salaries/
--
-- Goal:
-- Find employees whose salary ranks in the top three unique
-- salaries within their department.

-- My solution:
select
    department,
    employee,
    salary
from (
    select    
        d.name as department,
        e.name as employee,
        salary,
        dense_rank() over (partition by e.departmentid order by salary desc) as rnk
    from employee as e
        left join department as d
            on e.departmentid = d.id
) as t
where rnk < 4
;