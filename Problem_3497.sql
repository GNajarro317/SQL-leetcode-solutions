-- LeetCode Problem 3497: Analyze Subscription Conversion
-- Source: LeetCode
-- https://leetcode.com/problems/analyze-subscription-conversion/
--
-- Goal:
-- Identify users who converted from free trial to paid, and
-- calculate each user's average daily activity duration during
-- their trial period versus their paid period.

-- My solution:
with tt as (
    select 
        user_id,
        round(avg(activity_duration), 2) as trial_avg_duration
    from useractivity
    where activity_type = 'free_trial'
    group by user_id
),

pt as (
    select 
        user_id,
        round(avg(activity_duration), 2) as paid_avg_duration
    from useractivity
    where activity_type = 'paid'
    group by user_id    
),

mt as (
    select 
        user_id
    from (
        select 
            user_id,
            max(case when activity_type = 'free_trial' then activity_date end) as last_trial_date,
            min(case when activity_type = 'paid' then activity_date end) as first_paid_date
        from useractivity
        group by user_id
    )
    where 
        first_paid_date is not null 
        and first_paid_date > last_trial_date
)

select 
    mt.user_id,
    trial_avg_duration,
    paid_avg_duration
from mt
    left join tt
        on mt.user_id = tt.user_id
    left join pt
        on mt.user_id = pt.user_id
;