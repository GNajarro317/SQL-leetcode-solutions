-- LeetCode Problem 585: Investments in 2016
-- Source: LeetCode
-- https://leetcode.com/problems/investments-in-2016/
--
-- Goal:
-- Sum tiv_2016 for policyholders who share their tiv_2015 value
-- with at least one other policyholder, but whose (lat, lon)
-- location is unique.

-- My solution:
select
    round(sum(tiv_2016), 2) as tiv_2016
from insurance
where
    tiv_2015 in (
        select 
            tiv_2015
        from insurance
        group by tiv_2015
        having count(*) > 1
    )
    and (lat, lon) in (
        select
            lat, 
            lon
        from insurance
        group by lat, lon
        having count(*) = 1
    )
;