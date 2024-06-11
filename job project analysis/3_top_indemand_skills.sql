/* What are the top indemand skills for data analyst?
Identify the top 5 skils
Focus on all job postings
*/

-- top 5 indemand skills for data analyst
SELECT skills, COUNT(skills_job_dim.job_id) AS skill_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title ILIKE '%data analyst%'
GROUP BY skills
ORDER BY skill_count DESC
LIMIT 5



-- top 5 indemand skills 
SELECT skills, COUNT(skills_job_dim.job_id) AS skill_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

GROUP BY skills
ORDER BY skill_count DESC
LIMIT 5