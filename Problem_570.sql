-- LeetCode Problem 570: Managers with at Least 5 Direct Reports
-- Source: LeetCode
-- https://leetcode.com/problems/managers-with-at-least-5-direct-reports/
--
-- Goal:
-- Identify managers who have at least five direct reports.
--
-- My solution:
select 
    name
from employee
where id in (
    select 
        managerid
    from employee
    group by managerid
    having count(id) >= 5
)
;