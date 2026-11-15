/*
PROJECT: SaaS Revenue & Customer Retention Analysis
AUTHOR: Yofran Lizcano
DATABASE: saas_analytics
SCHEMA: raw

PURPOSE:
Initial data quality assessment.

OBJECTIVES:
1. Check missing values in critical columns.
2. Validate data completeness.
3. Identify potential data quality issues.
*/


-- 01. ROW COUNT VALIDATION
-- Purpose: Verify the number of imported records

SELECT 'accounts' AS table_name, COUNT(*) AS total_records
FROM raw.accounts

UNION ALL

SELECT 'users', COUNT(*)
FROM raw.users

UNION ALL

SELECT 'subscriptions', COUNT(*)
FROM raw.subscriptions

UNION ALL

SELECT 'invoices', COUNT(*)
FROM raw.invoices

UNION ALL

SELECT 'support_tickets', COUNT(*)
FROM raw.support_tickets;


-- 02. NULL VALUE AUDIT
-- Purpose: Identify missing values in critical columns

SELECT
    'accounts' AS table_name,
    COUNT(*) AS total_records,
    COUNT(*) FILTER (WHERE account_id IS NULL) AS null_account_ids,
    COUNT(*) FILTER (WHERE signup_date IS NULL) AS null_signup_dates,
    COUNT(*) FILTER (WHERE plan IS NULL) AS null_plans
FROM raw.accounts

UNION ALL

SELECT
    'subscriptions',
    COUNT(*),
    COUNT(*) FILTER (WHERE subscription_id IS NULL),
    COUNT(*) FILTER (WHERE status IS NULL),
    COUNT(*) FILTER (WHERE mrr IS NULL)
FROM raw.subscriptions

UNION ALL

SELECT
    'invoices',
    COUNT(*),
    COUNT(*) FILTER (WHERE invoice_id IS NULL),
    COUNT(*) FILTER (WHERE invoice_date IS NULL),
    COUNT(*) FILTER (WHERE amount IS NULL)
FROM raw.invoices

UNION ALL

SELECT
    'support_tickets',
    COUNT(*),
    COUNT(*) FILTER (WHERE ticket_id IS NULL),
    COUNT(*) FILTER (WHERE priority IS NULL),
    COUNT(*) FILTER (WHERE category IS NULL)
FROM raw.support_tickets;