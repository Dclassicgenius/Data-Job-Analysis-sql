/*
- What are the top paying jobs for data analyst?
- What are the top 100 highest paying data analyst role remotely?
- Only get jobs with specified salary range


*/


-- top 100 Remote data analyst roles with the highest paying salary
SELECT 
    job_id, 
    job_title_short, 
    job_title, 
    job_location, 
    job_schedule_type, 
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