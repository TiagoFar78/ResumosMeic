# Schema Mapping

1. Identify the multiple data sources with different schemas.
2. Make Schema matching between data sources, checking how attributes in one data source correspond to attributes in another data source.
3. Design a common mediated schema that will be a subset of attributes from data source schemas.
4. Use wrappers for data sources to facilitate and simplify access to data sources.
5. Execute queries to bring data from local schema to global mediated schema.
6. Find exact/approximate duplicates from different sources that may need to be merged, converted or consolidated.

# Data Profiling

In data profiling we gather statistics about the data. For example: minimum, maximum, average, range, value distribution, etc. And we identify data quality problems such as missing or incomplete data, errors, inconsistencies, etc.

It is also used to understand the logic and relationships between data like unique values, keys, foreign keys and other constraints.

These tasks are instances of data profiling:
- number of rows, number of null values, number of distinct values
- minimum value, maximum value, minimum length, maximum length
- single and multi-column frequency histogram
- precision of numeric values, length of string values
- discovery of data types
- uniqueness and constancy
- single and multi-column primary key discovery
- single and multi-column foreign key discovery
- value overlap (cross-domain analysis)
- text field profiling
- pattern discovery (e.g. phone number patterns)
- soundex frequency histogram

# Data Privacy

Privacy: The right to control personal information and to be free from unwarranted intrusion.

Data privacy, or Information privacy: Refers to the ability of an organization or individual to control what data is collected, used, and disclosed.

Data protection is the implementation of measures to safeguard data against unauthorized access, corruption, or loss of data.

Technical measures include firewalls, data loss prevention, encryption and backups.

## CIA Triad

- Confidentiality - No unauthorised access.
- Integrity - No unauthorised changes.
  - Authenticity - No falsification of content or authorship.
  - Non-Repudiation - Undeniability of authorship or participation.
- Availability - No unauthorised denial of service.

CIA is enough to ensure Data Protection but insufficient on its own to ensure Data Privacy because data privacy also involves notions of consent, transparency, purpose limitation and individuals rights.
