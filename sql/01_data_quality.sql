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

-- =====================================================
-- 01. ROW COUNT VALIDATION
-- Purpose: Verify the number of imported records
-- =====================================================

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

-- =====================================================
-- 02. NULL VALUE AUDIT
-- Purpose: Identify missing values in critical columns
-- =====================================================

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

-- =====================================================
-- 03. DUPLICATE CHECKS
-- Purpose: Intentify that the IDs are unique.
-- =====================================================

SELECT 
	ac.account_id,
	COUNT(*) AS total_duplicates
FROM raw.accounts AS ac
GROUP BY ac.account_id
HAVING COUNT(*) > 1;


SELECT
    us.user_id,
    COUNT(*) AS total_duplicates
FROM raw.users AS us
GROUP BY us.user_id
HAVING COUNT(*) > 1;

SELECT 
    sub.subscription_id,
    COUNT (*) AS total_duplicates
FROM raw.subscriptions AS sub
GROUP BY sub.subscription_id
HAVING COUNT(*) > 1;


SELECT
    inv.invoice_id,
    COUNT(*) AS total_duplicates
FROM raw.invoices AS inv
GROUP BY inv.invoice_id
HAVING COUNT(*) > 1;


SELECT
    sup.ticket_id,
    COUNT(*) AS total_duplicates
FROM raw.support_tickets AS sup
GROUP BY sup.ticket_id
HAVING COUNT(*) > 1;

-- =====================================================
-- 04. REFERENTIAL INTEGRITY CHECKS
-- Purpose: Identify orphan records
-- =====================================================

-- 04.1 USER -> ACCOUNTS

SELECT
    us.user_id,
    us.account_id
FROM raw.users AS us
LEFT JOIN raw.accounts AS ac 
    ON us.account_id = ac.account_id
WHERE ac.account_id IS NULL;

-- 04.2 SUBSCRIPTIONS -> ACCOUNTS

SELECT
    sub.subscription_id,
    sub.account_id
FROM raw.subscriptions AS sub
LEFT JOIN raw.accounts AS ac 
    ON ac.account_id = sub.account_id
WHERE ac.account_id IS NULL;

-- 04.3 INVOICES -> ACCOUNTS

SELECT
    inv.invoice_id,
    inv.account_id
FROM raw.invoices AS inv
LEFT JOIN raw.accounts AS ac 
    ON ac.account_id = inv.account_id
WHERE ac.account_id IS NULL;

-- 04.4 SUPPORT_TICKETS -> ACCOUNTS

SELECT
    sup.ticket_id,
    sup.account_id
FROM raw.support_tickets AS sup
LEFT JOIN raw.accounts AS ac 
    ON ac.account_id = sup.account_id
WHERE ac.account_id IS NULL;

/*
DATA QUALITY ASSESSMENT - INITIAL CONCLUSIONS

1. Row counts:
   All five tables contain the expected number of records.

2. Null values:
   No missing values were found in the audited columns.

3. Duplicate checks:
   No duplicate primary identifiers were found.

4. Referential integrity:
   No orphan records were found in the four tested relationships.

OVERALL RESULT:
   All initial data quality checks passed.

NOTE:
   These checks do not guarantee that every business rule
   or every data quality dimension has been validated.
*/