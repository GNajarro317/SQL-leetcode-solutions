-- LeetCode Problem 1321: Restaurant Growth
-- Source: LeetCode
-- https://leetcode.com/problems/restaurant-growth/
--
-- Goal:
-- Compute a 7-day moving sum and average of customer spending,
-- rounded to two decimal places, ordered by visit date.

-- My solution:
select 
    distinct visited_on,
    sum(amount) over (order by visited_on range between interval 6 day preceding and current row) as amount,
    round(sum(amount) over (order by visited_on range between interval 6 day preceding and current row) / 7, 2) as average_amount
from customer
limit 10000 offset 6
;