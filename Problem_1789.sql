-- LeetCode Problem 1789: Primary Department for Each Employee
-- Source: LeetCode
-- https://leetcode.com/problems/primary-department-for-each-employee/
--
-- Goal:
-- Report each employee's primary department. Employees in only
-- one department have that department returned even though their
-- primary_flag is 'N'.

-- My solution:
with ue as (
    select
        employee_id,
        department_id,
        count(distinct department_id) as cnt
    from employee
    group by employee_id
    having cnt = 1
)

select
    e.employee_id,
    e.department_id
from employee as e
    left join ue
        on e.employee_id = ue.employee_id
where e.primary_flag = 'Y' or cnt = 1
;