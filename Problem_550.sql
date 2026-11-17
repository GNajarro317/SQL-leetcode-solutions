-- LeetCode Problem 550: Game Play Analysis IV
-- Source: LeetCode
-- https://leetcode.com/problems/game-play-analysis-iv/
--
-- Goal:
-- Calculate the fraction of players who returned on the
-- calendar day immediately after their first login.
--
-- My solution:
select 
    round(sum(case when next_day = first_date + interval 1 day then 1 else 0 end)/count(distinct player_id), 2) as fraction
from
(
    select
        player_id,
        min(event_date) over (partition by player_id) as first_date,
        next_day
    from 
    (
        select
            player_id,
            event_date,
            lead(event_date) over (partition by player_id order by event_date) as next_day
        from activity
    ) as t
) as t2
;