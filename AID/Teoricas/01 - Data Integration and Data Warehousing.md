# Data Integration

Provide a unified, real-time view of data from multiple sources. No permanent central repository, integration happens on demand. Focuses on virtual integration rather than physical storage. Useful for real-time analysis and reporting across multiple systems.

Process:
1. Define a mediated schema that represents a common view of all sources.
2. Create schema mappings between each data source (or its wrapper) and the mediated schema.
3. Users write queries over the mediated schema.
4. The system performs query unfolding, reformulating the query into source-specific queries.

![Data Integration](Imagens/01%20-%20Data%20Integration.png)

Advantages:
- Fast.
- Can query over time.
- Does not rely on the availability of the sources.

# Data Warehousing

Provide a centralized repository of cleaned and transformed data for long-term analysis. Data is physically stored in a central repository. Optimized for historical analysis, trend detection, and business intelligence. ETL processes run regularly to keep warehouse up-to-date.

Process:
1. Extract data from operational systems, or external APIs/services.
2. Store it temporarily in a staging area. This is important because it may happen the case where operational systems are external API's or other services that are not active at all times.
3. Transform and integrate the data using ETL tools.
4. Load into a data warehouse with its own schema, different from source schemas.
5. Optionally split into data marts for specific analysis goals, if the data warehouse is too big.
6. Query data marts/warehouse for exploration, mining, and reporting.

![Data Warehousing](Imagens/01%20-%20Data%20Warehousing.png)

### Data Integration vs Data Warehousing

- Data Integration = Virtual, query-driven, real-time access to multiple sources.
- Data Warehousing = Physical, storage-driven, structured repository for historical analysis.

![Data Integration vs Data Warehousing](Imagens/01%20-%20Data%20Integration%20vs%20Data%20Warehousing.png)

Advantages:
- Real-time data
- Doesn't take space