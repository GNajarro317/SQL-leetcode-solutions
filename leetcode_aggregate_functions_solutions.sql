-- Author: Gerardo Najarro
-- Created: 9-14-2026

-- LeetCode Problem 1193: Monthly Transactions I
-- Source: LeetCode
-- https://leetcode.com/problems/monthly-transactions-i/
--
-- Goal:
-- For each month and country, calculate total transactions,
-- total transaction amount, approved transactions, and
-- approved transaction amount.


-- My solution:
select
    substring(trans_date, 1, 7) as month,
    country,
    count(id) as trans_count,
    sum(case when state = 'approved' then 1 else 0 end) as approved_count,
    sum(amount) as trans_total_amount,
    sum(case when state = 'approved' then amount else 0 end) as approved_total_amount
from transactions
group by
    month,
    country
;

-- LeetCode Problem 1174: Immediate Food Delivery II
-- Source: LeetCode
-- https://leetcode.com/problems/immediate-food-delivery-ii/
--
-- Goal:
-- Identify each customer's first order and calculate the
-- percentage of those first orders that were immediate deliveries.
--
-- My solution:
select round(sum(case when expected_delivery = 'immediate' then 1 else 0 end)/count(expected_delivery), 4) * 100 as immediate_percentage
from (
    select
        customer_id,
        case when first_order = first_dev then 'immediate' else 'scheduled' end as expected_delivery
    from (
        select
            customer_id,
            min(customer_pref_delivery_date) first_dev,
            min(order_date) as first_order
        from delivery
        group by customer_id
    ) as t
) as tt
;

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
from (
    select
        player_id,
        min(event_date) over (partition by player_id) as first_date,
        next_day
    from (
        select
            player_id,
            event_date,
            lead(event_date) over (partition by player_id order by event_date) as next_day
        from activity
    ) as t
) as tt
;

-- LeetCode Problem 570: Managers with at Least 5 Direct Reports
-- Source: LeetCode
-- https://leetcode.com/problems/managers-with-at-least-5-direct-reports/
--
-- Goal:
-- Identify managers who have at least five direct reports.
--
-- My solution:
select 
    name
from employee
where id in (
    select 
        managerid
    from employee
    group by managerid
    having count(id) >= 5
)
;

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