/* What skills are required for the top-paying data analyst jobs?  */

WITH top_paying_jobs AS (
    SELECT 
    job_id, 
    job_title_short, 
    job_title, 
    salary_year_avg,
    name AS company_name, 
    job_posted_date::date
FROM 
    job_postings_fact jpf
LEFT JOIN 
    company_dim c
ON 
    jpf.company_id = c.company_id
WHERE 
    job_title ILIKE '%data analyst%' 
    AND job_work_from_home = TRUE 
    AND salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC

LIMIT 100
)

SELECT top_paying_jobs.*, skills 
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC