-- LeetCode Problem 1934: Confirmation Rate
-- Source: LeetCode
-- https://leetcode.com/problems/confirmation-rate/
--
-- Goal:
-- Calculate each user's confirmation rate based on their
-- confirmation requests and their outcomes.
--
-- My solution:
select
    s.user_id,
    round(coalesce(sum(case when action = 'confirmed' then 1 else 0 end) / count(action),0),2) as confirmation_rate
from confirmations as c
    right join signups as s
        on c.user_id = s. user_id
group by s.user_id
;