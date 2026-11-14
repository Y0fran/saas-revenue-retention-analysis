# Data Documentation

## Dataset Source

**Dataset:** B2B SaaS Subscription Analytics

**Provider:** Misata Studio

**Source:** https://www.misata.studio/datasets/saas-subscription-analytics

**License:** CC0 1.0 Universal (Public Domain)

## Dataset Description

This project uses a synthetic dataset representing a fictional B2B SaaS company.

The dataset contains information about customer accounts, users, subscriptions, invoices, and support tickets.

The data is fictional and does not represent actual customers or business transactions.

## Source Files

| File | Description |
|---|---|
| accounts.csv | Customer account information |
| users.csv | Users associated with customer accounts |
| subscriptions.csv | Subscription details and recurring revenue |
| invoices.csv | Customer billing records |
| support_tickets.csv | Customer support interactions |

## Database Tables

The source CSV files are imported into PostgreSQL under the `raw` schema.

| Table | Expected Records |
|---|---:|
| accounts | 1,200 |
| users | 25,002 |
| subscriptions | 1,200 |
| invoices | 7,892 |
| support_tickets | 6,946 |

## Data Handling

- Original CSV files are not tracked in this repository.
- Data is imported into PostgreSQL for analysis.
- The original source data is preserved without intentional modifications.
- SQL queries and analytical transformations are documented separately.

## Notes

The dataset is used exclusively for educational, analytical, and portfolio purposes.