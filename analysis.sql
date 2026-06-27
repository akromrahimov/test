-- 1. Расчёт ключевых показателей по депозитам
SELECT 
    COUNT(*) AS total_contacts,    -- Общее количество контактов с клиентами
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS conversions,    -- Количество успешно оформленных депозитов
    ROUND(100.0 * SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS conversion_rate_pct    -- Общий коэффициент конверсии (%)
FROM bank_full;


-- 2. Анализ конверсии по профессиям клиентов
WITH conversion_by_job AS (
    SELECT 
        job,
        COUNT(*) AS total,    -- Общее количество клиентов по профессии
        SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS conversions    -- Количество оформленных депозитов
    FROM bank_full
    GROUP BY job
)
SELECT 
    job, total, conversions,     
    ROUND(100.0 * conversions / total, 2) AS conversion_rate_pct,    -- Конверсия (%)
    RANK() OVER (ORDER BY 1.0 * conversions / total DESC) AS rank_by_conversion    -- Рейтинг профессий по конверсии
FROM conversion_by_job
ORDER BY conversion_rate_pct DESC


-- 3. Анализ эффективности каналов связи
WITH conversion_by_contact AS (
    SELECT 
        contact,
        COUNT(*) AS total,    -- Общее количество контактов по каждому каналу связи
        SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS conversions    -- Количество успешно оформленных депозитов
        FROM bank_full 
        GROUP BY contact
 )
 SELECT  
     contact, total, conversions,
     ROUND(100.0 * conversions / total, 2) AS conversion_rate_contact    -- Коэффициент конверсии (%)
FROM conversion_by_contact
ORDER BY conversion_rate_contact DESC;    -- Сортировка по убыванию конверсии


-- 4. Анализ конверсии по месяцам





