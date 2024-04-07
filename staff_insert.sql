INSERT INTO Staff (firstName, lastName, role, contactDetails) VALUES
('John', 'Doe', 'associate', 'john.doe@example.com'),
('Jane', 'Doe', 'instructor', 'jane.doe@example.com'),
('Mike', 'Smith', 'associate', 'mike.smith@example.com'),
('Anna', 'Brown', 'instructor', 'anna.brown@example.com'),
('Chris', 'Davis', 'associate', 'chris.davis@example.com'),
('Patricia', 'Martinez', 'instructor', 'patricia.martinez@example.com'),
('Linda', 'Garcia', 'associate', 'linda.garcia@example.com'),
('Barbara', 'Wilson', 'instructor', 'barbara.wilson@example.com'),
('Elizabeth', 'Anderson', 'associate', 'elizabeth.anderson@example.com'),
('Jennifer', 'Taylor', 'instructor', 'jennifer.taylor@example.com'),
('Maria', 'Thomas', 'associate', 'maria.thomas@example.com'),
('Susan', 'Hernandez', 'instructor', 'susan.hernandez@example.com'),
('Margaret', 'Moore', 'associate', 'margaret.moore@example.com'),
('Dorothy', 'Jackson', 'instructor', 'dorothy.jackson@example.com'),
('Lisa', 'Martin', 'associate', 'lisa.martin@example.com'),
('Nancy', 'Lee', 'instructor', 'nancy.lee@example.com'),
('Karen', 'Perez', 'associate', 'karen.perez@example.com'),
('Betty', 'Thompson', 'instructor', 'betty.thompson@example.com'),
('Helen', 'White', 'associate', 'helen.white@example.com'),
('Sandra', 'Harris', 'instructor', 'sandra.harris@example.com');

-- After inserting into Staff, we insert into Instructors based on role
INSERT INTO Instructors (staffID)
SELECT staffID FROM Staff WHERE role = 'instructor';

