-- LeetCode Problem 602: Friend Requests II: Who Has the Most Friends
-- Source: LeetCode
-- https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/
--
-- Goal:
-- Find the person with the most total friends (as either
-- requester or accepter) and their friend count.

-- My solution:
select 
    id, 
    count(*) AS num
from (
    select 
        requester_id as id 
    from requestaccepted

    union all
    
    select
        accepter_id as id
    from requestaccepted
) as ra
group by id
order by num desc
limit 1
;