/*
Question: What are the most optimal skills for data engineers—balancing both demand and salary?
- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on remote Data Engineer positions with specified annual salaries.
- Why?
    - This approach highlights skills that balance market demand and financial reward. It weights core skills appropriately instead of letting rare, outlier skills distort the results.
    - The natural log transformation ensures that both high-salary and widely in-demand skills surface as the most practical and valuable to learn for data engineering careers.
*/
SELECT
    sd.skills,
    --COUNT(jpf.salary_year_avg) AS corrected_demand_count,
    ROUND(MEDIAN(jpf.salary_year_avg),0) as median_salary,
    ROUND(ln(COUNT(jpf.*)),1) as ln_demand_count,
    ROUND((MEDIAN(jpf.salary_year_avg) * ln(COUNT(jpf.*))) / 10^5,2) AS Score
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
     jpf.job_title_short ='Data Engineer'
     AND jpf.job_work_from_home =True
     AND jpf.salary_year_avg IS NOT NULL
GROUP BY
    sd.skills
HAVING
    COUNT(sd.skills) >=100
ORDER BY
    Score DESC
LIMIT 25;

/*
┌────────────┬───────────────┬─────────────────┬────────┐
│   skills   │ median_salary │ ln_demand_count │ Score  │
│  varchar   │    double     │     double      │ double │
├────────────┼───────────────┼─────────────────┼────────┤
│ terraform  │      184000.0 │             5.3 │   9.68 │
│ python     │      135000.0 │             7.0 │   9.49 │
│ aws        │      137320.0 │             6.7 │   9.15 │
│ sql        │      130000.0 │             7.0 │   9.14 │
│ airflow    │      150000.0 │             6.0 │   8.93 │
│ spark      │      140000.0 │             6.2 │   8.71 │
│ snowflake  │      135500.0 │             6.1 │   8.24 │
│ kafka      │      145000.0 │             5.7 │   8.23 │
│ azure      │      128000.0 │             6.2 │   7.89 │
│ java       │      135000.0 │             5.7 │   7.71 │
│ scala      │      137290.0 │             5.5 │   7.56 │
│ kubernetes │      150500.0 │             5.0 │   7.51 │
│ git        │      140000.0 │             5.3 │   7.47 │
│ databricks │      132750.0 │             5.6 │   7.41 │
│ redshift   │      130000.0 │             5.6 │    7.3 │
│ gcp        │      136000.0 │             5.3 │   7.18 │
│ hadoop     │      135000.0 │             5.3 │   7.14 │
│ nosql      │      134415.0 │             5.3 │   7.07 │
│ pyspark    │      140000.0 │             5.0 │   7.03 │
│ docker     │      135000.0 │             5.0 │   6.71 │
│ mongodb    │      135750.0 │             4.9 │   6.67 │
│ go         │      140000.0 │             4.7 │   6.62 │
│ r          │      134775.0 │             4.9 │   6.59 │
│ github     │      135000.0 │             4.8 │   6.54 │
│ bigquery   │      135000.0 │             4.8 │    6.5 │
└────────────┴───────────────┴─────────────────┴────────┘
*/