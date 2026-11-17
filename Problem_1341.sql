-- LeetCode Problem 1341: Movie Rating
-- Source: LeetCode
-- https://leetcode.com/problems/movie-rating/
--
-- Goal:
-- Find the user who rated the most movies (ties broken
-- alphabetically), and the movie with the highest average
-- rating in February 2020 (ties broken alphabetically).

-- My solution:
(select
    name as results
from users
    left join movierating
        on users.user_id = movierating.user_id
group by movierating.user_id
having count(distinct movierating.movie_id)
order by 
    count(distinct movierating.movie_id) desc,
    name asc
limit 1
)

union all

(select 
    title as results
from movierating
    left join movies
        on movierating.movie_id = movies.movie_id
where 
    year(created_at) = 2020 
    and month(created_at) = 2
group by movierating.movie_id
having avg(rating)
order by 
    avg(rating) desc,
    title asc
    limit 1
)
;