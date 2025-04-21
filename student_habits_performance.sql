SELECT 
    *
FROM
    adarsh.students;

-- LEVEL 1 – Aggregations & Filtering
-- Find the average study hours and exam score grouped by gender.

SELECT 
    gender,
    AVG(study_hours_per_day) AvgHours,
    AVG(exam_score) AvgScore
FROM
    students
GROUP BY gender

-- List the top 5 students with the highest exam scores.

SELECT 
    student_id, exam_score
FROM
    students
ORDER BY exam_score DESC
LIMIT 5

-- Identify students who sleep less than 6 hours and have an exam score above 80.

SELECT 
    student_id Students,
    sleep_hours SleepHours,
    exam_score ExamScore
FROM
    students
WHERE
    sleep_hours < 6 AND exam_score > 80
ORDER BY ExamScore DESC


-- LEVEL 2 – Case Statements & Logic Categorize students based on their exam_score into:
-- Excellent (90+)
-- Good (70-89)
-- Average (50-69)
-- Needs Improvement (<50)

SELECT 
    student_id Students,
    exam_score ExamScore,
    CASE
        WHEN exam_score >= 90 THEN 'Excellent'
        WHEN exam_score BETWEEN 70 AND 89 THEN 'Good'
        WHEN exam_score BETWEEN 50 AND 69 THEN 'Average'
        ELSE 'Needs Improvement'
    END AS StudentCat
FROM
    students	

 -- Compare the average exam score of students with and without a part-time job.

select student_id Students, avg(exam_score) ExamScore, part_time_job from students group by part_time_job;

-- LEVEL 3 – Window Functions
-- Within each parental education level, rank students based on exam score.

SELECT 
    student_id,
    internet_quality,
    exam_score,
    LAG(exam_score) OVER (
        PARTITION BY internet_quality 
        ORDER BY exam_score DESC
    ) AS previous_exam_score
FROM students;

-- LEVEL 4 – CTE & Insights
-- Create a CTE to find the average mental health rating by internet quality, then show only those below average (e.g., < 3.5).

with AvgMentalHealth as (
SELECT avg(mental_health_rating) AvgRating, internet_quality FROM students 
group by internet_quality
)

select * from AvgMentalHealth where AvgRating < 3.5 ;

-- Use a CTE to count how many students participated in extracurricular activities and show their average exam score.

with Counts as (
select count(student_id) StudentCount, extracurricular_participation, avg(exam_score) from students group by extracurricular_participation
)

select * from Counts;