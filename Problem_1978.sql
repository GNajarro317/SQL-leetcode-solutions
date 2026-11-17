-- LeetCode Problem 1978: Employees Whose Manager Left the Company
-- Source: LeetCode
-- https://leetcode.com/problems/employees-whose-manager-left-the-company/
--
-- Goal:
-- Find employees earning less than $30,000 whose manager_id
-- points to a manager who no longer exists in the table.

-- My solution:
select
    employee_id
from employees
where 
    salary < 30000
    and manager_id is not null 
    and manager_id not in (
        select
            distinct employee_id
        from employees
        )
order by employee_id
;