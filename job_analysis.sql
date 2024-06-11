SELECT 
    COUNT(job_id) AS job_count,
    
    EXTRACT(MONTH FROM job_posted_date) AS date_month
FROM job_postings_fact
GROUP BY date_month
ORDER BY job_count DESC;


CREATE TABLE january_2023_jobs AS
    SELECT *
    FROM job_postings_fact

    WHERE EXTRACT(YEAR FROM job_posted_date) = 2023 AND EXTRACT(MONTH FROM job_posted_date) = 1;

CREATE TABLE february_2023_jobs AS
    SELECT *
    FROM job_postings_fact

    WHERE EXTRACT(YEAR FROM job_posted_date) = 2023 AND EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE march_2023_jobs AS
    SELECT *
    FROM job_postings_fact

    WHERE EXTRACT(YEAR FROM job_posted_date) = 2023 AND EXTRACT(MONTH FROM job_posted_date) = 3;

SELECT job_posted_date
FROM january_2023_jobs;

-- top companies with most jobs 

WITH top_companies AS (
SELECT company_id, COUNT(company_id) AS company_count
FROM job_postings_fact
GROUP BY company_id
ORDER BY company_count DESC)



SELECT c.name, t.company_count 
FROM company_dim c
JOIN top_companies t
ON c.company_id = t.company_id
ORDER BY t.company_count DESC

-- end of query


-- most popular skills for remote jobs 

WITH remote_jobs AS (
    SELECT sk.skill_id, jbf.job_id
FROM job_postings_fact jbf
JOIN skills_job_dim sk
ON jbf.job_id = sk.job_id
WHERE job_location = 'Anywhere'
)


SELECT rj.skill_id,  s.skills, COUNT(rj.skill_id) AS skill_count
FROM  skills_dim s
JOIN remote_jobs rj
ON s.skill_id = rj.skill_id
GROUP BY rj.skill_id, s.skills
ORDER BY skill_count DESC
LIMIT 5

-- end of query



--First quater jobs greater than 70000

WITH first_quater_jobs AS (
    
SELECT job_title_short, company_id, job_location, salary_year_avg
FROM january_2023_jobs

UNION ALL

SELECT job_title_short, company_id, job_location,salary_year_avg
FROM february_2023_jobs

UNION ALL

SELECT job_title_short, company_id, job_location, salary_year_avg
FROM march_2023_jobs
)

SELECT * 
FROM first_quater_jobs
WHERE salary_year_avg > 70000
ORDER BY salary_year_avg DESC