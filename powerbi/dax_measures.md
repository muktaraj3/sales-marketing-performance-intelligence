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

