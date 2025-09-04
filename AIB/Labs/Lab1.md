# 35.

```SQL
select d.dept_no, d.dept_name, sum(s.salary) as sum_salary
from departments as d, dept_emp as de, salaries as s
where d.dept_no = de.dept_no and de.emp_no = s.emp_no and 
	de.from_date <= current_date and de.to_date >= current_date and
	s.from_date <= current_date and s.to_date >= current_date
group by d.dept_no, d.dept_name
order by sum_salary desc;
```