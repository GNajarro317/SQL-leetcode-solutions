-- LeetCode Problem 626: Exchange Seats
-- Source: LeetCode
-- https://leetcode.com/problems/exchange-seats/
--
-- Goal:
-- Swap the seat id of every two consecutive students, leaving
-- the last student's id unchanged if the total count is odd.

-- My solution:
select 
    case 
        when id % 2 = 1 and id + 1 in (
            select 
                id 
            from seat
            ) then id + 1
        when id % 2 = 0 then id - 1
        else id
    end as id, 
    student
from seat
order by id
;