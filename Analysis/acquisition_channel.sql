-- =============================================
-- ANALYSIS 4: CHANNEL QUALITY ANALYSIS
-- Not all signups are equal — which acquisition
-- channel brings users who actually activate?
-- =============================================

SELECT
    u.channel,
    COUNT(DISTINCT u.user_id)                   AS total_signups,
    COUNT(DISTINCT t.user_id)                   AS activated_users,
    ROUND(
        100.0 * COUNT(DISTINCT t.user_id) 
        / COUNT(DISTINCT u.user_id), 1
    )                                           AS activation_rate_pct,
    ROUND(AVG(t.amount_usd), 2)                AS avg_txn_value_usd,
    ROUND(SUM(t.amount_usd), 2)                AS total_revenue_usd

FROM users u
LEFT JOIN transactions t ON u.user_id = t.user_id

GROUP BY u.channel
ORDER BY activation_rate_pct DESC;