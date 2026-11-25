# Power BI – DAX Measures & Calculated Columns

## Overview

This document describes the DAX measures and calculated columns developed for the Sales & Marketing Performance Intelligence project.

The Power BI report uses two tables:

- `Customers` – customer demographics, household composition, income and country information.
- `Marketing Performance` – customer spending, purchase activity, campaign acceptance and response data.

The DAX calculations support five report pages:

1. Executive Overview
2. Customer Intelligence & Segmentation
3. Campaign Effectiveness & Purchase Behaviour
4. Strategic Insights & Recommendations
5. Strategic Recommendations

## Calculation Categories

The DAX calculations are organised into:

- KPI measures
- Spending and product category measures
- Customer segmentation calculated columns
- Campaign performance measures
- Purchase behaviour measures
- Recency analysis

## 1. KPI Measures

### Total Customers

```dax
Total Customers =
DISTINCTCOUNT(Customers[customer_id])
```

### Total Customer Spending
```dax
Total Customer Spending =
SUMX(
    'Marketing Performance',
    'Marketing Performance'[wine_spending] +
    'Marketing Performance'[fruit_spending] +
    'Marketing Performance'[meat_spending] +
    'Marketing Performance'[fish_spending] +
    'Marketing Performance'[sweet_spending] +
    'Marketing Performance'[gold_spending]
)
```

### Average Customer Spending
``` dax
Average Customer Spending =
DIVIDE(
    [Total Customer Spending],
    [Total Customers],
    0
)
```

### Campaign Responders
```dax
Campaign Responders =
SUM('Marketing Performance'[latest_campaign_response])
```

### Campaign Response Rate
```dax
Campaign Response Rate =
DIVIDE(
    [Campaign Responders],
    [Total Customers],
    0
)
```

## 2. Product Spending Measures

Individual measures were created for each product category.

### Wine Spending
```dax
Wine Spending =
SUM('Marketing Performance'[wine_spending])
```

### Fruit Spending
```dax
Fruit Spending =
SUM('Marketing Performance'[fruit_spending])
```

### Meat Spending
```dax
Meat Spending =
SUM('Marketing Performance'[meat_spending])
```

### Fish Spending
```dax
Fish Spending =
SUM('Marketing Performance'[fish_spending])
```

### Sweet Spending
```dax
Sweet Spending =
SUM('Marketing Performance'[sweet_spending])
```

### Gold Spending
```dax
Gold Spending =
SUM('Marketing Performance'[gold_spending])
```

### Product Categories
```dax
Product Categories =
DATATABLE(
    "Product", STRING,
    {
        {"Wine"},
        {"Meat"},
        {"Gold"},
        {"Fish"},
        {"Sweets"},
        {"Fruits"}
    }
)
```

### Product Category Spending
```dax
Product Category Spending =
SWITCH(
    SELECTEDVALUE('Product Categories'[Product]),
    "Wine", [Wine Spending],
    "Meat", [Meat Spending],
    "Gold", [Gold Spending],
    "Fish", [Fish Spending],
    "Sweets", [Sweet Spending],
    "Fruits", [Fruit Spending]
)
```

## 3. Customer Segmentation

These calculated columns classify customers by total spending, spending quartile, age group, household composition and income segment. Income and income-review fields are brought into the Customers table using RELATED.

```dax
Customer Total Spending =
'Marketing Performance'[wine_spending] +
'Marketing Performance'[fruit_spending] +
'Marketing Performance'[meat_spending] +
'Marketing Performance'[fish_spending] +
'Marketing Performance'[sweet_spending] +
'Marketing Performance'[gold_spending]


Spending Quartile =
VAR CustomerRank =
    RANKX(
        ALL('Marketing Performance'),
        'Marketing Performance'[Customer Total Spending],
        ,
        ASC,
        SKIP
    )
VAR TotalCustomers =
    COUNTROWS(ALL('Marketing Performance'))
RETURN
    "Q" &
    CEILING(
        DIVIDE(CustomerRank * 4, TotalCustomers),
        1
    )


Age Group =
VAR CustomerAge =
    2014 - Customers[birth_year]
RETURN
    SWITCH(
        TRUE(),
        Customers[birth_year_review] = TRUE(), "Review Required",
        CustomerAge < 30, "Under 30",
        CustomerAge < 40, "30–39",
        CustomerAge < 50, "40–49",
        CustomerAge < 60, "50–59",
        "60+"
    )


Household Type =
SWITCH(
    TRUE(),
    Customers[children_home] = 0 &&
    Customers[teenagers_home] = 0, "No Children",
    Customers[children_home] > 0 &&
    Customers[teenagers_home] = 0, "Children Only",
    Customers[children_home] = 0 &&
    Customers[teenagers_home] > 0, "Teenagers Only",
    "Both"
)


Income =
RELATED('Marketing Performance'[income])


Income Review =
RELATED('Marketing Performance'[income_review])


Income Segment =
SWITCH(
    TRUE(),
    ISBLANK(Customers[Income]), "Missing Income",
    Customers[Income Review] = TRUE(), "Review Required",
    Customers[Income] < 30000, "Under 30K",
    Customers[Income] < 60000, "30K-60K",
    Customers[Income] < 90000, "60K-90K",
    "Above 90K"
)
```

## 4. Campaign Performance Measures

These measures calculate latest campaign responses, overall acceptance across the five previous campaigns, and individual campaign acceptance rates. The Campaigns table supports comparison across the five campaigns in a single visual.

```dax
Campaign Responders =
SUM('Marketing Performance'[latest_campaign_response])


Campaign Response Rate =
DIVIDE(
    [Campaign Responders],
    [Total Customers],
    0
)


Previous Campaign Acceptances =
SUM('Marketing Performance'[accepted_campaign_1]) +
SUM('Marketing Performance'[accepted_campaign_2]) +
SUM('Marketing Performance'[accepted_campaign_3]) +
SUM('Marketing Performance'[accepted_campaign_4]) +
SUM('Marketing Performance'[accepted_campaign_5])


Latest Campaign Responders =
SUM('Marketing Performance'[latest_campaign_response])


Previous Campaign Acceptance Rate =
DIVIDE(
    [Previous Campaign Acceptances],
    [Total Customers] * 5,
    0
)


Campaign Acceptance Rate =
VAR SelectedCampaign =
    SELECTEDVALUE(Campaigns[Campaign])
VAR AcceptedCustomers =
    SWITCH(
        SelectedCampaign,
        "Campaign 1", SUM('Marketing Performance'[accepted_campaign_1]),
        "Campaign 2", SUM('Marketing Performance'[accepted_campaign_2]),
        "Campaign 3", SUM('Marketing Performance'[accepted_campaign_3]),
        "Campaign 4", SUM('Marketing Performance'[accepted_campaign_4]),
        "Campaign 5", SUM('Marketing Performance'[accepted_campaign_5])
    )
RETURN
    DIVIDE(AcceptedCustomers, [Total Customers], 0)


Campaigns =
DATATABLE(
    "Campaign", STRING,
    {
        {"Campaign 1"},
        {"Campaign 2"},
        {"Campaign 3"},
        {"Campaign 4"},
        {"Campaign 5"}
    }
)
```

## 5. Purchase Behaviour Measures

These measures compare customer purchase activity across store, web, catalogue and deal purchases. Average purchase counts are used to compare typical customer behaviour across purchase types.

```dax
Total Store Purchases =
SUM('Marketing Performance'[store_purchases])

Total Web Purchases =
SUM('Marketing Performance'[web_purchases])

Total Catalogue Purchases =
SUM('Marketing Performance'[catalog_purchases])

Total Deal Purchases =
SUM('Marketing Performance'[deal_purchases])


Average Store Purchases =
AVERAGE('Marketing Performance'[store_purchases])

Average Web Purchases =
AVERAGE('Marketing Performance'[web_purchases])

Average Catalogue Purchases =
AVERAGE('Marketing Performance'[catalog_purchases])

Average Deal Purchases =
AVERAGE('Marketing Performance'[deal_purchases])


Purchase Types =
DATATABLE(
    "Purchase Type", STRING,
    {
        {"Store"},
        {"Web"},
        {"Catalogue"},
        {"Deals"}
    }
)


Average Purchases by Type =
SWITCH(
    SELECTEDVALUE('Purchase Types'[Purchase Type]),
    "Store", [Average Store Purchases],
    "Web", [Average Web Purchases],
    "Catalogue", [Average Catalogue Purchases],
    "Deals", [Average Deal Purchases]
)
```

## 6. Recency Analysis

This calculated column groups customers according to the number of days since their last purchase. These groups support the analysis of customer spending and latest campaign response rates by recency.

```dax
Recency Group =
SWITCH(
    TRUE(),
    'Marketing Performance'[recency_days] <= 30, "0–30 Days",
    'Marketing Performance'[recency_days] <= 60, "31–60 Days",
    'Marketing Performance'[recency_days] <= 90, "61–90 Days",
    "91–99 Days"
)
```
