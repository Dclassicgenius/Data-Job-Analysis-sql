/* What are the top  skills based on salary?
Identify the average salary based on skills
*/

-- avg salary based on skills for data analyst
SELECT skills, ROUND(AVG(salary_year_avg), 0) AS salary_avg
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title ILIKE '%data analyst%' AND salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY salary_avg DESC
LIMIT 50


-- avg salary based on skills
SELECT skills, ROUND(AVG(salary_year_avg), 0) AS salary_avg
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY salary_avg DESC
LIMIT 50