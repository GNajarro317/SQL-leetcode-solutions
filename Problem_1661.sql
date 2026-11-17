-- LeetCode Problem 1661: Average Time of Process per Machine
-- Source: LeetCode
-- https://leetcode.com/problems/average-time-of-process-per-machine/

-- Goal:
-- Calculate the average time each machine takes to complete
-- a process by finding the difference between the start and
-- end timestamps for each process, then averaging those times
-- for each machine. Round the result to 3 decimal places.

-- My solution:
select
    machine_id,
    round(avg(time),3) as processing_time
from (
    select
        *,
        lag(timestamp) over (order by machine_id, process_id, activity_type) as starttime,
        timestamp - lag(timestamp) over (order by machine_id, process_id, activity_type) as time
    from activity
) as t
where activity_type = 'end'
group by machine_id
;