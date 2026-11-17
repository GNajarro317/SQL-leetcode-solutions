-- LeetCode Problem 1158: Market Analysis I
-- Source: LeetCode
-- https://leetcode.com/problems/market-analysis-i/
--
-- Goal:
-- For each user, return their join date and the number of orders
-- they placed as a buyer in 2019.

-- My solution:
with bt as (
        select 
            distinct user_id as buyer_id,
            join_date
        from users
        order by buyer_id
)

select
    bt.buyer_id,
    bt.join_date,
    coalesce(count(orders.buyer_id), 0) as orders_in_2019
    from bt
    left join orders
        on bt.buyer_id = orders.buyer_id
        and year(order_date) = 2019
    group by bt.buyer_id
;