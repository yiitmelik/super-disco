SELECT
    job_id,
    job_title_short,
    name AS company_name,
    job_location
FROM
    job_postings_fact AS jpf --table A
LEFT JOIN company_dim AS cd --table B
    ON  jpf.company_id = cd.company_id --left join preserves A
LIMIT 10 ;


SELECT
    job_id,
    job_title_short,
    name AS company_name,
    job_location
FROM
    job_postings_fact AS jpf --table A
INNER JOIN company_dim AS cd --table B. Can be written just as JOIN
    ON  jpf.company_id = cd.company_id --inner joins gets only commons
LIMIT 10 ;


SELECT
    job_id,
    job_title_short,
    name AS company_name,
    job_location
FROM
    job_postings_fact AS jpf --table A
FULL OUTER JOIN company_dim AS cd --table B. Can be written without OUTER
    ON  jpf.company_id = cd.company_id --inner joins gets all table
LIMIT 10 ;