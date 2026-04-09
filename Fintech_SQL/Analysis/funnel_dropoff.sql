-- =============================================
-- ANALYSIS 1: FULL FUNNEL DROP-OFF
-- Shows how many users make it through each stage
-- and the conversion rate between stages
-- =============================================

WITH funnel AS (
    SELECT
        COUNT(DISTINCT u.user_id)                          AS total_signups,

        COUNT(DISTINCT k.user_id)                          AS kyc_submitted,

        COUNT(DISTINCT CASE 
            WHEN k.approved_date IS NOT NULL 
            THEN k.user_id END)                            AS kyc_approved,

        COUNT(DISTINCT b.user_id)                          AS bank_linked,

        COUNT(DISTINCT t.user_id)                          AS first_transaction

    FROM users u
    LEFT JOIN kyc_events  k ON u.user_id = k.user_id
    LEFT JOIN bank_linkage b ON u.user_id = b.user_id
    LEFT JOIN transactions t ON u.user_id = t.user_id
)

SELECT
    total_signups,
    kyc_submitted,
    kyc_approved,
    bank_linked,
    first_transaction,

    -- Conversion rates between each stage
    ROUND(100.0 * kyc_submitted    / total_signups,  1) AS pct_submitted_kyc,
    ROUND(100.0 * kyc_approved     / kyc_submitted,  1) AS pct_kyc_approved,
    ROUND(100.0 * bank_linked      / kyc_approved,   1) AS pct_linked_bank,
    ROUND(100.0 * first_transaction / bank_linked,   1) AS pct_first_txn,

    -- Overall activation rate (signup → first transaction)
    ROUND(100.0 * first_transaction / total_signups, 1) AS overall_activation_rate

FROM funnel;