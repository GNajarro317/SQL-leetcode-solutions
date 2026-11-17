-- LeetCode Problem 1907: Count Salary Categories
-- Source: LeetCode
-- https://leetcode.com/problems/count-salary-categories/
--
-- Goal:
-- Count the number of accounts in each salary category (Low,
-- Average, High), returning 0 for any category with no accounts.

-- My solution:
select 
    'Low Salary' as category, 
    count(*) as accounts_count 
from accounts 
where income < 20000

union all

select 
    'Average Salary' as category, 
    count(*) as accounts_count 
from accounts 
where income between 20000 and 50000

union all

select 
    'High Salary' as category, 
    count(*) as accounts_count 
from accounts 
where income > 50000
;