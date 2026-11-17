-- LeetCode Problem 1204: Last Person to Fit in the Bus
-- Source: LeetCode
-- https://leetcode.com/problems/last-person-to-fit-in-the-bus/
--
-- Goal:
-- Find the name of the last person who can board the bus, in
-- turn order, without the cumulative weight exceeding 1000 kg.

-- My solution:
with tw as (
select
    person_name,
    sum(weight) over (order by turn) as total_weight
from queue
order by turn
)

select
    q.person_name
from queue as q
    left join tw
        on q.person_name = tw.person_name
where total_weight <= 1000
order by total_weight desc
limit 1
;