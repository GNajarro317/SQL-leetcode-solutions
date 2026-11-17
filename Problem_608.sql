-- LeetCode Problem 608: Tree Node
-- Source: LeetCode
-- https://leetcode.com/problems/tree-node/
--
-- Goal:
-- Classify each node in a tree as Root, Inner, or Leaf based on
-- its position relative to parent and child relationships.

-- My solution:
select
    id,
    case
        when p_id is null then 'Root'
        when id in 
            (select distinct p_id from tree where p_id != 
                (select id from tree where p_id is null)) then 'Inner'
        else 'Leaf'
    end as type
from tree
order by id
;