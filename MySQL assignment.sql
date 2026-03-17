CREATE DATABASE IF NOT EXISTS elearning_new;
USE elearning_new;
CREATE TABLE learners (
    learner_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    country VARCHAR(50)
);
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10,2)
);
CREATE TABLE purchases (
    purchase_id INT PRIMARY KEY,
    learner_id INT,
    course_id INT,
    quantity INT,
    purchase_date DATE,
    FOREIGN KEY (learner_id) REFERENCES learners(learner_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
INSERT INTO learners VALUES
(1, 'Arun Kumar', 'India'),
(2, 'John Smith', 'USA'),
(3, 'Priya Sharma', 'India'),
(4, 'Maria Garcia', 'Spain'),
(5, 'Li Wei', 'China');
INSERT INTO courses VALUES
(101, 'Python Basics', 'Programming', 50.00),
(102, 'Data Science', 'Analytics', 100.00),
(103, 'Web Development', 'Programming', 80.00),
(104, 'Digital Marketing', 'Marketing', 60.00),
(105, 'Machine Learning', 'Analytics', 120.00);
INSERT INTO purchases VALUES
(1, 1, 101, 2, '2025-01-10'),
(2, 2, 102, 1, '2025-01-12'),
(3, 3, 103, 1, '2025-01-15'),
(4, 1, 104, 1, '2025-01-18'),
(5, 4, 101, 3, '2025-01-20'),
(6, 5, 105, 2, '2025-01-22'),
(7, 2, 103, 1, '2025-01-25');
SELECT 
    l.full_name,
    c.course_name,
    c.category,
    p.quantity,
    FORMAT(p.quantity * c.unit_price, 2) AS total_amount,
    p.purchase_date
FROM purchases p
INNER JOIN learners l ON p.learner_id = l.learner_id
INNER JOIN courses c ON p.course_id = c.course_id
ORDER BY total_amount DESC;
SELECT 
    l.full_name,
    c.course_name
FROM learners l
LEFT JOIN purchases p ON l.learner_id = p.learner_id
LEFT JOIN courses c ON p.course_id = c.course_id;
SELECT 
    c.course_name,
    l.full_name
FROM learners l
RIGHT JOIN purchases p ON l.learner_id = p.learner_id
RIGHT JOIN courses c ON p.course_id = c.course_id;
SELECT 
    l.full_name,
    l.country,
    FORMAT(SUM(p.quantity * c.unit_price), 2) AS total_spent
FROM purchases p
JOIN learners l ON p.learner_id = l.learner_id
JOIN courses c ON p.course_id = c.course_id
GROUP BY l.full_name, l.country
ORDER BY total_spent DESC;
SELECT 
    c.course_name,
    SUM(p.quantity) AS total_quantity
FROM purchases p
JOIN courses c ON p.course_id = c.course_id
GROUP BY c.course_name
ORDER BY total_quantity DESC
LIMIT 3;
SELECT 
    c.category,
    FORMAT(SUM(p.quantity * c.unit_price), 2) AS total_revenue,
    COUNT(DISTINCT p.learner_id) AS unique_learners
FROM purchases p
JOIN courses c ON p.course_id = c.course_id
GROUP BY c.category;
SELECT 
    l.full_name,
    COUNT(DISTINCT c.category) AS category_count
FROM purchases p
JOIN learners l ON p.learner_id = l.learner_id
JOIN courses c ON p.course_id = c.course_id
GROUP BY l.full_name
HAVING category_count > 1;
SELECT 
    c.course_name
FROM courses c
LEFT JOIN purchases p ON c.course_id = p.course_id
WHERE p.purchase_id IS NULL;