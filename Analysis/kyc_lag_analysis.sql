-- =============================================
-- ANALYSIS 3: KYC LAG vs ACTIVATION
-- Tests hypothesis: faster KYC = higher chance
-- of completing first transaction
-- =============================================

SELECT
    u.user_id,
    u.channel,
    u.user_type,
    k.submitted_date,
    k.approved_date,

    -- Days taken for KYC approval
    (k.approved_date - k.submitted_date)        AS kyc_approval_days,

    -- Did they transact?
    CASE WHEN t.user_id IS NOT NULL 
         THEN 'Yes' ELSE 'No' END               AS activated,

    t.amount_usd                                AS first_txn_amount

FROM users u
JOIN kyc_events k   ON u.user_id = k.user_id
LEFT JOIN transactions t ON u.user_id = t.user_id

WHERE k.approved_date IS NOT NULL  -- only approved users

ORDER BY kyc_approval_days;