# Fintech User Funnel Analysis — SQL

## Overview
SQL-based analysis of a cross-border payments platform user funnel,
simulating the journey from signup to first transaction.
Inspired by platforms like Skydo, Wise, and Payoneer.

## Business Problem
Fintech platforms face high drop-off between signup and first 
transaction (activation). This project identifies where users 
drop off and what factors predict activation.

## Funnel Stages Analyzed
Signup → KYC Submitted → KYC Approved → Bank Linked → First Transaction

## Key Analyses
| File | Business Question |
|------|------------------|
| 01_funnel_dropoff.sql | Where exactly are we losing users? |
| 02_cohort_retention.sql | Which signup cohort activates best? |
| 03_kyc_lag_analysis.sql | Does faster KYC = higher activation? |
| 04_acquisition_channel.sql | Which channel brings quality users? |

## Key Findings (Mock Data)
- Overall activation rate: ~60% of signups complete first transaction
- Biggest drop-off: KYC stage (2 users never submitted)
- Referral channel shows highest activation rate
- KYC rejections primarily due to document issues (PAN, address)

## Tools Used
- SQL (PostgreSQL syntax)
- Dataset: Simulated fintech platform data (15 users, 9 transactions)

## How to Run
1. Run `data/create_and_load.sql` first to set up tables
2. Run analysis files in order (01 → 04)
3. Screenshots of outputs in `/outputs` folder
