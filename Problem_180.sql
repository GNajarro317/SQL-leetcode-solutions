-- LeetCode Problem 180: Consecutive Numbers
-- Source: LeetCode
-- https://leetcode.com/problems/consecutive-numbers/
--
-- Goal:
-- Find all numbers that appear at least three times consecutively
-- in the Logs table.

-- My solution:
with cn as (
    select
        id,
        num,
        lead(num, 1) over (order by id) as num_2,
        lead(num, 2) over (order by id) as num_3
    from logs
)
select 
    num as consecutivenums
from cn
where
    num = num_2
    and num = num_3
group by num
;