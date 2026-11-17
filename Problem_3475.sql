-- LeetCode Problem 3475: DNA Pattern Recognition
-- Source: LeetCode
-- https://leetcode.com/problems/dna-pattern-recognition/
--
-- Goal:
-- Flag each DNA sample for whether it starts with a start codon,
-- ends with a stop codon, contains a repeated motif, or has a
-- run of at least three consecutive G's.

-- My solution:
select
    sample_id,
    dna_sequence,
    species,
    case when left(dna_sequence, 3) = 'ATG' then 1 else 0 end as has_start,
    case when right(dna_sequence, 3) = 'TAA'
        or right(dna_sequence, 3) = 'TAG'
        or right(dna_sequence, 3) = 'TGA' then 1
    else 0 end as has_stop,
    case when dna_sequence like '%atat%' then 1 else 0 end as has_atat,
    case when dna_sequence like '%ggg%' then 1 else 0 end as has_ggg

from samples
;