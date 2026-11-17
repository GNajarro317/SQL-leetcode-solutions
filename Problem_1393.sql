-- LeetCode Problem 1393: Capital Gain/Loss
-- Source: LeetCode
-- https://leetcode.com/problems/capital-gainloss/
--
-- Goal:
-- Calculate the total capital gain or loss for each stock after
-- all of its buy and sell operations.

-- My solution:
select
    stock_name,
    total_gain - total_loss as capital_gain_loss

from (
    select 
        stock_name,
        sum(capital_loss) as total_loss,
        sum(capital_gain) as total_gain
    from (
        select
            stock_name,
            case when operation = 'Buy' then price end as capital_loss,
            case when operation = 'Sell' then price end as capital_gain
        from stocks
    ) as t
    group by stock_name
) as tt
;