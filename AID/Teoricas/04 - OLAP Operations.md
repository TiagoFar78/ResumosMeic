# OLAP Cubes & Information Visualisation

## 2D Matrix Representation

Consider a collection of measurements dependent on dimensions:
- Measurements: Sales
- Dimensions: Supplier Key (SK), Product Key (PK), Location (LOC), e Date (DATE)

| SK | PK | QTY |
| -- | -- | --- |
| S1 | P1 | 300 |
| S1 | P2 | 200 |
| S2 | P1 | 300 |
| S2 | P2 | 400 |
| S2 | P2 | 200 |
| S4 | P2 | 200 |

Applying sum aggregation function:

|   | P1 | P2 |
| - | -- | -- |
| S1 | 300 | 200 |
| S2 | 300 | 600 |
| S4 | NULL | 200 |

## 3D Cube Representation

![3D Cube Representation](Imagens/04%20-%203D%20Cube%20Representation.png)

## nD Hypercube Representation

![nD Hypercube Representation](Imagens/04%20-%20nD%20Cube%20Representation.png)

# Multidimensional model

Data can be viewed as a cube.

![Cube data](Imagens/04%20-%20Cube%20data.png)

## OLAP Operations

### Roll-up

- Increase the level of aggregation.
- Aggregates the fact values one further level on one or more of the dimensions.
- Equivalent to doing GROUP BY dimension by using attribute hierarchy.

![Roll-up](Imagens/04%20-%20Roll-up.png)

### Drill-down

- Decreases the level of aggregation, i.e., increases the detail along one or more dimension hierarchies.
- Aggregates data at a lower level of granularity dimension hierarchy, thereby viewing data in a more specialised level within a dimension.
- Opposite of Roll-up.

![Drill-down](Imagens/04%20-%20Drill-down.png)

### Slice

- Projects one or more dimensions of the given cube, resulting in a sub-cube along given dimensions.
- Reduces the dimensionality of the cubes.

![Slice](Imagens/04%20-%20Slice.png)

### Dice

- Selects a sub-cube by performing by constraining the range of values over one or more dimensions.
- Reduces the number of member values of one or more dimensions.

![Dice](Imagens/04%20-%20Dice.png)

### Pivot

- Rotates the data axes to view the data from different perspectives.
- Re-orienting the multidimensional view of data.

![Pivot](Imagens/04%20-%20Pivot.png)

### Drill-across

- Puts together two cubes with similar axis but different information.

![Drill-across](Imagens/04%20-%20Drill-across.png)

## Cube definition

Cube definition in an XML file and can be created manually. However, it is better to use tools like Pentaho Schema Workbench.
