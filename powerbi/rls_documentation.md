# Row-Level Security (RLS) Documentation

## Overview

Row-Level Security (RLS) was implemented in the Power BI report to restrict data access based on customer country.

The purpose is to demonstrate how regional managers can view customer and marketing performance data for their assigned regions without accessing data from other countries.

## Roles Created

Two static RLS roles were created in Power BI Desktop.

### 1. India Regional Manager

**Role Name:** `India_Regional_Manager`

**Table:** `Customers`

**DAX Filter:**

```dax
Customers[country] = "India"
```
This role restricts report data to customers from India.


### 2. Spain Regional Manager

**Role Name:** `Spain_Regional_Manager`

**Table:** `Customers`

**DAX Filter:**

```dax
Customers[country] = "Spain"
```
This role restricts report data to customers from Spain.


## RLS Testing and Validation

Both roles were tested using the View As feature in Power BI Desktop.

| Test | Expected Customers | Actual Result |
|---|---:|---|
| India Regional Manager | 148 | Passed |
| Spain Regional Manager | 1,095 | Passed |

The report visuals and KPI cards updated according to the selected regional role.

## Implementation Summary

- Created two static country-based security roles.
- Applied DAX filters to the Customers table.
- Verified that the filters affected report KPIs and visuals.
- Tested both roles independently using View As.
- Confirmed that the unrestricted report could be restored.

## Limitations

- The implementation uses static country-based roles.
- Dynamic security using individual user email addresses has not been implemented.
- In Power BI Service, users must be assigned to the appropriate roles for role-based access to work.
