USE [coursemanagement]
GO

-- Clear existing data
DELETE FROM [dbo].[LearningOutcome]
DELETE FROM [dbo].[CourseStudent]
DELETE FROM [dbo].[Course]
DELETE FROM [dbo].[CourseCategory]
DELETE FROM [dbo].[Instructor]
DELETE FROM [dbo].[User]
DELETE FROM [dbo].[Role]

-- Reset identity columns
DBCC CHECKIDENT ('[dbo].[LearningOutcome]', RESEED, 0)
DBCC CHECKIDENT ('[dbo].[Course]', RESEED, 0)
DBCC CHECKIDENT ('[dbo].[CourseCategory]', RESEED, 0)
DBCC CHECKIDENT ('[dbo].[Instructor]', RESEED, 0)
DBCC CHECKIDENT ('[dbo].[User]', RESEED, 0)
DBCC CHECKIDENT ('[dbo].[Role]', RESEED, 0)

-- Insert Roles
INSERT INTO [dbo].[Role] ([roleName]) VALUES ('Admin')
INSERT INTO [dbo].[Role] ([roleName]) VALUES ('Student')

-- Insert Users (Admin and Students)
-- Admin user
INSERT INTO [dbo].[User] ([username], [password], [roleId], [phoneNumber], [gender], [dob], [identityCard], [email], [studentID])
VALUES ('admin', 'admin123', 1, '1234567890', 'Male', '1990-01-01', 'ADM123456', 'admin@example.com', NULL)

-- Student users
INSERT INTO [dbo].[User] ([username], [password], [roleId], [phoneNumber], [gender], [dob], [identityCard], [email], [studentID])
VALUES 
('john', 'john123', 2, '2345678901', 'Male', '2000-05-15', 'STU123456', 'john@example.com', 'STU001'),
('emma', 'emma123', 2, '3456789012', 'Female', '2001-07-22', 'STU234567', 'emma@example.com', 'STU002'),
('michael', 'michael123', 2, '4567890123', 'Male', '1999-03-10', 'STU345678', 'michael@example.com', 'STU003'),
('sophia', 'sophia123', 2, '5678901234', 'Female', '2002-11-05', 'STU456789', 'sophia@example.com', 'STU004'),
('david', 'david123', 2, '6789012345', 'Male', '2000-09-18', 'STU567890', 'david@example.com', 'STU005'),
('lisa', 'lisa123', 2, '7890123456', 'Female', '2001-12-12', 'STU678901', 'lisa@example.com', 'STU006'),
('peter', 'peter123', 2, '8901234567', 'Male', '2000-08-25', 'STU789012', 'peter@example.com', 'STU007')

-- Insert Instructors
INSERT INTO [dbo].[Instructor] ([name], [image], [description])
VALUES 
('Dr. Robert Smith', 'https://randomuser.me/api/portraits/men/1.jpg', 'PhD in Computer Science with 10 years of teaching experience'),
('Prof. Jennifer Lee', 'https://randomuser.me/api/portraits/women/2.jpg', 'Expert in Data Science and Machine Learning'),
('Dr. James Wilson', 'https://randomuser.me/api/portraits/men/3.jpg', 'Specialized in Web Development and UI/UX Design'),
('Prof. Emily Davis', 'https://randomuser.me/api/portraits/women/4.jpg', 'Expert in Business Administration and Management'),
('Dr. Sarah Brown', 'https://randomuser.me/api/portraits/women/5.jpg', 'Expert in Artificial Intelligence and Robotics'),
('Prof. Mark Taylor', 'https://randomuser.me/api/portraits/men/6.jpg', 'Specialized in Cloud Computing and DevOps')

-- Insert Course Categories
INSERT INTO [dbo].[CourseCategory] ([Name])
VALUES 
('Programming'),
('Data Science'),
('Web Development'),
('Business'),
('Artificial Intelligence'),
('Cloud Computing')

-- Insert Courses
INSERT INTO [dbo].[Course] ([courseName], [courseTitle], [courseDescription], [courseImage], [startDate], [endDate], [status], [courseCategoryId], [instructorId], [requirements])
VALUES 
('Java Programming', 'Introduction to Java', 'Learn the fundamentals of Java programming language', 'https://picsum.photos/id/0/800/400', '2025-04-01', '2025-06-30', 'Active', 1, 1, 'Basic computer knowledge'),
('Python for Data Science', 'Data Analysis with Python', 'Master data analysis techniques using Python', 'https://picsum.photos/id/1/800/400', '2025-04-15', '2025-07-15', 'Active', 2, 2, 'Basic programming knowledge'),
('Full Stack Web Development', 'Modern Web Applications', 'Build responsive web applications using modern frameworks', 'https://picsum.photos/id/2/800/400', '2025-05-01', '2025-08-01', 'Active', 3, 3, 'HTML, CSS, and JavaScript basics'),
('Business Management', 'Principles of Management', 'Learn essential business management principles', 'https://picsum.photos/id/3/800/400', '2025-05-15', '2025-08-15', 'Active', 4, 4, 'None'),
('Advanced Java', 'Enterprise Java Applications', 'Develop enterprise-level Java applications', 'https://picsum.photos/id/4/800/400', '2025-06-01', '2025-09-01', 'Inactive', 1, 1, 'Java programming experience'),
('AI Fundamentals', 'Introduction to Artificial Intelligence', 'Explore the basics of AI and machine learning', 'https://picsum.photos/id/5/800/400', '2025-06-15', '2025-09-15', 'Active', 5, 5, 'Basic programming skills'),
('Cloud Essentials', 'Cloud Computing Basics', 'Learn cloud infrastructure and services', 'https://picsum.photos/id/6/800/400', '2025-07-01', '2025-10-01', 'Active', 6, 6, 'Basic IT knowledge'),
('Machine Learning', 'Practical Machine Learning', 'Implement ML algorithms with real-world applications', 'https://picsum.photos/id/7/800/400', '2025-07-15', '2025-10-15', 'Active', 5, 5, 'Python and statistics knowledge')

-- Insert Learning Outcomes
INSERT INTO [dbo].[LearningOutcome] ([courseId], [outcomeText])
VALUES 
(1, 'Understand Java syntax and basic programming concepts'),
(1, 'Create object-oriented programs using Java'),
(1, 'Implement error handling and debugging techniques'),
(2, 'Perform data cleaning and preprocessing with Python'),
(2, 'Apply statistical analysis to datasets'),
(2, 'Create data visualizations using Python libraries'),
(3, 'Build responsive front-end interfaces with HTML, CSS, and JavaScript'),
(3, 'Develop back-end services using Node.js or similar technologies'),
(3, 'Connect front-end and back-end components to create full-stack applications'),
(4, 'Understand key management principles and theories'),
(4, 'Apply strategic planning techniques to business scenarios'),
(4, 'Develop leadership and team management skills')

-- Insert Course Students (Enrollments)
-- Some students with Active status
INSERT INTO [dbo].[CourseStudent] ([studentId], [courseId], [enrollDate], [status])
VALUES 
(2, 1, '2025-03-20', 'Active'),  -- John enrolled in Java Programming
(2, 2, '2025-03-22', 'Active'),  -- John enrolled in Python for Data Science
(3, 1, '2025-03-21', 'Active'),  -- Emma enrolled in Java Programming
(3, 3, '2025-03-25', 'Active'),  -- Emma enrolled in Full Stack Web Development
(4, 2, '2025-03-23', 'Active'),  -- Michael enrolled in Python for Data Science
(5, 3, '2025-03-24', 'Active'),  -- Sophia enrolled in Full Stack Web Development
(5, 4, '2025-03-26', 'Active')   -- Sophia enrolled in Business Management

-- Some students with Inactive status (banned)
INSERT INTO [dbo].[CourseStudent] ([studentId], [courseId], [enrollDate], [status])
VALUES 
(2, 3, '2025-03-27', 'Inactive'),  -- John banned from Full Stack Web Development
(4, 1, '2025-03-28', 'Inactive'),  -- Michael banned from Java Programming
(6, 2, '2025-03-29', 'Inactive')   -- David banned from Python for Data Science

PRINT 'Sample data has been successfully added to the database.'
GO

SELECT * FROM [dbo].[User]