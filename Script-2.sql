SELECT 
    COUNT(*) AS total_contacts,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS conversions,
    ROUND(100.0 * SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS conversion_rate_pct
FROM bank_full;


WITH conversion_by_job AS (
    SELECT 
        job,
        COUNT(*) AS total,
        SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS conversions
    FROM bank_full
    GROUP BY job
)
SELECT 
    job, total, conversions,
    ROUND(100.0 * conversions / total, 2) AS conversion_rate_pct,
    RANK() OVER (ORDER BY 1.0 * conversions / total DESC) AS rank_by_conversion
FROM conversion_by_job
ORDER BY conversion_rate_pct DESC


