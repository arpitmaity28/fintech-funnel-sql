-- =============================================
-- FINTECH USER FUNNEL ANALYSIS
-- Simulating a cross-border payments platform
-- (inspired by platforms like Skydo/Wise/Payoneer)
-- =============================================

-- TABLE 1: Users — one row per user who signed up
CREATE TABLE users (
    user_id       INTEGER PRIMARY KEY,
    signup_date   DATE,
    channel       VARCHAR(50),   -- how they heard about us
    country       VARCHAR(50),
    user_type     VARCHAR(50)    -- freelancer, agency, business
);

-- TABLE 2: KYC Events — tracks verification journey
CREATE TABLE kyc_events (
    user_id         INTEGER,
    submitted_date  DATE,
    approved_date   DATE,         -- NULL if not yet approved
    rejection_reason VARCHAR(100) -- NULL if approved
);

-- TABLE 3: Bank Linkage
CREATE TABLE bank_linkage (
    user_id      INTEGER,
    linked_date  DATE
);

-- TABLE 4: Transactions — actual payment activity
CREATE TABLE transactions (
    txn_id        INTEGER PRIMARY KEY,
    user_id       INTEGER,
    txn_date      DATE,
    amount_usd    DECIMAL(10,2),
    currency_from VARCHAR(10),
    currency_to   VARCHAR(10)
);

-- =============================================
-- INSERT MOCK DATA
-- =============================================

INSERT INTO users VALUES
(1,  '2024-01-05', 'Instagram',  'India', 'freelancer'),
(2,  '2024-01-07', 'Referral',   'India', 'freelancer'),
(3,  '2024-01-10', 'Google Ads', 'India', 'business'),
(4,  '2024-01-12', 'Instagram',  'India', 'freelancer'),
(5,  '2024-01-15', 'Referral',   'India', 'agency'),
(6,  '2024-02-01', 'Google Ads', 'India', 'freelancer'),
(7,  '2024-02-03', 'Instagram',  'India', 'freelancer'),
(8,  '2024-02-10', 'Referral',   'India', 'business'),
(9,  '2024-02-14', 'Google Ads', 'India', 'freelancer'),
(10, '2024-02-20', 'Instagram',  'India', 'freelancer'),
(11, '2024-03-01', 'Referral',   'India', 'agency'),
(12, '2024-03-05', 'Google Ads', 'India', 'freelancer'),
(13, '2024-03-10', 'Instagram',  'India', 'freelancer'),
(14, '2024-03-15', 'Referral',   'India', 'business'),
(15, '2024-03-20', 'Google Ads', 'India', 'freelancer');

INSERT INTO kyc_events VALUES
(1,  '2024-01-06', '2024-01-08', NULL),
(2,  '2024-01-08', '2024-01-10', NULL),
(3,  '2024-01-11', NULL,         'Document unclear'),
(4,  '2024-01-13', '2024-01-15', NULL),
(5,  '2024-01-16', '2024-01-18', NULL),
(6,  '2024-02-02', '2024-02-05', NULL),
(7,  '2024-02-04', NULL,         'Address mismatch'),
(8,  '2024-02-11', '2024-02-13', NULL),
(9,  '2024-02-15', '2024-02-17', NULL),
(10, NULL,          NULL,         NULL),  -- never submitted KYC
(11, '2024-03-02', '2024-03-04', NULL),
(12, '2024-03-06', '2024-03-08', NULL),
(13, NULL,          NULL,         NULL),  -- dropped off immediately
(14, '2024-03-16', '2024-03-18', NULL),
(15, '2024-03-21', NULL,         'PAN mismatch');

INSERT INTO bank_linkage VALUES
(1,  '2024-01-09'),
(2,  '2024-01-11'),
(4,  '2024-01-16'),
(5,  '2024-01-19'),
(6,  '2024-02-06'),
(8,  '2024-02-14'),
(9,  '2024-02-18'),
(11, '2024-03-05'),
(12, '2024-03-09'),
(14, '2024-03-19');

INSERT INTO transactions VALUES
(101, 1,  '2024-01-15', 500.00,  'USD', 'INR'),
(102, 2,  '2024-01-18', 1200.00, 'USD', 'INR'),
(103, 4,  '2024-01-20', 300.00,  'EUR', 'INR'),
(104, 5,  '2024-01-25', 800.00,  'USD', 'INR'),
(105, 6,  '2024-02-10', 450.00,  'USD', 'INR'),
(106, 8,  '2024-02-20', 2000.00, 'USD', 'INR'),
(107, 9,  '2024-02-25', 600.00,  'GBP', 'INR'),
(108, 11, '2024-03-10', 750.00,  'USD', 'INR'),
(109, 12, '2024-03-15', 900.00,  'USD', 'INR');