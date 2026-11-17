-- LeetCode Problem 1070: Product Sales Analysis III
-- Source: LeetCode
-- https://leetcode.com/problems/product-sales-analysis-iii/
--
-- Goal:
-- For each product, find all sales entries that occurred in the
-- first year that product was sold.

-- My solution:
select 
    product_id, 
    year as first_year, 
    quantity, 
    price 
from sales 
where (product_id, year) in (
    select 
        product_id, 
        min(year)
    from sales
    group by product_id
)
;