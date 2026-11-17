-- LeetCode Problem 184: Department Highest Salary
-- Source: LeetCode
-- https://leetcode.com/problems/department-highest-salary/
--
-- Goal:
-- Find the employees who have the highest salary in each
-- department.

-- My solution:
with st as (
    select
        max(salary) as maxsalary,
        departmentid as id
    from employee
    group by departmentid
)

select
    d.name as "Department",
    e.name as "Employee",
    e.salary as "Salary"
from employee as e
    left join department as d
        on e.departmentid = d.id
    left join st
        on e.departmentid = st.id
where e.salary = maxsalary
;