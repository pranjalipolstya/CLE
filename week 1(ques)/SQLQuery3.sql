SELECT
    student_id,

    UPPER(TRIM(student_name)) AS clean_name,

    CASE
        WHEN email IS NULL THEN 'Not Provided'
        ELSE LEFT(email, CHARINDEX('@', email) - 1)
    END AS email_user,

    CASE
        WHEN email IS NULL THEN 'Not Provided'
        ELSE SUBSTRING(email, CHARINDEX('@', email) + 1, LEN(email))
    END AS email_domain,

    CASE
        WHEN phone IS NULL THEN 'Not Provided'
        ELSE CONCAT('XXXXXX', RIGHT(phone, 4))
    END AS masked_phone,

    DATENAME(MONTH, join_date) AS join_month,

    DATEDIFF(DAY, join_date, '2026-10-01') AS days_with_us

FROM students1
ORDER BY student_id;