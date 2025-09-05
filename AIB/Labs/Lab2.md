# 50.
## a)

```SQL
use employees;

select dept_name 
from departments;
```

OR

```SQL
select dept_name 
from employees.departments;
```

## b)

```SQL
use company;

select departmentname 
from department
order by departmentname asc;
```

OR

```SQL
select departmentname 
from company.department
order by departmentname asc;
```

## c)

```SQL
use company;

select dept_name 
from all_departments
order by dept_name asc;
```

OR

```SQL
select dept_name 
from company.all_departments
order by dept_name asc;
```

# 52.

## a)

```SQL
use employees;

select distinct title
from titles
order by title asc;
```

OR

```SQL
select distinct title
from employees.titles
order by title asc;
```

## b)

```SQL
use company;

select distinct jobtitle
from employees
order by jobtitle asc;
```

OR

```SQL
select distinct jobtitle
from company.employees
order by jobtitle asc;
```

## c)

```SQL
use company;

select distinct title
from all_titles
order by title asc;
```

OR

```SQL
select distinct title
from company.all_titles
order by title asc;
```
