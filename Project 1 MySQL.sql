use classicmodels;

-- How many employees have the firstname Leslie
select * from employees;
select count(*) from employees
where firstname = 'Leslie';

-- Which employee has the highest counts of people reporting to him or her, the employee’s name and count of reporters
select * from employees;
select max(reportsTo) maxReports from employees;
select lastName, firstName, max(reportsTo) from employees
group by lastName, firstName
order by max(reportsTo) DESC
LIMIT 1;
 
select * from employees;
select a.lastname, a.firstname, b.reporter from
(select employeenumber, lastname, firstname from employees) a,
(select reportsto,count(reportsto) reporter from employees
group by reportsto
order by count(reportsto) desc
limit 2)b
where a.employeenumber = b.reportsto;


SELECT e.employeeNumber, CONCAT(e.firstName, ' ', e.lastName) AS employeeName, COUNT(r.employeeNumber) AS numberOfReporters
FROM employees e
LEFT JOIN employees r ON e.employeeNumber = r.reportsTo
GROUP BY e.employeeNumber, e.firstName, e.lastName
ORDER BY numberOfReporters DESC
LIMIT 2;



-- Write a script that shows all employees with officeCode 6 and 5
SELECT * from employees
where officeCode IN (6, 5);

-- From the "customers" table, return results for any eight (8) customers out of all the records.
select * from customers
limit 8;

--  Which checknumber has the least payment amount and what is the payment date
select * from payments;
SELECT checknumber, paymentDate from payments
order by amount ASC limit 1;

select * from payments
order by amount asc
limit 1;

-- 05/08/2023
-- between operator
-- example 1 get the list of customers with creditlimit between 20000-70000
select * from customers 
where creditlimit between 20000 and 70000; -- m1

select * from customers
where creditlimit >= 20000 and creditlimit <=72000;
