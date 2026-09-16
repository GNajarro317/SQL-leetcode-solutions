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
) as t2
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

-- LeetCode Problem 1045: Customers Who Bought All Products
-- Source: LeetCode
-- https://leetcode.com/problems/customers-who-bought-all-products/
--
-- Goal:
-- Find the customer ids who purchased every product listed in
-- the Product table.

-- My solution:
select
    customer_id
from customer
group by customer_id
having count(distinct product_key) =  
    (select count(product_key) as cnt from product)
;

-- LeetCode Problem 1789: Primary Department for Each Employee
-- Source: LeetCode
-- https://leetcode.com/problems/primary-department-for-each-employee/
--
-- Goal:
-- Report each employee's primary department. Employees in only
-- one department have that department returned even though their
-- primary_flag is 'N'.

-- My solution:
with ue as (
    select
        employee_id,
        department_id,
        count(distinct department_id) as cnt
    from employee
    group by employee_id
    having cnt = 1
)

select
    e.employee_id,
    e.department_id
from employee as e
    left join ue
        on e.employee_id = ue.employee_id
where e.primary_flag = 'Y' or cnt = 1
;

-- LeetCode Problem 180: Consecutive Numbers
-- Source: LeetCode
-- https://leetcode.com/problems/consecutive-numbers/
--
-- Goal:
-- Find all numbers that appear at least three times consecutively
-- in the Logs table.

-- My solution:
with cn as (
    select
        id,
        num,
        lead(num, 1) over (order by id) as num_2,
        lead(num, 2) over (order by id) as num_3
    from logs
)
select 
    num as consecutivenums
from cn
where
    num = num_2
    and num = num_3
group by num
;

-- LeetCode Problem 1164: Product Price at a Given Date
-- Source: LeetCode
-- https://leetcode.com/problems/product-price-at-a-given-date/
--
-- Goal:
-- Find the price of every product as of 2019-08-16, given that
-- all products start at price 10 and change over time.

-- My solution:
select
    p1.product_id,
    coalesce(
        (
        select
            p2.new_price
        from products as p2
        where 
            p2.product_id = p1.product_id
            and p2.change_date <= '2019-8-16'
        order by p2.change_date desc
        limit 1
        ), 10 ) as price
from products as p1
group by p1.product_id
;

-- LeetCode Problem 1204: Last Person to Fit in the Bus
-- Source: LeetCode
-- https://leetcode.com/problems/last-person-to-fit-in-the-bus/
--
-- Goal:
-- Find the name of the last person who can board the bus, in
-- turn order, without the cumulative weight exceeding 1000 kg.

-- My solution:
with tw as (
select
    person_name,
    sum(weight) over (order by turn) as total_weight
from queue
order by turn
)

select
    q.person_name
from queue as q
    left join tw
        on q.person_name = tw.person_name
where total_weight <= 1000
order by total_weight desc
limit 1
;


-- LeetCode Problem 1907: Count Salary Categories
-- Source: LeetCode
-- https://leetcode.com/problems/count-salary-categories/
--
-- Goal:
-- Count the number of accounts in each salary category (Low,
-- Average, High), returning 0 for any category with no accounts.

-- My solution:
select 
    'Low Salary' as category, 
    count(*) as accounts_count 
from accounts 
where income < 20000

union all

select 
    'Average Salary' as category, 
    count(*) as accounts_count 
from accounts 
where income between 20000 and 50000

union all

select 
    'High Salary' as category, 
    count(*) as accounts_count 
from accounts 
where income > 50000
;