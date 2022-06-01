create database company_example;
USE company_example;

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

-- Corporate
INSERT INTO employee VALUES (100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL); 	-- Note how super_id and branch_id are left null, this is because we have not inserted into the branch table yet

INSERT INTO branch VALUES (1, 'Corporate', 100, '2006-02-09');


-- Here we are updating the branch_id inside employee table now that we have values in the branch table
UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO employee VALUES (102, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);	-- Note that we can insert branch_id without issues because the branch tables contains values.






