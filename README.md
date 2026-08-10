# Salesforce-Inventory-Order-Management


# Salesforce Inventory & Order Management System

## Project Overview

The Salesforce Inventory & Order Management System is a Salesforce-based application developed to manage products, inventory availability, customer orders, and order processing.

The system automates inventory management by checking product availability when an Order Item is created. If sufficient stock is available, the system automatically reduces the inventory quantity. If stock is insufficient, the Order Item is prevented from being created.

A Record-Triggered Flow is also used to automatically maintain the inventory status based on available quantity and reorder level.

## Key Features

- Product and inventory management
- Customer order management
- Order Item management
- Automatic stock availability validation
- Automatic inventory quantity reduction
- Insufficient stock error handling
- Inventory status automation
- Reorder level monitoring
- Reports and dashboards for inventory and sales analysis

## Salesforce Technologies Used

- Salesforce Custom Objects
- Apex Trigger
- Apex Trigger Handler
- SOQL
- Record-Triggered Flow
- Custom Fields
- Reports
- Dashboards
- Lookup Relationships
- Salesforce Data Model

## Automation

### Apex Trigger

When a new Order Item is created:

1. Product information is retrieved.
2. Related Inventory is identified.
3. Available quantity is checked.
4. If stock is insufficient, an error is displayed.
5. If stock is sufficient, inventory quantity is reduced.
6. Inventory is updated.

### Flow Automation

A Record-Triggered Flow runs when an Inventory record is created or updated.

The Flow checks:

```text
Available Quantity
        ↓
Compare with Reorder Level
        ↓
---------------------------
|            |             |
0        <= Reorder      > Reorder
|            |             |
↓            ↓             ↓
Out of      Low          In Stock
Stock       Stock
