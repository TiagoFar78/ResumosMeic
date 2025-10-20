# Data Warehousing

Separate OLTP (Online Transaction Processing) and OLAP (Online Analytical Processing) operations.

# OLAP vs OLTP

## OLTP - Online Transactional Processing

- Focus on the operation of a system.
- Large number of short transactions.
- Very fast query response.
- Performance metric is 'Transactions per second'.

Examples:
- create a new order.
- add products to an order.
- change the status of an order.

## OLAP - Online Analytical Processing

- Focus on analysis of historical data.
- Low number of long data load transactions.
- Slow response to very complex queries involve aggregations.
- Performance metric is 'Query response time'.

Examples:
- sales by customer country.
- sales by product line.
- sales by year.

## Design

- Facts define the possible analysis dimensions.
  - customer $c$ bought product $p$ on date $d$ in store $s$ using payment method $m$ through sales representative $e$ (6D) 
- Measures define the quantity being analyzed .
  - For example, in sales it could be quantity sold and sales amount.
- Facts can be grouped by dimensions.
  - For example, by customer (1D) or by customer and time (2D).
- As facts are grouped, their measures are aggregated.
  - For example, sales amount by customer (1D) or sales amount by customer and time (2D).
- Measures are aggregated at a certain level of detail.
- Levels are organized into hierarchies.
  - For example, country, state, city.
- A dimension can have one or more hierarchies.
  - For example, time dimension can have year, month, day.
- Each dimension can have different levels.

## Star squema

Central fact table that has a foreign key to all of its dimension tables and measures.

![Star squema](Imagens/03%20-%20star%20squema.png)

Analytical queries over a star schema:
1. Join fact table with the desired dimension tables.
2. Group by some level of those dimensions.
3. Aggregate some measure in the fact table.

How to build a data warehouse:
- One transformation for each dimension table.
- One transformation for the fact table
- A job that runs all transformations in the correct sequence.

Design:
- Fact table size dominates the database size. Dimension tables have relatively few rows.
- Dimension tables have redundant information, but redundancy is less important that efficiency.
- Update and Delete operations rarely occur.

### Surrgate keys

A data warehouse has its own primary keys that are called surrogate keys or technical keys.
- `ProductNumber` identifies products in the original database.
- `ProductKey` identifies products in the data warehouse.

Surrogate keys replace the original primary keys, called natural or semantic keys. They provide independence from keys in the original data sources and solve inconsistencies between keys from multiple sources.

# Multidimensional Schema Patterns

## Snowflake Schema

Dimension tables are connected to a set of smaller (normalised) dimension tables. Some dimensional hierarchy is normalised into a set of smaller dimensions tables.

![Snowflake Schema](Imagens/03%20-%20Snowflake%20schema.png)

If in a `Product` table with fields `ProductKey`, `ProductNumber`, `CategoryName`, `CategoryDesc` the fields `CategoryName` and `CategoryDesc` are the same for multiple products, replace them by CategoryKey and move them to another table.

## Fact Constellation Schema

Multiple fact tables sharing the same dimension tables.

![Fact Constellation Schema](Imagens/03%20-%20Fact%20Constellation%20Schema.png)

# Hierarchies

## Balanced hierarchy

- All levels are mandatory.
- All branches have the same length.
- A child member belongs to only one parent.

![Balanced Hierarchy](Imagens/03%20-%20Balanced%20Hierarchy.png)

## Unbalanced hierarchy

- Some levels are optional.
- Branches may have different lengths.
- A child member still belongs to only one parent.

![Unbalanced Hierarchy](Imagens/03%20-%20Unbalanced%20Hierarchy.png)

## Recursive hierarchy

- All levels are of the same type.
- Can easily become an unbalanced hierarchy.
- Requires recursive queries to traverse the hierarchy.

![Recursive Hierarchy](image.png)

## Generalized hierarchy

- The same level may have different types. E.g. customers of a bank may be companies (with an industry sector) or individual persons (with a profession).

![Generalized Hierarchy](Imagens/03%20-%20Generalized%20Hierarchy.png)

## Ragged hierarchy

- One or more levels can be skipped.

![Ragged Hierarchy](Imagens/03%20-%20Ragged%20Hierarchy.png)

## Alternative hierarchy

- The same level has alternative aggregation paths.

![Alternative Herarchy](Imagens/03%20-%20Alternative%20Hierarchy.png)

## Non-strict hierarchy

- When member may have several parents. E.g. an employee that works in multiple cities or a week that belongs to two months.

![Non-strict Hierarchy](Imagens/03%20-%20Non-strict%20hierarchy.png)

# Measures

Each measure is associated to an aggregation function that combines several values into a single one. The aggregation takes place whenever we change to a different level in a dimension hierarchy. When defining a measure we must decide the associated aggregation function.

### Additive measures

Facts can be aggregated along all dimensions using addition (sum). E.g. sales amount along customer, product and time.

### Semi-additive measures

Facts can be added along some, but not all dimensions. E.g. inventory level cannot be summed along time.

### Non-additive measures

Facts cannot be added along any dimension. E.g. unit price, exchange rate.

When facing semi-additive or non-additive measures we need to use other forms of aggregation:
- average (e.g. average inventory level over time).
- minimum (e.g. minimum exchange rate over space or time)
- maximum (e.g. maximum unit price over space or time)

# Time and Date Dimension Tables

Typically created separately in the very beginning of data warehouse project. A data warehouse is a historical database so the time dimension is present in almost all DWs. In a data warehouse, time information is stored explicitly in multiple attributes in the time dimension.

Granularity of time dimension depends on use. If we are interested in monthly data only, define the time dimension with granularity of month.

Time dimension may have more than one hierarchy. E.g. fiscal and calendar year.

Time dimension should be populated automatically by a script.

# Population

The population of a data warehouse involves one transformation for each dimension table, one transformation for the fact table and a job that runs all transformations in the correct sequence. 

Each dimension table will be populated with relevant information and a surrogate key. This way we will have a smaller amount of rows in each dimension table than what it is in the original data table.

The facts table should be populated after because its primary key will be a combination of the primary keys of all the dimension tables. Knowing this, the facts table will have the same amount of rows as the original data table. The facts table should also contain the measures.

For example, if we have an original data table with information of houses sold in Portugal like

| sales |
| --------------- |
| transaction_id |
| price |
| date |
| postcode |
| house number |
| city |

Our dimensions and fact table would look like:

| dim_location |
| ------------ |
| location_id |
| postcode |
| house number |
| city |

| dim_time |
| -------- |
| time_id |
| year |
| month |
| month_name |
| day |

| facts_table |
| ----------- |
| location_id |
| time_id |
| price |

# Slowly Changing Dimensions (SCD)

## Types

- Type 0: Retain original - Do not update with new value.
- Type 1: Overwrite old value with new value.
- Type 2: Add row - Store multiple versions of the same product. Add two columns with validity interval (from date, to date).
  - Can also have a variant with a new column called "row status".
- Type 3: Add column - Use additional column for each attribute that might change. The new column is named "new \<field>" and all the records are null except the one that changed. 
- Type 4: Add mini-dimension for frequently changing attributes.
- Type 5: Add mini-dimension along with FK in base dimension.
- Type 6: Add new row with validity interval plus additional column for current value.
- Type 7: Add new row with validity interval plus view with current values by natural key or surrogate key.

Real-world OLAP software and tools typically, provide support for SCDs of Type 1, Type 2, and Type 3.
