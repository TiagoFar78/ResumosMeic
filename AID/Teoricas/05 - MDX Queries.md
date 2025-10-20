# MDX Queries

MDX Queries are queries applied to a OLAP Cube. You select what members are going to be displayed in each axis.

```SQL
SELECT [Measures].Members ON COLUMNS,
       [Customer].[Country].Members ON ROWS
FROM [Orders]
```

![Basic](Imagens/05%20-%20Basic.png)

## Slicing

Show all measures by year for customers in Italy or France who bought Classic Cars.

```SQL
SELECT Measures.Members ON COLUMNS,
       Time.Year.Members ON ROWS
FROM Orders
WHERE {(Customer.Country.Italy, Product.[Product Line].[Classic Cars]),
       (Customer.Country.France, Product.[Product Line].[Classic Cars])}
```

![Slicing](Imagens/05%20-%20Slicing.png)

The slicing is done with WHERE clause we use `()` to represent `and` operation and `{}` to represent `or` operation.

## Navigation

### Children

Sales by quarter of 2003 in German and Italian cities

```SQL
SELECT Time.[2003].CHILDREN ON COLUMNS,
       {Customer.Country.Germany.CHILDREN, Customer.Country.Italy.CHILDREN} ON ROWS
FROM Orders
WHERE Measures.Sales
```

![Children](Imagens/05%20-%20Navigation%20Children.png)

### Drilldown Level

Sales by quarter of 2003 in German and Italian cities, with country too.

```SQL
SELECT Time.[2003].CHILDREN ON COLUMNS,
       {DRILLDOWNLEVEL(Customer.Country.Germany), DRILLDOWNLEVEL(Customer.Country.Italy)} ON ROWS
FROM Orders
WHERE Measures.Sales
```

![Drilldown level](Imagens/05%20-%20Navigation%20Drilldown%20level.png)

### Descendants

```SQL
SELECT Time.[2003].CHILDREN ON COLUMNS,
       DESCENDANTS(Customer.Italy, Customer.City, SELF) ON ROWS
FROM Orders
WHERE Measures.Sales
```

![Descendants](Imagens/05%20-%20Navigation%20descendants.png)

Third argument specifies which level to include in the results. It can be:
- SELF
- BEFORE
- AFTER
- SELF_AND_BEFORE
- AFTER
- SELF_AND_AFTER
- BEFORE_AND_AFTER
- SELF_BEFORE_AFTER

### Ascendants

```SQL
SELECT Time.[2003].CHILDREN ON COLUMNS,
       ASCENDANTS(Customer.City.Milan) ON ROWS
FROM Orders
WHERE Measures.Sales
```

![Ascendants](Imagens/05%20-%20Navigation%20ascendants.png)

### Ancestor

```SQL
SELECT Time.[2003].CHILDREN ON COLUMNS,
       ANCESTOR(Customer.City.Milan, Customer.Country) ON ROWS
FROM Orders
WHERE Measures.Sales
```

![Ancestor](Imagens/05%20-%20Navigation%20ancestor.png)

## Cross Join

```SQL
SELECT Product.[Product Line].Members ON COLUMNS,
       CROSSJOIN(Customer.Country.Members, Time.Year.Members) ON ROWS
FROM Orders
WHERE Measures.Sales 
```

OR

```SQL
SELECT Product.[Product Line].Members ON COLUMNS,
       Customer.Country.Members * Time.Year.Members ON ROWS
FROM Orders
WHERE Measures.Sales
```

![Cross Join](Imagens/05%20-%20Cross%20Join.png)

## Calculated Members

Define new member or measure inside the query.

```SQL
WITH MEMBER Product.Cars AS 
       Product.[Product Line].[Classic Cars] + Product.[Product Line].[Vintage Cars]
SELECT Time.Year.Members ON COLUMNS,
       Product.Cars ON ROWS
FROM Orders
WHERE Measures.Sales
```

![Calculated Members](Imagens/05%20-%20Calculated%20Members.png)

## Named Sets

Define an alias for a set of members.

```SQL
WITH SET TopCountries AS
       TOPCOUNT(Customer.Country.Members, 3, Measures.Sales)
SELECT Measures.Members ON COLUMNS,
       TopCountries ON ROWS
FROM Orders
```

![Named Sets](Imagens/05%20-%20Named%20Sets.png)

## Relative Navigation

Define new measure based on relative navigation.

```SQL
WITH MEMBER Measures.[Previous Month] AS Time.Month.CurrentMember.PrevMember 
     MEMBER Measures.[Sales Growth] AS Measures.Sales - Measures.[Previous Month]
SELECT {Measures.Sales, Measures.[Previous Month], Measures.[Sales Growth]} ON COLUMNS,
       DESCENDANTS(Time.Year.[2004], Time.Month) ON ROWS
FROM Orders
```

![Relative Navigation](Imagens/05%20-%20Relative%20Navigation.png)

## Filtering

Filter members based on condition.

```SQL
SELECT Measures.Members ON COLUMNS,
       FILTER(Customer.Country.Members, Measures.Sales > 1000000) ON ROWS
FROM Orders
```

![Filtering](Imagens/05%20-%20Filtering.png)

## Sorting

```SQL
SELECT Measures.Members ON COLUMNS,
       ORDER(Customer.Country.Members, Measures.Sales, DESC) ON ROWS
FROM Orders
```

![Sorting](Imagens/05%20-%20Sorting.png)

## Top analysis

Top 3 countries by sales.

```SQL
SELECT Measures.Members ON COLUMNS,
       HEAD(ORDER(Customer.Country.Members, Measures.Sales, DESC), 3) ON ROWS
FROM Orders
```

OR 

```SQL
SELECT Measures.Members ON COLUMNS,
       TOPCOUNT(Customer.Country.Members, 3, Measures.Sales) ON ROWS
FROM Orders
```

![Top analysis](Imagens/05%20-%20top%20analysis.png)
