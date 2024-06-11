
/* What are the optimal skills to learn ie high demand and high paying */

WITH skills_demand AS (
    SELECT skills_dim.skill_id, skills_dim.skills, COUNT(skills_job_dim.job_id) AS skill_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id

), avg_salary AS (
    SELECT skills_job_dim.skill_id, ROUND(AVG(salary_year_avg), 0) AS salary_avg
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE salary_year_avg IS NOT NULL
    GROUP BY skills_job_dim.skill_id

)

-- SELECT skills_demand.skill_id, skills_demand.skills, skill_count, avg_salary.salary_avg
-- FROM skills_demand
-- INNER JOIN avg_salary ON skills_demand.skill_id = avg_salary.skill_id
-- ORDER BY skill_count DESC, salary_avg DESC
-- LIMIT 25


SELECT skills_demand.skill_id, skills_demand.skills, skill_count, avg_salary.salary_avg
FROM skills_demand
INNER JOIN avg_salary ON skills_demand.skill_id = avg_salary.skill_id
WHERE skill_count > 10
ORDER BY salary_avg DESC, skill_count DESC
LIMIT 25