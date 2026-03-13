Final Relationship Structure

-- 1️⃣ Create Database
CREATE DATABASE training_db;
USE training_db;

-- 2️⃣ Create Students Table (Add NOT NULL + CHECK)
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    age INT CHECK (age >= 18)
);

-- Try inserting invalid data of age below 18

-- 3️⃣ Insert Valid Students
INSERT INTO students (name,email,age) VALUES
('Arun','arun@gmail.com',21),
('Meena','meena@gmail.com',22),
('Rahul','rahul@gmail.com',23);

-- 4️⃣ Create Courses Table (Add NOT NULL)
CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL
);

INSERT INTO courses (course_name) VALUES
('Python'),
('SQL'),
('JavaScript');

-- 5️⃣ Create Enrollments Table (Add ON DELETE / ON UPDATE)
CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id),

    FOREIGN KEY (student_id)
    REFERENCES students(student_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    FOREIGN KEY (course_id)
    REFERENCES courses(course_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

-- 6️⃣ Insert Enrollment Data
INSERT INTO enrollments VALUES
(1,1),
(1,2),
(2,1),
(3,3);

-- Show data
SELECT * FROM enrollments;


-- 7️⃣ Demonstrate CASCADE
DELETE FROM students
WHERE student_id = 1;

SELECT * FROM enrollments;

-- 8️⃣ Demonstrate RESTRICT
DELETE FROM courses
WHERE course_id = 1;

-- 9️⃣ Demonstrate SET NULL (Add New Table)
-- Create instructors table.
CREATE TABLE instructors (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    instructor_name VARCHAR(100)
);

-- Add instructor column to courses.
ALTER TABLE courses
ADD instructor_id INT;

-- Add foreign key.
ALTER TABLE courses
ADD FOREIGN KEY (instructor_id)
REFERENCES instructors(instructor_id)
ON DELETE SET NULL;

-- Insert instructor.
INSERT INTO instructors VALUES
(1,'John');

-- Update course.
UPDATE courses
SET instructor_id = 1
WHERE course_id = 2;

-- Now delete instructor.
DELETE FROM instructors WHERE instructor_id=1;

-- Check courses table. Instructor column becomes null

-- 🔟 Demonstrate ON UPDATE CASCADE
-- Change student ID.
UPDATE students
SET student_id = 10
WHERE student_id = 2;

-- Now check enrollments. student ID updated automatically 

-------------------------------------------------------------------------------------

-- Practice Task for Students

-- Ask students to:

-- 1️⃣ Add column max_students INT CHECK(max_students > 0) to courses.

-- 2️⃣ Insert invalid data to test CHECK.

-- 3️⃣ Create new instructor and assign to course.

-- 4️⃣ Delete instructor and observe SET NULL.



-- Topic	Covered
-- Primary Key	
-- Foreign Key	
-- UNIQUE	
-- NOT NULL	
-- CHECK	
-- AUTO_INCREMENT	
-- ON DELETE	
-- CASCADE
-- SET NULL	
-- RESTRICT	
-- ON UPDATE	
-- Many-to-Many	