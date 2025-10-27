# Views

A view is a virtual table defined through a query. It associates a name to a SELECT statement. Views do not have storage, they are computed, and their contents will change if the tables involved in the query change.

Views map data from tables in the physical model to a new logical model.

## Logical Independence

Security: Views can partition a table horizontally or vertically and give applications the illusion that they are dealing with distinct tables.

## Views over views

It is possible to define local views as wrappers over data sources. A mediated schema can be defined based on a set of global views over local views. Views over views simplify the definition of global views, and also provide an abstraction layer over data source schemas.

## View expansion / unfolding

View expansion is the process of replacing and expanding a query with the definitions of the views used in that query. This process can be repeated until the original query is fully expanded into a query that no longer refers to views.
