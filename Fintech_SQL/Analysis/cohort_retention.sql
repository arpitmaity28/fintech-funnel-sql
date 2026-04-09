-- =============================================
-- ANALYSIS 2: MONTHLY COHORT ACTIVATION
-- Groups users by signup month and tracks
-- how many from each cohort actually transacted
-- =============================================

SELECT
    TO_CHAR(u.signup_date, 'YYYY-MM')          AS signup_cohort,
    COUNT(DISTINCT u.user_id)                   AS cohort_size,
    COUNT(DISTINCT t.user_id)                   AS activated_users,
    ROUND(
        100.0 * COUNT(DISTINCT t.user_id) 
        / COUNT(DISTINCT u.user_id), 1
    )                                           AS activation_rate_pct,
    ROUND(AVG(t.amount_usd), 2)                AS avg_first_txn_value_usd

FROM users u
LEFT JOIN transactions t ON u.user_id = t.user_id

GROUP BY TO_CHAR(u.signup_date, 'YYYY-MM')
ORDER BY signup_cohort;