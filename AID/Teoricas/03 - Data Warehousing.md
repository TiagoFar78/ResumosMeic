# Data Warehousing

Separate OLTP (Online Transaction Processing) and OLAP (Online Analytical Processing) operations.

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