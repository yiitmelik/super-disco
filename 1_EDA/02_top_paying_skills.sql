/*
Question: What are the highest-paying skills for data engineers?
- Calculate the median salary for each skill required in data engineer positions
- Focus on remote positions with specified salaries
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command the highest compensation while also showing 
    how common those skills are, providing a more complete picture for skill development priorities
*/
SELECT
    sd.skills,
    COUNT(sd.skills) AS demand_count,
    round(MEDIAN(jpf.salary_year_avg),0) as median
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
     jpf.job_title_short ='Data Engineer'
     AND jpf.job_work_from_home =True
GROUP BY
    sd.skills
HAVING
    demand_count >=100
ORDER BY
    median DESC
LIMIT 25;

/*
┌────────────┬──────────────┬──────────┐
│   skills   │ demand_count │  median  │
│  varchar   │    int64     │  double  │
├────────────┼──────────────┼──────────┤
│ rust       │          232 │ 210000.0 │
│ terraform  │         3248 │ 184000.0 │
│ golang     │          912 │ 184000.0 │
│ spring     │          364 │ 175500.0 │
│ neo4j      │          277 │ 170000.0 │
│ gdpr       │          582 │ 169616.0 │
│ zoom       │          127 │ 168438.0 │
│ graphql    │          445 │ 167500.0 │
│ mongo      │          265 │ 162250.0 │
│ fastapi    │          204 │ 157500.0 │
│ bitbucket  │          478 │ 155000.0 │
│ django     │          265 │ 155000.0 │
│ crystal    │          129 │ 154224.0 │
│ atlassian  │          249 │ 151500.0 │
│ c          │          444 │ 151500.0 │
│ typescript │          388 │ 151000.0 │
│ kubernetes │         4202 │ 150500.0 │
│ ruby       │          736 │ 150000.0 │
│ airflow    │         9996 │ 150000.0 │
│ css        │          262 │ 150000.0 │
│ node       │          179 │ 150000.0 │
│ redis      │          605 │ 149000.0 │
│ vmware     │          136 │ 148798.0 │
│ ansible    │          475 │ 148798.0 │
│ jupyter    │          400 │ 147500.0 │
└────────────┴──────────────┴──────────┘
*/