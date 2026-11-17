-- LeetCode Problem 3657: Find Loyal Customers
-- Source: LeetCode
-- https://leetcode.com/problems/find-loyal-customers/
--
-- Goal:
-- Identify customers with at least 3 purchases, at least 30 days
-- of activity, and a refund rate below 20%.

-- My solution:
select
    customer_id
from (
    select
        customer_id,
        sum(case when transaction_type = 'purchase' then 1 else 0 end) as purchase_cnt,
        sum(case when transaction_type = 'refund' then 1 else 0 end) as refund_cnt,
        min(transaction_date) as first_transaction,
        max(transaction_date) as last_transaction
    from customer_transactions
    group by customer_id
) as t
where 
    purchase_cnt >= 3
    and datediff(last_transaction,first_transaction) >= 30
    and refund_cnt/(purchase_cnt + refund_cnt) < .2
;