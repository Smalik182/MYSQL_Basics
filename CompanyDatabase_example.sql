create database company_example;
USE company_example;

SELECT * FROM employee;
-- Here we are creating the initial employee table
CREATE TABLE employee (
	emp_id INT PRIMARY KEY,
    first_name VARCHAR(40),
    last_name VARCHAR(40),
    birth_date DATE,
    sex VARCHAR(1),
    salary INT,
    super_id INT,
    branch_id INT
);

-- Here we are creating the Branch Table
--  FOREIGN keyword points to another table to the specified location
CREATE TABLE branch (
	branch_id INT PRIMARY KEY,
    branch_name VARCHAR(40),
    mgr_id INT,
    mgr_start_date DATE,
    FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

-- We need to set the super_id and branch_id as forgien keys so we need to ALTER the employee table
ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

-- Here we are creating the Client table
CREATE TABLE client(
	client_id INT PRIMARY KEY,
    client_name VARCHAR(40),
    branch_id INT,
    FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

-- Here we are creating the works with table, note that we can have multiple PRIMARY KEYS in a table
CREATE TABLE works_with(
	emp_id INT,
    client_id INT,
    total_sales INT,
    PRIMARY KEY (emp_id, client_id),
    FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
    FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

-- Here we are creating the Branch Supplier table, note that again it has 2 primary keys
CREATE TABLE branch_supplier(
	branch_id INT,
    supplier_name VARCHAR(40),
    supply_type VARCHAR(40),
    PRIMARY KEY (branch_id, supplier_name),
    FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);


-- Now we can start to populate the tables 
-- For orginization sake, we will populate the tables by branch.

-- Corporate
INSERT INTO employee VALUES (100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL); 	-- Note how super_id and branch_id are left null, this is because we have not inserted into the branch table yet

INSERT INTO branch VALUES (1, 'Corporate', 100, '2006-02-09');


-- Here we are updating the branch_id inside employee table now that we have values in the branch table
UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;


INSERT INTO employee VALUES (101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);	-- Note that we can insert branch_id without issues because the branch tables contains values.


-- Scranton Branch
INSERT INTO employee VALUES (102, 'Micheal', 'Scott', '1964-03-15', 'M', 75000, NULL, NULL);

INSERT INTO branch VALUES (2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES (103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES (104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 63000, 102, 2);
INSERT INTO employee VALUES (105, 'Stanley', 'Hudson', '1958-02-19', 'M', 66000, 102, 2);

-- Stanford Branch

INSERT INTO employee VALUES (106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, NULL, NULL);

INSERT INTO branch VALUES (3, 'Stanford', 106, '1998-02-13'); 

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES (107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES (108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

-- Here we populate the branch supplier table
INSERT INTO branch_supplier VALUES (2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES (2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES (3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES (2, 'J.T. Forms & Labels', 'Custon Forms');
INSERT INTO branch_supplier VALUES (3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES (3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES (3, 'Stamford Labels', 'Custon Forms');

-- Here we populate the client table
INSERT INTO client VALUES (400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES (401, 'Lackawana County', 2);
INSERT INTO client VALUES (402, 'Fedex', 3);
INSERT INTO client VALUES (403, 'John Day Law LLC', 3);
INSERT INTO client VALUES (404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES (405, 'Times Newspaper', 3);
INSERT INTO client VALUES (406, 'Fedex', 2);

-- Here we populate the works with table
INSERT INTO works_with Values (105,400, 55000);
INSERT INTO works_with Values (102,401, 267000);
INSERT INTO works_with Values (108,402, 22500);
INSERT INTO works_with Values (107,403, 5000);
INSERT INTO works_with Values (108,403, 12000);
INSERT INTO works_with Values (105,404, 33000);
INSERT INTO works_with Values (107,405, 26000);
INSERT INTO works_with Values (102,406, 15000);
INSERT INTO works_with Values (105,406, 130000);


-- Here we can check all the tables
SELECT * FROM employee;
SELECT * FROM branch;
SELECT * FROM client;
SELECT * FROM works_with;
SELECT * FROM branch_supplier;


-- Basic Queries


-- Find all employees
SELECT *
FROM employee;

-- Fin all clients
SELECT *
FROM client;

-- Find all employees ordered by salary
SELECT * 
FROM  employee
ORDER BY salary DESC;

-- Find all employees ordered by sex and then name
SELECT *
FROM employee
ORDER BY sex, first_name, last_name;

-- Find the first 5 employees within the table
SELECT *
FROM employee
WHERE emp_id < 105;























