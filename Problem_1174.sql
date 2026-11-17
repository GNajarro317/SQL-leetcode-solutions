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
) as t2
;