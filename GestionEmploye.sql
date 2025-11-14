CREATE TABLE team (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE employee (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name Varchar(50),
    contract_type VARCHAR(20),
    salary INT,
    team_id INT REFERENCES team(id)
);

CREATE TABLE leave_table (
    id SERIAL PRIMARY KEY,
    start_date Date,
    end_date Date
    employee_id INT REFERENCES employee(id)
);

INSERT INTO team (name) VALUES
('Informatique'),
('Marketing'),
('Designer');

INSERT INTO employee (first_name, last_name, contract_type, salary, team_id) VALUES
('john', 'doe', 'CDI', 3000, 1),
('miya', 'taylor', 'CDD', 2500, 2),
('hanabi', 'suzuki', 'stage', 900, 3);
('layla', 'brown', 'satge', 950, NULL);

INSERT INTO leave_table (start_date, end_date, employee_id) VALUES
('2024-07-01', '2024-07-10', 1),
('2024-08-15', '2024-08-20', 2);
('2024-09-05', '2024-09-12', 1);

-- Afficher l’id, first_name, last_name des employés qui n’ont pas d’équipe --
SELECT id, first_name, last_name
FROM employee
WHERE salary > 2000;

-- Afficher l’id, first_name, last_name des employés qui n’ont jamais pris de congé de leur vie --
SELECT employee.id, employee.first_name, employee.last_name
FROM employee
LEFT JOIN leave_table ON employee.id = leave_table.employee_id
WHERE leave_table.id IS NULL;

-- Afficher les congés de tel sorte qu’on voie l’id du congé, le début du congé, la fin du congé, le nom & prénom de l’employé qui prend congé et le nom de son équipe --
SELECT 
    leave_table.id AS leave_id,
    leave_table.start_date,
    leave_table.end_date,
    employee.first_name,
    employee.last_name,
    team.name As team_name
FROM leave_table
JOIN employee ON leave_table.employee_id = employee.id
LEFT JOIN team ON employee.team_id = team.id;

-- Affichez par le nombre d’employés par contract_type, vous devez afficher le type de contrat, et le nombre d’employés associés --
SELECT
    contract_type,
    COUNT(*) AS number_of_employees
FROM employee
GROUP BY contract_types;

-- Afficher le nombre d’employés en congé aujourd'hui. La période de congé s'étend de start_date inclus jusqu’à end_date inclus --
SELECT 
    COUNT(*) AS number_of_employees
FROM leave_table
WHERE CURRENT_DATE BETWEEN start_date AND end_date;

-- Afficher l’id, le nom, le prénom de tous les employés + le nom de leur équipe qui sont en congé aujourd’hui. Pour rappel, la end_date est incluse dans le congé, l’employé ne revient que le lendemain --
SELECT
    employee.id,
    employee.first_name,
    employee.last_name,
    team.name AS team_name
FROM employee
JOIN leave_table ON employee.id = leave.employee_id
LEFT JOIN team ON employee.team_id = team.id
WHERE CURRENT_DATE BETWEEN leave_table.start_date AND leave_table.end_date;
