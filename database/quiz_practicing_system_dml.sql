USE [quiz_practicing_system]
GO

-- system_settings
INSERT INTO [system_settings] ([type], [value], [description], [status])
VALUES 
('User Roles', 'Admin', 'System administrator with full access', 1),
('User Roles', 'Expert', 'Expert responsible for providing answers and content', 1),
('User Roles', 'Customer', 'Regular user with limited permissions', 1),
('Subject Categories', 'Programming', 'Topics related to programming languages and software development', 1),
('Subject Categories', 'Database', 'Subjects covering relational databases and SQL queries', 1),
('Subject Categories', 'Network', 'Topics related to computer networks and communication protocols', 1),
('Subject Categories', 'AI', 'Artificial Intelligence and Machine Learning concepts', 1),
('Subject Categories', 'Security', 'Cybersecurity principles and practices', 1),
('Subject Categories', 'Web', 'Frontend and backend web development topics', 1),
('Subject Categories', 'Data Science', 'Data analysis, visualization, and machine learning', 1),
('Test Types', 'Simulation', 'Full test simulation under exam conditions', 1),
('Test Types', 'Lesson-Quiz', 'Short quizzes for each lesson or topic', 1),
('Question Levels', 'Hard', 'Challenging questions for advanced learners', 1),
('Question Levels', 'Medium', 'Moderate difficulty questions for practice', 1),
('Question Levels', 'Easy', 'Basic questions for beginners or review', 1),
('Lesson Types', 'Subject Topic', 'Overview of a specific subject topic', 1),
('Lesson Types', 'Lesson', 'In-depth lesson material for study', 1),
('Lesson Types', 'Quiz', 'Practice quiz to assess understanding', 1);

--users
--password Pass123@
INSERT INTO [users] (
    [email], 
    [password], 
    [name], 
    [gender], 
    [mobile], 
    [address], 
    [activate], 
    [role_id],
    [token_create_at],
    [token_send_at]
) VALUES
('admin@gmail.com', '9IvR609uK4oh0w4QpeapLfvPBB37oA5EmVTjpF/liwQ=', N'Bob Tran', 1, '0912345678', N'456 Nguyen Hue Street, District 1, HCM City', 1, 1, NULL, NULL),
('alice@example.com', '9IvR609uK4oh0w4QpeapLfvPBB37oA5EmVTjpF/liwQ=', N'Alice Nguyen', 0, '0910000001', N'123 Le Loi Street, District 1, HCM City', 1, 3, NULL, NULL),
('bob@example.com', '9IvR609uK4oh0w4QpeapLfvPBB37oA5EmVTjpF/liwQ=', N'Bob Tran', 1, '0910000002', N'456 Nguyen Hue Avenue, District 1, HCM City', 1, 3, NULL, NULL),
('charlie@example.com', '9IvR609uK4oh0w4QpeapLfvPBB37oA5EmVTjpF/liwQ=', N'Charlie Le', 1, '0910000003', N'789 Tran Hung Dao, District 5, HCM City', 1, 3, NULL, NULL),
('daisy@example.com', '9IvR609uK4oh0w4QpeapLfvPBB37oA5EmVTjpF/liwQ=', N'Daisy Pham', 0, '0910000004', N'12 Ly Thuong Kiet, District 10, HCM City', 1, 3, NULL, NULL),
('edward@example.com', '9IvR609uK4oh0w4QpeapLfvPBB37oA5EmVTjpF/liwQ=', N'Edward Vo', 1, '0910000005', N'99 Cach Mang Thang 8, District 3, HCM City', 1, 3, NULL, NULL),
('fiona@example.com', '9IvR609uK4oh0w4QpeapLfvPBB37oA5EmVTjpF/liwQ=', N'Fiona Mai', 0, '0910000006', N'24 Truong Sa, Phu Nhuan District, HCM City', 1, 3, NULL, NULL),
('george@example.com', '9IvR609uK4oh0w4QpeapLfvPBB37oA5EmVTjpF/liwQ=', N'George Do', 1, '0910000007', N'135 Hoang Sa, Binh Thanh District, HCM City', 1, 3, NULL, NULL),
('hannah@example.com', '9IvR609uK4oh0w4QpeapLfvPBB37oA5EmVTjpF/liwQ=', N'Hannah Nguyen', 0, '0910000008', N'14 Bach Dang, Tan Binh District, HCM City', 1, 3, NULL, NULL),
('ian@example.com', '9IvR609uK4oh0w4QpeapLfvPBB37oA5EmVTjpF/liwQ=', N'Ian Ho', 1, '0910000009', N'99 Phan Xich Long, Phu Nhuan District, HCM City', 1, 3, NULL, NULL),
('julia@example.com', '9IvR609uK4oh0w4QpeapLfvPBB37oA5EmVTjpF/liwQ=', N'Julia Bui', 0, '0910000010', N'50 To Hien Thanh, District 10, HCM City', 1, 3, NULL, NULL),
('kevin@example.com', '9IvR609uK4oh0w4QpeapLfvPBB37oA5EmVTjpF/liwQ=', N'Kevin Nguyen', 1, '0910000011', N'180 Dien Bien Phu, District 3, HCM City', 1, 3, NULL, NULL),
('lily@example.com', '9IvR609uK4oh0w4QpeapLfvPBB37oA5EmVTjpF/liwQ=', N'Lily Trinh', 0, '0910000012', N'78 Ly Chinh Thang, District 3, HCM City', 1, 3, NULL, NULL),
('michael@example.com', '9IvR609uK4oh0w4QpeapLfvPBB37oA5EmVTjpF/liwQ=', N'Michael Lam', 1, '0910000013', N'30 Pasteur, District 1, HCM City', 1, 3, NULL, NULL),
('natalie@example.com', '9IvR609uK4oh0w4QpeapLfvPBB37oA5EmVTjpF/liwQ=', N'Natalie Chau', 0, '0910000014', N'200 Nguyen Thi Minh Khai, District 1, HCM City', 1, 3, NULL, NULL),
('oliver@example.com', '9IvR609uK4oh0w4QpeapLfvPBB37oA5EmVTjpF/liwQ=', N'Oliver Tran', 1, '0910000015', N'65 Cong Hoa, Tan Binh District, HCM City', 1, 3, NULL, NULL),
('phoebe@example.com', '9IvR609uK4oh0w4QpeapLfvPBB37oA5EmVTjpF/liwQ=', N'Phoebe Vu', 0, '0910000016', N'81 Nguyen Trai, District 5, HCM City', 1, 3, NULL, NULL),
('quinn@example.com', '9IvR609uK4oh0w4QpeapLfvPBB37oA5EmVTjpF/liwQ=', N'Quinn Hoang', 1, '0910000017', N'90 Vo Van Tan, District 3, HCM City', 1, 3, NULL, NULL),
('rachel@example.com', '9IvR609uK4oh0w4QpeapLfvPBB37oA5EmVTjpF/liwQ=', N'Rachel Luu', 0, '0910000018', N'72 Nguyen Dinh Chieu, District 3, HCM City', 1, 3, NULL, NULL),
('steve@example.com', '9IvR609uK4oh0w4QpeapLfvPBB37oA5EmVTjpF/liwQ=', N'Steve Huynh', 1, '0910000019', N'120 Hoang Dieu, District 4, HCM City', 1, 3, NULL, NULL),
('tina@example.com', '9IvR609uK4oh0w4QpeapLfvPBB37oA5EmVTjpF/liwQ=', N'Tina Ha', 0, '0910000020', N'31 Nguyen Van Troi, Phu Nhuan District, HCM City', 1, 3, NULL, NULL),
('expert1@example.com', '9IvR609uK4oh0w4QpeapLfvPBB37oA5EmVTjpF/liwQ=', N'Alex Do', 1, '0920000001', N'88 Le Lai, District 1, HCM City', 1, 2, NULL, NULL),
('expert2@example.com', '9IvR609uK4oh0w4QpeapLfvPBB37oA5EmVTjpF/liwQ=', N'Bella Tran', 0, '0920000002', N'77 Nguyen Dinh Chieu, District 3, HCM City', 1, 2, NULL, NULL),
('expert3@example.com', '9IvR609uK4oh0w4QpeapLfvPBB37oA5EmVTjpF/liwQ=', N'Caleb Vu', 1, '0920000003', N'66 Tran Hung Dao, District 5, HCM City', 1, 2, NULL, NULL),
('expert4@example.com', '9IvR609uK4oh0w4QpeapLfvPBB37oA5EmVTjpF/liwQ=', N'Diana Pham', 0, '0920000004', N'55 Le Van Sy, Phu Nhuan District, HCM City', 1, 2, NULL, NULL),
('expert5@example.com', '9IvR609uK4oh0w4QpeapLfvPBB37oA5EmVTjpF/liwQ=', N'Ethan Lam', 1, '0920000005', N'44 Nguyen Van Cu, District 1, HCM City', 1, 2, NULL, NULL),
('expert6@example.com', '9IvR609uK4oh0w4QpeapLfvPBB37oA5EmVTjpF/liwQ=', N'Faye Ngo', 0, '0920000006', N'33 Phan Xich Long, Phu Nhuan District, HCM City', 1, 2, NULL, NULL);

INSERT INTO [subjects] (
    [name], [tag_line], [thumbnail], 
    [detail_description], [featured_subject], [status], 
    [category_id], [owner_id]
) VALUES
('Introduction to Programming', 'Start your coding journey', 'subject_1.png',
'- Understand the core concepts of programming such as variables, data types, and control structures.\n\n- Practice using loops and conditional statements through hands-on examples.\n\n- Build small programs to strengthen your logic and problem-solving skills.',
1, 1, 1, 22),

('SQL Fundamentals', 'Master database queries', 'subject_2.png',
'- Learn how to write SQL queries to extract data from relational databases using SELECT, WHERE, and ORDER BY clauses.\n\n- Understand relationships between tables and apply JOIN operations to connect data effectively.\n\n- Practice creating, updating, and managing database structures with SQL DDL and DML commands.',
0, 1, 2, 22),

('Networking Basics', 'Understand how devices connect', 'subject_3.png',
'- Discover how computers and other devices communicate over networks using IP addresses and ports.\n\n- Learn the fundamentals of subnetting and routing to manage data flow.\n\n- Explore protocols such as TCP/IP, HTTP, and DNS to understand how the internet works behind the scenes.',
0, 1, 3, 22),

('AI for Beginners', 'Get started with Artificial Intelligence', 'subject_4.png',
'- Get introduced to the world of AI, including its history and impact on modern technology.\n\n- Learn about key AI topics such as supervised and unsupervised learning, and explore how machines learn from data.\n\n- Work with real-world examples using tools like Python and popular libraries such as Scikit-learn.',
1, 1, 4, 22),

('Cybersecurity 101', 'Protect systems and data', 'subject_5.png',
'- Understand common cyber threats like malware, phishing, and social engineering attacks.\n\n- Learn basic defense mechanisms including firewalls, antivirus tools, and encryption.\n\n- Discover security best practices and strategies to safeguard personal and organizational data.',
0, 1, 5, 22),

('Frontend Development', 'Build beautiful interfaces', 'subject_6.png',
'- Explore the structure of web pages using HTML and style them using CSS for responsive and attractive design.\n\n- Add interactivity with JavaScript, enabling user input handling and dynamic content.\n\n- Work on projects that help you build real-world front-end applications and websites.',
1, 1, 6, 22),

('Data Science Essentials', 'Analyze and visualize data', 'subject_7.png',
'- Learn how to clean, transform, and manipulate data using popular libraries such as Pandas and NumPy.\n\n- Use visualization tools like Matplotlib and Seaborn to uncover patterns and insights.\n\n- Understand the basics of statistics, data distributions, and hypothesis testing in a data science context.',
0, 1, 7, 22),

('Backend with Node.js', 'Create APIs and services', 'subject_8.png',
'- Learn how to set up a server using Node.js and handle HTTP requests and responses.\n\n- Work with Express.js to create RESTful APIs and manage routing efficiently.\n\n- Understand how to connect your backend with databases and implement authentication and error handling.',
1, 1, 6, 22),

('Deep Learning Intro', 'Neural networks explained', 'subject_9.png',
'- Explore foundational deep learning concepts including perceptrons, activation functions, and backpropagation.\n\n- Learn about Convolutional Neural Networks (CNNs) and how they are used in image recognition.\n\n- Use TensorFlow or PyTorch to build and train simple deep learning models with real datasets.',
0, 1, 4, 22),

('Java Advanced Concepts', 'Level up your Java skills', 'subject_10.png',
'- Learn about Java generics, collections framework, and multithreading.\n\n- Understand memory management and performance tuning.\n\n- Build real-world projects to apply OOP principles effectively.',
0, 1, 1, 25),

('Database Design', 'Model data efficiently', 'subject_11.png',
'- Understand normalization and database schema design.\n\n- Learn to create ER diagrams and optimize table relationships.\n\n- Apply indexing and constraints to improve performance.',
1, 0, 2, 26),

('Cloud Networking', 'Connect on the cloud', 'subject_12.png',
'- Explore how networks operate in cloud infrastructure.\n\n- Learn about VPNs, VPCs, and load balancers.\n\n- Study practical AWS and Azure networking examples.',
0, 1, 3, 27),

('Machine Learning Basics', 'Teach machines to learn', 'subject_13.png',
'- Introduction to machine learning workflows.\n\n- Learn supervised and unsupervised algorithms.\n\n- Apply basic models using Scikit-learn and Python.',
1, 1, 4, 22),

('Ethical Hacking', 'Hack to protect', 'subject_14.png',
'- Learn penetration testing and ethical hacking fundamentals.\n\n- Explore tools like Metasploit and Wireshark.\n\n- Understand vulnerabilities and exploits in practice.',
0, 0, 5, 23),

('React Development', 'Build dynamic UIs', 'subject_15.png',
'- Understand component-based architecture.\n\n- Learn about JSX, props, and state.\n\n- Build responsive apps using hooks and React Router.',
1, 1, 6, 24),

('Big Data Basics', 'Manage large-scale data', 'subject_16.png',
'- Learn how big data systems process large datasets.\n\n- Explore Hadoop and Spark frameworks.\n\n- Apply data pipelines and real-time processing.',
0, 0, 7, 25),

('C# for Beginners', 'Get started with C#', 'subject_17.png',
'- Learn syntax, data types, and control flow in C#.\n\n- Build console applications using Visual Studio.\n\n- Understand object-oriented principles with C#.',
0, 1, 1, 26),

('NoSQL Databases', 'Flexible data models', 'subject_18.png',
'- Learn about document, key-value, and graph databases.\n\n- Explore MongoDB and Redis in practice.\n\n- Understand CAP theorem and use-cases of NoSQL.',
1, 1, 2, 27),

('Routing Protocols', 'Direct network traffic', 'subject_19.png',
'- Understand static and dynamic routing.\n\n- Learn RIP, OSPF, and BGP protocols.\n\n- Configure routers and simulate networks.',
0, 0, 3, 22),

('Natural Language Processing', 'Make machines understand text', 'subject_20.png',
'- Learn text preprocessing and tokenization.\n\n- Explore sentiment analysis and text classification.\n\n- Work with NLTK and spaCy libraries.',
1, 1, 4, 23),

('Data Privacy', 'Protect personal info', 'subject_21.png',
'- Learn GDPR and data protection principles.\n\n- Implement secure data handling practices.\n\n- Understand anonymization and encryption methods.',
1, 0, 5, 24),

('Vue.js Fundamentals', 'Progressive JavaScript framework', 'subject_22.png',
'- Create interactive UI components.\n\n- Work with Vue CLI and Vue Router.\n\n- Build reactive apps using Vue’s data binding.',
0, 1, 6, 25),

('Python for Data Science', 'Analyze with Python', 'subject_23.png',
'- Use Pandas and NumPy for data manipulation.\n\n- Perform data visualization with Matplotlib.\n\n- Clean and transform datasets efficiently.',
1, 1, 7, 26),

('Design Patterns in Java', 'Reusable solutions', 'subject_24.png',
'- Learn structural, behavioral, and creational patterns.\n\n- Implement patterns like Singleton, Factory, and Observer.\n\n- Improve code readability and reusability.',
0, 1, 1, 27),

('PostgreSQL Essentials', 'Advanced SQL skills', 'subject_25.png',
'- Use PostgreSQL for relational database management.\n\n- Practice stored procedures, views, and indexes.\n\n- Work with JSON and geospatial data.',
1, 0, 2, 22),

('Wireless Networks', 'Go untethered', 'subject_26.png',
'- Learn wireless standards and security protocols.\n\n- Set up secure wireless LANs.\n\n- Understand mobile and IoT networking.',
0, 1, 3, 23),

('AI Ethics', 'Responsible AI development', 'subject_27.png',
'- Explore the social impact of AI technologies.\n\n- Understand bias, fairness, and transparency.\n\n- Study case studies and regulations.',
1, 0, 4, 24),

('Incident Response', 'React to threats fast', 'subject_28.png',
'- Develop incident response plans and playbooks.\n\n- Learn containment and recovery strategies.\n\n- Understand threat intelligence sources.',
0, 1, 5, 25),

('Web Accessibility', 'Inclusive web design', 'subject_29.png',
'- Learn WCAG guidelines and ARIA roles.\n\n- Test and fix accessibility issues.\n\n- Design usable, inclusive interfaces.',
1, 0, 6, 26),

('Statistics for Data Science', 'Understand the numbers', 'subject_30.png',
'- Learn probability, distributions, and hypothesis testing.\n\n- Use stats to validate machine learning models.\n\n- Apply in Python using SciPy and StatsModels.',
0, 1, 7, 27);

UPDATE [subjects] SET [update_date] = '2025-01-01 00:00:00' WHERE [id] = 1;
UPDATE [subjects] SET [update_date] = '2025-01-02 00:00:00' WHERE [id] = 2;
UPDATE [subjects] SET [update_date] = '2025-01-03 00:00:00' WHERE [id] = 3;
UPDATE [subjects] SET [update_date] = '2025-01-04 00:00:00' WHERE [id] = 4;
UPDATE [subjects] SET [update_date] = '2025-01-05 00:00:00' WHERE [id] = 5;
UPDATE [subjects] SET [update_date] = '2025-01-06 00:00:00' WHERE [id] = 6;
UPDATE [subjects] SET [update_date] = '2025-01-07 00:00:00' WHERE [id] = 7;
UPDATE [subjects] SET [update_date] = '2025-01-08 00:00:00' WHERE [id] = 8;
UPDATE [subjects] SET [update_date] = '2025-01-09 00:00:00' WHERE [id] = 9;
UPDATE [subjects] SET [update_date] = '2025-01-10 00:00:00' WHERE [id] = 10;
UPDATE [subjects] SET [update_date] = '2025-01-11 00:00:00' WHERE [id] = 11;
UPDATE [subjects] SET [update_date] = '2025-01-12 00:00:00' WHERE [id] = 12;
UPDATE [subjects] SET [update_date] = '2025-01-13 00:00:00' WHERE [id] = 13;
UPDATE [subjects] SET [update_date] = '2025-01-14 00:00:00' WHERE [id] = 14;
UPDATE [subjects] SET [update_date] = '2025-01-15 00:00:00' WHERE [id] = 15;
UPDATE [subjects] SET [update_date] = '2025-01-16 00:00:00' WHERE [id] = 16;
UPDATE [subjects] SET [update_date] = '2025-01-17 00:00:00' WHERE [id] = 17;
UPDATE [subjects] SET [update_date] = '2025-01-18 00:00:00' WHERE [id] = 18;
UPDATE [subjects] SET [update_date] = '2025-01-19 00:00:00' WHERE [id] = 19;
UPDATE [subjects] SET [update_date] = '2025-01-20 00:00:00' WHERE [id] = 20;
UPDATE [subjects] SET [update_date] = '2025-01-21 00:00:00' WHERE [id] = 21;
UPDATE [subjects] SET [update_date] = '2025-01-22 00:00:00' WHERE [id] = 22;
UPDATE [subjects] SET [update_date] = '2025-01-23 00:00:00' WHERE [id] = 23;
UPDATE [subjects] SET [update_date] = '2025-01-24 00:00:00' WHERE [id] = 24;
UPDATE [subjects] SET [update_date] = '2025-01-25 00:00:00' WHERE [id] = 25;
UPDATE [subjects] SET [update_date] = '2025-01-26 00:00:00' WHERE [id] = 26;
UPDATE [subjects] SET [update_date] = '2025-01-27 00:00:00' WHERE [id] = 27;
UPDATE [subjects] SET [update_date] = '2025-01-28 00:00:00' WHERE [id] = 28;
UPDATE [subjects] SET [update_date] = '2025-01-29 00:00:00' WHERE [id] = 29;
UPDATE [subjects] SET [update_date] = '2025-01-30 00:00:00' WHERE [id] = 30;


-- Price Packages for each subject (duration in months)
INSERT INTO [price_packages] ([name], [duration], [list_price], [sale_price], [description], [status], [subject_id]) VALUES
-- Subject ID 1
('Bronze', 1, 49.99, 29.99, 'Basic access for one month', 1, 1),
('Silver', 3, 99.99, 59.99, 'Standard access for three months', 1, 1),
('Gold', 6, 199.99, 99.99, 'Full access for six months', 1, 1),
-- Subject ID 2
('Bronze', 1, 39.99, 24.99, 'Basic access for one month', 1, 2),
('Silver', 3, 79.99, 49.99, 'Standard access for three months', 1, 2),
('Gold', 6, 159.99, 89.99, 'Full access for six months', 1, 2),
-- Subject ID 3
('Bronze', 1, 44.99, 27.99, 'Basic access for one month', 1, 3),
('Silver', 3, 89.99, 54.99, 'Standard access for three months', 1, 3),
('Gold', 6, 179.99, 94.99, 'Full access for six months', 1, 3),
-- Subject ID 4
('Bronze', 1, 59.99, 34.99, 'Basic access for one month', 1, 4),
('Silver', 3, 109.99, 64.99, 'Standard access for three months', 1, 4),
('Gold', 6, 219.99, 114.99, 'Full access for six months', 1, 4),
-- Subject ID 5
('Bronze', 1, 49.99, 29.99, 'Basic access for one month', 1, 5),
('Silver', 3, 99.99, 59.99, 'Standard access for three months', 1, 5),
('Gold', 6, 199.99, 99.99, 'Full access for six months', 1, 5),
-- Subject ID 6
('Bronze', 1, 54.99, 31.99, 'Basic access for one month', 1, 6),
('Silver', 3, 104.99, 62.99, 'Standard access for three months', 1, 6),
('Gold', 6, 209.99, 109.99, 'Full access for six months', 1, 6),
-- Subject ID 7
('Bronze', 1, 44.99, 27.99, 'Basic access for one month', 1, 7),
('Silver', 3, 89.99, 54.99, 'Standard access for three months', 1, 7),
('Gold', 6, 179.99, 94.99, 'Full access for six months', 1, 7),
-- Subject ID 8
('Bronze', 1, 49.99, 29.99, 'Basic access for one month', 1, 8),
('Silver', 3, 99.99, 59.99, 'Standard access for three months', 1, 8),
('Gold', 6, 199.99, 99.99, 'Full access for six months', 1, 8),
-- Subject ID 9
('Bronze', 1, 59.99, 34.99, 'Basic access for one month', 1, 9),
('Silver', 3, 109.99, 64.99, 'Standard access for three months', 1, 9),
('Gold', 6, 219.99, 114.99, 'Full access for six months', 1, 9),

-- Subject ID 10
('Bronze', 1, 49.99, 29.99, 'Basic access for one month', 1, 10),
('Silver', 3, 99.99, 59.99, 'Standard access for three months', 1, 10),
('Gold', 6, 199.99, 99.99, 'Full access for six months', 1, 10),
-- Subject ID 11
('Bronze', 1, 49.99, 29.99, 'Basic access for one month', 1, 11),
('Silver', 3, 99.99, 59.99, 'Standard access for three months', 1, 11),
('Gold', 6, 199.99, 99.99, 'Full access for six months', 1, 11),
-- Subject ID 12
('Bronze', 1, 49.99, 29.99, 'Basic access for one month', 1, 12),
('Silver', 3, 99.99, 59.99, 'Standard access for three months', 1, 12),
('Gold', 6, 199.99, 99.99, 'Full access for six months', 1, 12),
-- Subject ID 13
('Bronze', 1, 49.99, 29.99, 'Basic access for one month', 1, 13),
('Silver', 3, 99.99, 59.99, 'Standard access for three months', 1, 13),
('Gold', 6, 199.99, 99.99, 'Full access for six months', 1, 13),
-- Subject ID 14
('Bronze', 1, 49.99, 29.99, 'Basic access for one month', 1, 14),
('Silver', 3, 99.99, 59.99, 'Standard access for three months', 1, 14),
('Gold', 6, 199.99, 99.99, 'Full access for six months', 1, 14),
-- Subject ID 15
('Bronze', 1, 49.99, 29.99, 'Basic access for one month', 1, 15),
('Silver', 3, 99.99, 59.99, 'Standard access for three months', 1, 15),
('Gold', 6, 199.99, 99.99, 'Full access for six months', 1, 15),
-- Subject ID 16
('Bronze', 1, 49.99, 29.99, 'Basic access for one month', 1, 16),
('Silver', 3, 99.99, 59.99, 'Standard access for three months', 1, 16),
('Gold', 6, 199.99, 99.99, 'Full access for six months', 1, 16),
-- Subject ID 17
('Bronze', 1, 49.99, 29.99, 'Basic access for one month', 1, 17),
('Silver', 3, 99.99, 59.99, 'Standard access for three months', 1, 17),
('Gold', 6, 199.99, 99.99, 'Full access for six months', 1, 17),
-- Subject ID 18
('Bronze', 1, 49.99, 29.99, 'Basic access for one month', 1, 18),
('Silver', 3, 99.99, 59.99, 'Standard access for three months', 1, 18),
('Gold', 6, 199.99, 99.99, 'Full access for six months', 1, 18),
-- Subject ID 19
('Bronze', 1, 49.99, 29.99, 'Basic access for one month', 1, 19),
('Silver', 3, 99.99, 59.99, 'Standard access for three months', 1, 19),
('Gold', 6, 199.99, 99.99, 'Full access for six months', 1, 19),
-- Subject ID 20
('Bronze', 1, 49.99, 29.99, 'Basic access for one month', 1, 20),
('Silver', 3, 99.99, 59.99, 'Standard access for three months', 1, 20),
('Gold', 6, 199.99, 99.99, 'Full access for six months', 1, 20),
-- Subject ID 21
('Bronze', 1, 49.99, 29.99, 'Basic access for one month', 1, 21),
('Silver', 3, 99.99, 59.99, 'Standard access for three months', 1, 21),
('Gold', 6, 199.99, 99.99, 'Full access for six months', 1, 21),
-- Subject ID 22
('Bronze', 1, 49.99, 29.99, 'Basic access for one month', 1, 22),
('Silver', 3, 99.99, 59.99, 'Standard access for three months', 1, 22),
('Gold', 6, 199.99, 99.99, 'Full access for six months', 1, 22),
-- Subject ID 23
('Bronze', 1, 49.99, 29.99, 'Basic access for one month', 1, 23),
('Silver', 3, 99.99, 59.99, 'Standard access for three months', 1, 23),
('Gold', 6, 199.99, 99.99, 'Full access for six months', 1, 23),
-- Subject ID 24
('Bronze', 1, 49.99, 29.99, 'Basic access for one month', 1, 24),
('Silver', 3, 99.99, 59.99, 'Standard access for three months', 1, 24),
('Gold', 6, 199.99, 99.99, 'Full access for six months', 1, 24),
-- Subject ID 25
('Bronze', 1, 49.99, 29.99, 'Basic access for one month', 1, 25),
('Silver', 3, 99.99, 59.99, 'Standard access for three months', 1, 25),
('Gold', 6, 199.99, 99.99, 'Full access for six months', 1, 25),
-- Subject ID 26
('Bronze', 1, 49.99, 29.99, 'Basic access for one month', 1, 26),
('Silver', 3, 99.99, 59.99, 'Standard access for three months', 1, 26),
('Gold', 6, 199.99, 99.99, 'Full access for six months', 1, 26),
-- Subject ID 27
('Bronze', 1, 49.99, 29.99, 'Basic access for one month', 1, 27),
('Silver', 3, 99.99, 59.99, 'Standard access for three months', 1, 27),
('Gold', 6, 199.99, 99.99, 'Full access for six months', 1, 27),
-- Subject ID 28
('Bronze', 1, 49.99, 29.99, 'Basic access for one month', 1, 28),
('Silver', 3, 99.99, 59.99, 'Standard access for three months', 1, 28),
('Gold', 6, 199.99, 99.99, 'Full access for six months', 1, 28),
-- Subject ID 29
('Bronze', 1, 49.99, 29.99, 'Basic access for one month', 1, 29),
('Silver', 3, 99.99, 59.99, 'Standard access for three months', 1, 29),
('Gold', 6, 199.99, 99.99, 'Full access for six months', 1, 29),
('Prenimum', null, 300.99, 249.99, 'Full access for every time', 1, 29),
-- Subject ID 30
('Bronze', 1, 49.99, 29.99, 'Basic access for one month', 1, 30),
('Silver', 3, 99.99, 59.99, 'Standard access for three months', 1, 30),
('Gold', 6, 199.99, 99.99, 'Full access for six months', 1, 30),
('Prenimum', null, 300.99, 249.99, 'Full access for every time', 1, 30);

INSERT INTO [registrations] ([time], [total_cost], [duration], [valid_from], [valid_to], [status], [price_package_id], [user_id]) VALUES 
('2025-05-19 08:50:00.000', 29.99, 1,'2025-05-20 09:00:00.000', '2025-06-20 09:00:00.000', 'Paid', 1, 2),
('2025-06-09 08:50:00.000', 49.99, 3,null, null, 'Pending Confirmation', 5, 2),
('2025-06-09 08:50:00.000', 49.99, 3,null, null, 'Pending Payment', 8, 2),
('2024-06-19 08:50:00.000', 114.99, 6,'2024-06-20 09:00:00.000', '2024-12-20 09:00:00.000', 'Expired', 27, 2),
('2025-06-05 08:50:00.000', 99.99, 6,null, null, 'Canceled', 24, 2),
('2025-06-05 08:50:00.000', 99.99, 6,null, null, 'Rejected', 21, 2),
('2025-03-11 08:50:00.000', 249.99, null, null, null, 'Pending Confirmation', 88, 2),
('2025-03-11 08:50:00.000', 249.99, null,'2025-03-13 09:00:00.000', null, 'Paid', 92, 2);

INSERT INTO [dimensions] ([name], [description], [subject_id]) VALUES
-- subject_id = 1 (Introduction to Programming)
('Variables and Data Types', 'Covers primitive data types, variables, and type conversions.', 1),
('Control Structures', 'Learn about if-else, switch, loops, and their logic.', 1),
('Programming Tools', 'Intro to IDEs and compilers used for coding.', 1),
('Problem Solving', 'Strengthen logical thinking through hands-on problems.', 1),

-- subject_id = 2 (SQL Fundamentals)
('SQL Basics', 'Understand SELECT, WHERE, ORDER BY, and filtering data.', 2),
('Joins & Relationships', 'Work with JOINs to combine tables meaningfully.', 2),
('SQL Platforms', 'Practice using MySQL, SQL Server, or PostgreSQL.', 2),
('Database Design', 'Apply normalization and database modeling concepts.', 2),

-- subject_id = 3 (Networking Basics)
('Network Fundamentals', 'IP, MAC, ports, and data transmission concepts.', 3),
('Subnetting & Routing', 'Learn how to manage and segment networks.', 3),
('Network Tools', 'Use tools like Wireshark, Ping, and Traceroute.', 3),
('Troubleshooting', 'Diagnose and resolve basic network issues.', 3),

-- subject_id = 4 (AI for Beginners)
('AI Concepts', 'History, types of AI, and ethical implications.', 4),
('Machine Learning Basics', 'Supervised vs unsupervised learning, algorithms.', 4),
('Python Libraries', 'Use Scikit-learn, NumPy for AI experimentation.', 4),
('AI Applications', 'Understand how AI is used in real-world scenarios.', 4);

INSERT INTO [lessons] ([name], [topic], [order], [video_link], [content], [status], [subject_id], [lesson_type_id]) VALUES
-- Subject 1: Introduction to Programming
('Intro to Programming', 'Basics', 1, 'https://youtu.be/vid101', 'Introduction and goals of the course.', 1, 1, 1),
('Variables in Programming', 'Variables', 2, 'https://youtu.be/vid102', 'Learn about variables and data types.', 1, 1, 1),
('Control Flow', 'Control', 3, 'https://youtu.be/vid103', 'Using if/else, loops in code.', 1, 1, 1),
('Functions and Methods', 'Functions', 4, 'https://youtu.be/vid104', 'Defining and calling functions.', 1, 1, 1),
('Project: Simple Calculator', 'Project', 5, 'https://youtu.be/vid105', 'Build a basic calculator in code.', 1, 1, 2),

-- Subject 2: SQL Fundamentals
('Intro to SQL', 'Basics', 1, 'https://youtu.be/vid201', 'What is SQL and how it works.', 1, 2, 1),
('SELECT Statements', 'Queries', 2, 'https://youtu.be/vid202', 'Querying data from a single table.', 1, 2, 1),
('Filtering with WHERE', 'Queries', 3, 'https://youtu.be/vid203', 'How to filter records with conditions.', 1, 2, 1),
('JOIN Operations', 'Joins', 4, 'https://youtu.be/vid204', 'Combining data across tables.', 1, 2, 1),
('SQL Project: Report System', 'Project', 5, 'https://youtu.be/vid205', 'Build a simple reporting system.', 1, 2, 2),

-- Subject 3: Networking Basics
('Intro to Networking', 'Basics', 1, 'https://youtu.be/vid301', 'What is a computer network?', 1, 3, 1),
('IP Addressing', 'IP', 2, 'https://youtu.be/vid302', 'Learn how devices are addressed.', 1, 3, 1),
('Subnetting Explained', 'Subnetting', 3, 'https://youtu.be/vid303', 'Dividing networks using subnet masks.', 1, 3, 1),
('Common Protocols', 'Protocols', 4, 'https://youtu.be/vid304', 'Intro to HTTP, DNS, TCP/IP.', 1, 3, 1),
('Networking Lab', 'Lab', 5, 'https://youtu.be/vid305', 'Hands-on practice with tools.', 1, 3, 2),

-- Subject 4: AI for Beginners
('What is AI?', 'Basics', 1, 'https://youtu.be/vid401', 'Definition and history of AI.', 1, 4, 1),
('Types of Learning', 'ML', 2, 'https://youtu.be/vid402', 'Supervised vs unsupervised.', 1, 4, 1),
('Working with Data', 'Data', 3, 'https://youtu.be/vid403', 'Cleaning and preparing data.', 1, 4, 1),
('Intro to Python Libraries', 'Tools', 4, 'https://youtu.be/vid404', 'Using NumPy, pandas for AI.', 1, 4, 1),
('Mini AI Project', 'Project', 5, 'https://youtu.be/vid405', 'Build a basic classifier.', 1, 4, 2);

INSERT INTO [questions] ([content], [explaination], [question_level_id], [subject_lesson_id], [subject_dimension_id]) VALUES
('Question 1 for lesson 1 - dimension 1', 'Explanation 1', 1, 1, 1),
('Question 2 for lesson 1 - dimension 1', 'Explanation 2', 2, 1, 1),
('Question 3 for lesson 1 - dimension 1', 'Explanation 3', 3, 1, 1),
('Question 4 for lesson 1 - dimension 1', 'Explanation 4', 1, 1, 1),
('Question 5 for lesson 1 - dimension 1', 'Explanation 5', 2, 1, 1),
('Question 1 for lesson 1 - dimension 2', 'Explanation 1', 3, 1, 2),
('Question 2 for lesson 1 - dimension 2', 'Explanation 2', 1, 1, 2),
('Question 3 for lesson 1 - dimension 2', 'Explanation 3', 2, 1, 2),
('Question 4 for lesson 1 - dimension 2', 'Explanation 4', 3, 1, 2),
('Question 5 for lesson 1 - dimension 2', 'Explanation 5', 1, 1, 2),
('Question 1 for lesson 1 - dimension 3', 'Explanation 1', 2, 1, 3),
('Question 2 for lesson 1 - dimension 3', 'Explanation 2', 3, 1, 3),
('Question 3 for lesson 1 - dimension 3', 'Explanation 3', 1, 1, 3),
('Question 4 for lesson 1 - dimension 3', 'Explanation 4', 2, 1, 3),
('Question 5 for lesson 1 - dimension 3', 'Explanation 5', 3, 1, 3),
('Question 1 for lesson 1 - dimension 4', 'Explanation 1', 1, 1, 4),
('Question 2 for lesson 1 - dimension 4', 'Explanation 2', 2, 1, 4),
('Question 3 for lesson 1 - dimension 4', 'Explanation 3', 3, 1, 4),
('Question 4 for lesson 1 - dimension 4', 'Explanation 4', 1, 1, 4),
('Question 5 for lesson 1 - dimension 4', 'Explanation 5', 2, 1, 4),
('Question 1 for lesson 2 - dimension 1', 'Explanation 1', 3, 2, 1),
('Question 2 for lesson 2 - dimension 1', 'Explanation 2', 1, 2, 1),
('Question 3 for lesson 2 - dimension 1', 'Explanation 3', 2, 2, 1),
('Question 4 for lesson 2 - dimension 1', 'Explanation 4', 3, 2, 1),
('Question 5 for lesson 2 - dimension 1', 'Explanation 5', 1, 2, 1),
('Question 1 for lesson 2 - dimension 2', 'Explanation 1', 2, 2, 2),
('Question 2 for lesson 2 - dimension 2', 'Explanation 2', 3, 2, 2),
('Question 3 for lesson 2 - dimension 2', 'Explanation 3', 1, 2, 2),
('Question 4 for lesson 2 - dimension 2', 'Explanation 4', 2, 2, 2),
('Question 5 for lesson 2 - dimension 2', 'Explanation 5', 3, 2, 2),
('Question 1 for lesson 2 - dimension 3', 'Explanation 1', 1, 2, 3),
('Question 2 for lesson 2 - dimension 3', 'Explanation 2', 2, 2, 3),
('Question 3 for lesson 2 - dimension 3', 'Explanation 3', 3, 2, 3),
('Question 4 for lesson 2 - dimension 3', 'Explanation 4', 1, 2, 3),
('Question 5 for lesson 2 - dimension 3', 'Explanation 5', 2, 2, 3),
('Question 1 for lesson 2 - dimension 4', 'Explanation 1', 3, 2, 4),
('Question 2 for lesson 2 - dimension 4', 'Explanation 2', 1, 2, 4),
('Question 3 for lesson 2 - dimension 4', 'Explanation 3', 2, 2, 4),
('Question 4 for lesson 2 - dimension 4', 'Explanation 4', 3, 2, 4),
('Question 5 for lesson 2 - dimension 4', 'Explanation 5', 1, 2, 4),
('Question 1 for lesson 3 - dimension 1', 'Explanation 1', 2, 3, 1),
('Question 2 for lesson 3 - dimension 1', 'Explanation 2', 3, 3, 1),
('Question 3 for lesson 3 - dimension 1', 'Explanation 3', 1, 3, 1),
('Question 4 for lesson 3 - dimension 1', 'Explanation 4', 2, 3, 1),
('Question 5 for lesson 3 - dimension 1', 'Explanation 5', 3, 3, 1),
('Question 1 for lesson 3 - dimension 2', 'Explanation 1', 1, 3, 2),
('Question 2 for lesson 3 - dimension 2', 'Explanation 2', 2, 3, 2),
('Question 3 for lesson 3 - dimension 2', 'Explanation 3', 3, 3, 2),
('Question 4 for lesson 3 - dimension 2', 'Explanation 4', 1, 3, 2),
('Question 5 for lesson 3 - dimension 2', 'Explanation 5', 2, 3, 2),
('Question 1 for lesson 3 - dimension 3', 'Explanation 1', 3, 3, 3),
('Question 2 for lesson 3 - dimension 3', 'Explanation 2', 1, 3, 3),
('Question 3 for lesson 3 - dimension 3', 'Explanation 3', 2, 3, 3),
('Question 4 for lesson 3 - dimension 3', 'Explanation 4', 3, 3, 3),
('Question 5 for lesson 3 - dimension 3', 'Explanation 5', 1, 3, 3),
('Question 1 for lesson 3 - dimension 4', 'Explanation 1', 2, 3, 4),
('Question 2 for lesson 3 - dimension 4', 'Explanation 2', 3, 3, 4),
('Question 3 for lesson 3 - dimension 4', 'Explanation 3', 1, 3, 4),
('Question 4 for lesson 3 - dimension 4', 'Explanation 4', 2, 3, 4),
('Question 5 for lesson 3 - dimension 4', 'Explanation 5', 3, 3, 4),
('Question 1 for lesson 4 - dimension 1', 'Explanation 1', 1, 4, 1),
('Question 2 for lesson 4 - dimension 1', 'Explanation 2', 2, 4, 1),
('Question 3 for lesson 4 - dimension 1', 'Explanation 3', 3, 4, 1),
('Question 4 for lesson 4 - dimension 1', 'Explanation 4', 1, 4, 1),
('Question 5 for lesson 4 - dimension 1', 'Explanation 5', 2, 4, 1),
('Question 1 for lesson 4 - dimension 2', 'Explanation 1', 3, 4, 2),
('Question 2 for lesson 4 - dimension 2', 'Explanation 2', 1, 4, 2),
('Question 3 for lesson 4 - dimension 2', 'Explanation 3', 2, 4, 2),
('Question 4 for lesson 4 - dimension 2', 'Explanation 4', 3, 4, 2),
('Question 5 for lesson 4 - dimension 2', 'Explanation 5', 1, 4, 2),
('Question 1 for lesson 4 - dimension 3', 'Explanation 1', 2, 4, 3),
('Question 2 for lesson 4 - dimension 3', 'Explanation 2', 3, 4, 3),
('Question 3 for lesson 4 - dimension 3', 'Explanation 3', 1, 4, 3),
('Question 4 for lesson 4 - dimension 3', 'Explanation 4', 2, 4, 3),
('Question 5 for lesson 4 - dimension 3', 'Explanation 5', 3, 4, 3),
('Question 1 for lesson 4 - dimension 4', 'Explanation 1', 1, 4, 4),
('Question 2 for lesson 4 - dimension 4', 'Explanation 2', 2, 4, 4),
('Question 3 for lesson 4 - dimension 4', 'Explanation 3', 3, 4, 4),
('Question 4 for lesson 4 - dimension 4', 'Explanation 4', 1, 4, 4),
('Question 5 for lesson 4 - dimension 4', 'Explanation 5', 2, 4, 4),
('Question 1 for lesson 5 - dimension 1', 'Explanation 1', 3, 5, 1),
('Question 2 for lesson 5 - dimension 1', 'Explanation 2', 1, 5, 1),
('Question 3 for lesson 5 - dimension 1', 'Explanation 3', 2, 5, 1),
('Question 4 for lesson 5 - dimension 1', 'Explanation 4', 3, 5, 1),
('Question 5 for lesson 5 - dimension 1', 'Explanation 5', 1, 5, 1),
('Question 1 for lesson 5 - dimension 2', 'Explanation 1', 2, 5, 2),
('Question 2 for lesson 5 - dimension 2', 'Explanation 2', 3, 5, 2),
('Question 3 for lesson 5 - dimension 2', 'Explanation 3', 1, 5, 2),
('Question 4 for lesson 5 - dimension 2', 'Explanation 4', 2, 5, 2),
('Question 5 for lesson 5 - dimension 2', 'Explanation 5', 3, 5, 2),
('Question 1 for lesson 5 - dimension 3', 'Explanation 1', 1, 5, 3),
('Question 2 for lesson 5 - dimension 3', 'Explanation 2', 2, 5, 3),
('Question 3 for lesson 5 - dimension 3', 'Explanation 3', 3, 5, 3),
('Question 4 for lesson 5 - dimension 3', 'Explanation 4', 1, 5, 3),
('Question 5 for lesson 5 - dimension 3', 'Explanation 5', 2, 5, 3),
('Question 1 for lesson 5 - dimension 4', 'Explanation 1', 3, 5, 4),
('Question 2 for lesson 5 - dimension 4', 'Explanation 2', 1, 5, 4),
('Question 3 for lesson 5 - dimension 4', 'Explanation 3', 2, 5, 4),
('Question 4 for lesson 5 - dimension 4', 'Explanation 4', 3, 5, 4),
('Question 5 for lesson 5 - dimension 4', 'Explanation 5', 1, 5, 4),
('Question 1 for lesson 6 - dimension 5', 'Explanation 1', 2, 6, 5),
('Question 2 for lesson 6 - dimension 5', 'Explanation 2', 3, 6, 5),
('Question 3 for lesson 6 - dimension 5', 'Explanation 3', 1, 6, 5),
('Question 4 for lesson 6 - dimension 5', 'Explanation 4', 2, 6, 5),
('Question 5 for lesson 6 - dimension 5', 'Explanation 5', 3, 6, 5),
('Question 1 for lesson 6 - dimension 6', 'Explanation 1', 1, 6, 6),
('Question 2 for lesson 6 - dimension 6', 'Explanation 2', 2, 6, 6),
('Question 3 for lesson 6 - dimension 6', 'Explanation 3', 3, 6, 6),
('Question 4 for lesson 6 - dimension 6', 'Explanation 4', 1, 6, 6),
('Question 5 for lesson 6 - dimension 6', 'Explanation 5', 2, 6, 6),
('Question 1 for lesson 6 - dimension 7', 'Explanation 1', 3, 6, 7),
('Question 2 for lesson 6 - dimension 7', 'Explanation 2', 1, 6, 7),
('Question 3 for lesson 6 - dimension 7', 'Explanation 3', 2, 6, 7),
('Question 4 for lesson 6 - dimension 7', 'Explanation 4', 3, 6, 7),
('Question 5 for lesson 6 - dimension 7', 'Explanation 5', 1, 6, 7),
('Question 1 for lesson 6 - dimension 8', 'Explanation 1', 2, 6, 8),
('Question 2 for lesson 6 - dimension 8', 'Explanation 2', 3, 6, 8),
('Question 3 for lesson 6 - dimension 8', 'Explanation 3', 1, 6, 8),
('Question 4 for lesson 6 - dimension 8', 'Explanation 4', 2, 6, 8),
('Question 5 for lesson 6 - dimension 8', 'Explanation 5', 3, 6, 8),
('Question 1 for lesson 7 - dimension 5', 'Explanation 1', 1, 7, 5),
('Question 2 for lesson 7 - dimension 5', 'Explanation 2', 2, 7, 5),
('Question 3 for lesson 7 - dimension 5', 'Explanation 3', 3, 7, 5),
('Question 4 for lesson 7 - dimension 5', 'Explanation 4', 1, 7, 5),
('Question 5 for lesson 7 - dimension 5', 'Explanation 5', 2, 7, 5),
('Question 1 for lesson 7 - dimension 6', 'Explanation 1', 3, 7, 6),
('Question 2 for lesson 7 - dimension 6', 'Explanation 2', 1, 7, 6),
('Question 3 for lesson 7 - dimension 6', 'Explanation 3', 2, 7, 6),
('Question 4 for lesson 7 - dimension 6', 'Explanation 4', 3, 7, 6),
('Question 5 for lesson 7 - dimension 6', 'Explanation 5', 1, 7, 6),
('Question 1 for lesson 7 - dimension 7', 'Explanation 1', 2, 7, 7),
('Question 2 for lesson 7 - dimension 7', 'Explanation 2', 3, 7, 7),
('Question 3 for lesson 7 - dimension 7', 'Explanation 3', 1, 7, 7),
('Question 4 for lesson 7 - dimension 7', 'Explanation 4', 2, 7, 7),
('Question 5 for lesson 7 - dimension 7', 'Explanation 5', 3, 7, 7),
('Question 1 for lesson 7 - dimension 8', 'Explanation 1', 1, 7, 8),
('Question 2 for lesson 7 - dimension 8', 'Explanation 2', 2, 7, 8),
('Question 3 for lesson 7 - dimension 8', 'Explanation 3', 3, 7, 8),
('Question 4 for lesson 7 - dimension 8', 'Explanation 4', 1, 7, 8),
('Question 5 for lesson 7 - dimension 8', 'Explanation 5', 2, 7, 8),
('Question 1 for lesson 8 - dimension 5', 'Explanation 1', 3, 8, 5),
('Question 2 for lesson 8 - dimension 5', 'Explanation 2', 1, 8, 5),
('Question 3 for lesson 8 - dimension 5', 'Explanation 3', 2, 8, 5),
('Question 4 for lesson 8 - dimension 5', 'Explanation 4', 3, 8, 5),
('Question 5 for lesson 8 - dimension 5', 'Explanation 5', 1, 8, 5),
('Question 1 for lesson 8 - dimension 6', 'Explanation 1', 2, 8, 6),
('Question 2 for lesson 8 - dimension 6', 'Explanation 2', 3, 8, 6),
('Question 3 for lesson 8 - dimension 6', 'Explanation 3', 1, 8, 6),
('Question 4 for lesson 8 - dimension 6', 'Explanation 4', 2, 8, 6),
('Question 5 for lesson 8 - dimension 6', 'Explanation 5', 3, 8, 6),
('Question 1 for lesson 8 - dimension 7', 'Explanation 1', 1, 8, 7),
('Question 2 for lesson 8 - dimension 7', 'Explanation 2', 2, 8, 7),
('Question 3 for lesson 8 - dimension 7', 'Explanation 3', 3, 8, 7),
('Question 4 for lesson 8 - dimension 7', 'Explanation 4', 1, 8, 7),
('Question 5 for lesson 8 - dimension 7', 'Explanation 5', 2, 8, 7),
('Question 1 for lesson 8 - dimension 8', 'Explanation 1', 3, 8, 8),
('Question 2 for lesson 8 - dimension 8', 'Explanation 2', 1, 8, 8),
('Question 3 for lesson 8 - dimension 8', 'Explanation 3', 2, 8, 8),
('Question 4 for lesson 8 - dimension 8', 'Explanation 4', 3, 8, 8),
('Question 5 for lesson 8 - dimension 8', 'Explanation 5', 1, 8, 8),
('Question 1 for lesson 9 - dimension 5', 'Explanation 1', 2, 9, 5),
('Question 2 for lesson 9 - dimension 5', 'Explanation 2', 3, 9, 5),
('Question 3 for lesson 9 - dimension 5', 'Explanation 3', 1, 9, 5),
('Question 4 for lesson 9 - dimension 5', 'Explanation 4', 2, 9, 5),
('Question 5 for lesson 9 - dimension 5', 'Explanation 5', 3, 9, 5),
('Question 1 for lesson 9 - dimension 6', 'Explanation 1', 1, 9, 6),
('Question 2 for lesson 9 - dimension 6', 'Explanation 2', 2, 9, 6),
('Question 3 for lesson 9 - dimension 6', 'Explanation 3', 3, 9, 6),
('Question 4 for lesson 9 - dimension 6', 'Explanation 4', 1, 9, 6),
('Question 5 for lesson 9 - dimension 6', 'Explanation 5', 2, 9, 6),
('Question 1 for lesson 9 - dimension 7', 'Explanation 1', 3, 9, 7),
('Question 2 for lesson 9 - dimension 7', 'Explanation 2', 1, 9, 7),
('Question 3 for lesson 9 - dimension 7', 'Explanation 3', 2, 9, 7),
('Question 4 for lesson 9 - dimension 7', 'Explanation 4', 3, 9, 7),
('Question 5 for lesson 9 - dimension 7', 'Explanation 5', 1, 9, 7),
('Question 1 for lesson 9 - dimension 8', 'Explanation 1', 2, 9, 8),
('Question 2 for lesson 9 - dimension 8', 'Explanation 2', 3, 9, 8),
('Question 3 for lesson 9 - dimension 8', 'Explanation 3', 1, 9, 8),
('Question 4 for lesson 9 - dimension 8', 'Explanation 4', 2, 9, 8),
('Question 5 for lesson 9 - dimension 8', 'Explanation 5', 3, 9, 8),
('Question 1 for lesson 10 - dimension 5', 'Explanation 1', 1, 10, 5),
('Question 2 for lesson 10 - dimension 5', 'Explanation 2', 2, 10, 5),
('Question 3 for lesson 10 - dimension 5', 'Explanation 3', 3, 10, 5),
('Question 4 for lesson 10 - dimension 5', 'Explanation 4', 1, 10, 5),
('Question 5 for lesson 10 - dimension 5', 'Explanation 5', 2, 10, 5),
('Question 1 for lesson 10 - dimension 6', 'Explanation 1', 3, 10, 6),
('Question 2 for lesson 10 - dimension 6', 'Explanation 2', 1, 10, 6),
('Question 3 for lesson 10 - dimension 6', 'Explanation 3', 2, 10, 6),
('Question 4 for lesson 10 - dimension 6', 'Explanation 4', 3, 10, 6),
('Question 5 for lesson 10 - dimension 6', 'Explanation 5', 1, 10, 6),
('Question 1 for lesson 10 - dimension 7', 'Explanation 1', 2, 10, 7),
('Question 2 for lesson 10 - dimension 7', 'Explanation 2', 3, 10, 7),
('Question 3 for lesson 10 - dimension 7', 'Explanation 3', 1, 10, 7),
('Question 4 for lesson 10 - dimension 7', 'Explanation 4', 2, 10, 7),
('Question 5 for lesson 10 - dimension 7', 'Explanation 5', 3, 10, 7),
('Question 1 for lesson 10 - dimension 8', 'Explanation 1', 1, 10, 8),
('Question 2 for lesson 10 - dimension 8', 'Explanation 2', 2, 10, 8),
('Question 3 for lesson 10 - dimension 8', 'Explanation 3', 3, 10, 8),
('Question 4 for lesson 10 - dimension 8', 'Explanation 4', 1, 10, 8),
('Question 5 for lesson 10 - dimension 8', 'Explanation 5', 2, 10, 8),
('Question 1 for lesson 11 - dimension 9', 'Explanation 1', 3, 11, 9),
('Question 2 for lesson 11 - dimension 9', 'Explanation 2', 1, 11, 9),
('Question 3 for lesson 11 - dimension 9', 'Explanation 3', 2, 11, 9),
('Question 4 for lesson 11 - dimension 9', 'Explanation 4', 3, 11, 9),
('Question 5 for lesson 11 - dimension 9', 'Explanation 5', 1, 11, 9),
('Question 1 for lesson 11 - dimension 10', 'Explanation 1', 2, 11, 10),
('Question 2 for lesson 11 - dimension 10', 'Explanation 2', 3, 11, 10),
('Question 3 for lesson 11 - dimension 10', 'Explanation 3', 1, 11, 10),
('Question 4 for lesson 11 - dimension 10', 'Explanation 4', 2, 11, 10),
('Question 5 for lesson 11 - dimension 10', 'Explanation 5', 3, 11, 10),
('Question 1 for lesson 11 - dimension 11', 'Explanation 1', 1, 11, 11),
('Question 2 for lesson 11 - dimension 11', 'Explanation 2', 2, 11, 11),
('Question 3 for lesson 11 - dimension 11', 'Explanation 3', 3, 11, 11),
('Question 4 for lesson 11 - dimension 11', 'Explanation 4', 1, 11, 11),
('Question 5 for lesson 11 - dimension 11', 'Explanation 5', 2, 11, 11),
('Question 1 for lesson 11 - dimension 12', 'Explanation 1', 3, 11, 12),
('Question 2 for lesson 11 - dimension 12', 'Explanation 2', 1, 11, 12),
('Question 3 for lesson 11 - dimension 12', 'Explanation 3', 2, 11, 12),
('Question 4 for lesson 11 - dimension 12', 'Explanation 4', 3, 11, 12),
('Question 5 for lesson 11 - dimension 12', 'Explanation 5', 1, 11, 12),
('Question 1 for lesson 12 - dimension 9', 'Explanation 1', 2, 12, 9),
('Question 2 for lesson 12 - dimension 9', 'Explanation 2', 3, 12, 9),
('Question 3 for lesson 12 - dimension 9', 'Explanation 3', 1, 12, 9),
('Question 4 for lesson 12 - dimension 9', 'Explanation 4', 2, 12, 9),
('Question 5 for lesson 12 - dimension 9', 'Explanation 5', 3, 12, 9),
('Question 1 for lesson 12 - dimension 10', 'Explanation 1', 1, 12, 10),
('Question 2 for lesson 12 - dimension 10', 'Explanation 2', 2, 12, 10),
('Question 3 for lesson 12 - dimension 10', 'Explanation 3', 3, 12, 10),
('Question 4 for lesson 12 - dimension 10', 'Explanation 4', 1, 12, 10),
('Question 5 for lesson 12 - dimension 10', 'Explanation 5', 2, 12, 10),
('Question 1 for lesson 12 - dimension 11', 'Explanation 1', 3, 12, 11),
('Question 2 for lesson 12 - dimension 11', 'Explanation 2', 1, 12, 11),
('Question 3 for lesson 12 - dimension 11', 'Explanation 3', 2, 12, 11),
('Question 4 for lesson 12 - dimension 11', 'Explanation 4', 3, 12, 11),
('Question 5 for lesson 12 - dimension 11', 'Explanation 5', 1, 12, 11),
('Question 1 for lesson 12 - dimension 12', 'Explanation 1', 2, 12, 12),
('Question 2 for lesson 12 - dimension 12', 'Explanation 2', 3, 12, 12),
('Question 3 for lesson 12 - dimension 12', 'Explanation 3', 1, 12, 12),
('Question 4 for lesson 12 - dimension 12', 'Explanation 4', 2, 12, 12),
('Question 5 for lesson 12 - dimension 12', 'Explanation 5', 3, 12, 12),
('Question 1 for lesson 13 - dimension 9', 'Explanation 1', 1, 13, 9),
('Question 2 for lesson 13 - dimension 9', 'Explanation 2', 2, 13, 9),
('Question 3 for lesson 13 - dimension 9', 'Explanation 3', 3, 13, 9),
('Question 4 for lesson 13 - dimension 9', 'Explanation 4', 1, 13, 9),
('Question 5 for lesson 13 - dimension 9', 'Explanation 5', 2, 13, 9),
('Question 1 for lesson 13 - dimension 10', 'Explanation 1', 3, 13, 10),
('Question 2 for lesson 13 - dimension 10', 'Explanation 2', 1, 13, 10),
('Question 3 for lesson 13 - dimension 10', 'Explanation 3', 2, 13, 10),
('Question 4 for lesson 13 - dimension 10', 'Explanation 4', 3, 13, 10),
('Question 5 for lesson 13 - dimension 10', 'Explanation 5', 1, 13, 10),
('Question 1 for lesson 13 - dimension 11', 'Explanation 1', 2, 13, 11),
('Question 2 for lesson 13 - dimension 11', 'Explanation 2', 3, 13, 11),
('Question 3 for lesson 13 - dimension 11', 'Explanation 3', 1, 13, 11),
('Question 4 for lesson 13 - dimension 11', 'Explanation 4', 2, 13, 11),
('Question 5 for lesson 13 - dimension 11', 'Explanation 5', 3, 13, 11),
('Question 1 for lesson 13 - dimension 12', 'Explanation 1', 1, 13, 12),
('Question 2 for lesson 13 - dimension 12', 'Explanation 2', 2, 13, 12),
('Question 3 for lesson 13 - dimension 12', 'Explanation 3', 3, 13, 12),
('Question 4 for lesson 13 - dimension 12', 'Explanation 4', 1, 13, 12),
('Question 5 for lesson 13 - dimension 12', 'Explanation 5', 2, 13, 12),
('Question 1 for lesson 14 - dimension 9', 'Explanation 1', 3, 14, 9),
('Question 2 for lesson 14 - dimension 9', 'Explanation 2', 1, 14, 9),
('Question 3 for lesson 14 - dimension 9', 'Explanation 3', 2, 14, 9),
('Question 4 for lesson 14 - dimension 9', 'Explanation 4', 3, 14, 9),
('Question 5 for lesson 14 - dimension 9', 'Explanation 5', 1, 14, 9),
('Question 1 for lesson 14 - dimension 10', 'Explanation 1', 2, 14, 10),
('Question 2 for lesson 14 - dimension 10', 'Explanation 2', 3, 14, 10),
('Question 3 for lesson 14 - dimension 10', 'Explanation 3', 1, 14, 10),
('Question 4 for lesson 14 - dimension 10', 'Explanation 4', 2, 14, 10),
('Question 5 for lesson 14 - dimension 10', 'Explanation 5', 3, 14, 10),
('Question 1 for lesson 14 - dimension 11', 'Explanation 1', 1, 14, 11),
('Question 2 for lesson 14 - dimension 11', 'Explanation 2', 2, 14, 11),
('Question 3 for lesson 14 - dimension 11', 'Explanation 3', 3, 14, 11),
('Question 4 for lesson 14 - dimension 11', 'Explanation 4', 1, 14, 11),
('Question 5 for lesson 14 - dimension 11', 'Explanation 5', 2, 14, 11),
('Question 1 for lesson 14 - dimension 12', 'Explanation 1', 3, 14, 12),
('Question 2 for lesson 14 - dimension 12', 'Explanation 2', 1, 14, 12),
('Question 3 for lesson 14 - dimension 12', 'Explanation 3', 2, 14, 12),
('Question 4 for lesson 14 - dimension 12', 'Explanation 4', 3, 14, 12),
('Question 5 for lesson 14 - dimension 12', 'Explanation 5', 1, 14, 12),
('Question 1 for lesson 15 - dimension 9', 'Explanation 1', 2, 15, 9),
('Question 2 for lesson 15 - dimension 9', 'Explanation 2', 3, 15, 9),
('Question 3 for lesson 15 - dimension 9', 'Explanation 3', 1, 15, 9),
('Question 4 for lesson 15 - dimension 9', 'Explanation 4', 2, 15, 9),
('Question 5 for lesson 15 - dimension 9', 'Explanation 5', 3, 15, 9),
('Question 1 for lesson 15 - dimension 10', 'Explanation 1', 1, 15, 10),
('Question 2 for lesson 15 - dimension 10', 'Explanation 2', 2, 15, 10),
('Question 3 for lesson 15 - dimension 10', 'Explanation 3', 3, 15, 10),
('Question 4 for lesson 15 - dimension 10', 'Explanation 4', 1, 15, 10),
('Question 5 for lesson 15 - dimension 10', 'Explanation 5', 2, 15, 10),
('Question 1 for lesson 15 - dimension 11', 'Explanation 1', 3, 15, 11),
('Question 2 for lesson 15 - dimension 11', 'Explanation 2', 1, 15, 11),
('Question 3 for lesson 15 - dimension 11', 'Explanation 3', 2, 15, 11),
('Question 4 for lesson 15 - dimension 11', 'Explanation 4', 3, 15, 11),
('Question 5 for lesson 15 - dimension 11', 'Explanation 5', 1, 15, 11),
('Question 1 for lesson 15 - dimension 12', 'Explanation 1', 2, 15, 12),
('Question 2 for lesson 15 - dimension 12', 'Explanation 2', 3, 15, 12),
('Question 3 for lesson 15 - dimension 12', 'Explanation 3', 1, 15, 12),
('Question 4 for lesson 15 - dimension 12', 'Explanation 4', 2, 15, 12),
('Question 5 for lesson 15 - dimension 12', 'Explanation 5', 3, 15, 12),
('Question 1 for lesson 16 - dimension 13', 'Explanation 1', 1, 16, 13),
('Question 2 for lesson 16 - dimension 13', 'Explanation 2', 2, 16, 13),
('Question 3 for lesson 16 - dimension 13', 'Explanation 3', 3, 16, 13),
('Question 4 for lesson 16 - dimension 13', 'Explanation 4', 1, 16, 13),
('Question 5 for lesson 16 - dimension 13', 'Explanation 5', 2, 16, 13),
('Question 1 for lesson 16 - dimension 14', 'Explanation 1', 3, 16, 14),
('Question 2 for lesson 16 - dimension 14', 'Explanation 2', 1, 16, 14),
('Question 3 for lesson 16 - dimension 14', 'Explanation 3', 2, 16, 14),
('Question 4 for lesson 16 - dimension 14', 'Explanation 4', 3, 16, 14),
('Question 5 for lesson 16 - dimension 14', 'Explanation 5', 1, 16, 14),
('Question 1 for lesson 16 - dimension 15', 'Explanation 1', 2, 16, 15),
('Question 2 for lesson 16 - dimension 15', 'Explanation 2', 3, 16, 15),
('Question 3 for lesson 16 - dimension 15', 'Explanation 3', 1, 16, 15),
('Question 4 for lesson 16 - dimension 15', 'Explanation 4', 2, 16, 15),
('Question 5 for lesson 16 - dimension 15', 'Explanation 5', 3, 16, 15),
('Question 1 for lesson 16 - dimension 16', 'Explanation 1', 1, 16, 16),
('Question 2 for lesson 16 - dimension 16', 'Explanation 2', 2, 16, 16),
('Question 3 for lesson 16 - dimension 16', 'Explanation 3', 3, 16, 16),
('Question 4 for lesson 16 - dimension 16', 'Explanation 4', 1, 16, 16),
('Question 5 for lesson 16 - dimension 16', 'Explanation 5', 2, 16, 16),
('Question 1 for lesson 17 - dimension 13', 'Explanation 1', 3, 17, 13),
('Question 2 for lesson 17 - dimension 13', 'Explanation 2', 1, 17, 13),
('Question 3 for lesson 17 - dimension 13', 'Explanation 3', 2, 17, 13),
('Question 4 for lesson 17 - dimension 13', 'Explanation 4', 3, 17, 13),
('Question 5 for lesson 17 - dimension 13', 'Explanation 5', 1, 17, 13),
('Question 1 for lesson 17 - dimension 14', 'Explanation 1', 2, 17, 14),
('Question 2 for lesson 17 - dimension 14', 'Explanation 2', 3, 17, 14),
('Question 3 for lesson 17 - dimension 14', 'Explanation 3', 1, 17, 14),
('Question 4 for lesson 17 - dimension 14', 'Explanation 4', 2, 17, 14),
('Question 5 for lesson 17 - dimension 14', 'Explanation 5', 3, 17, 14),
('Question 1 for lesson 17 - dimension 15', 'Explanation 1', 1, 17, 15),
('Question 2 for lesson 17 - dimension 15', 'Explanation 2', 2, 17, 15),
('Question 3 for lesson 17 - dimension 15', 'Explanation 3', 3, 17, 15),
('Question 4 for lesson 17 - dimension 15', 'Explanation 4', 1, 17, 15),
('Question 5 for lesson 17 - dimension 15', 'Explanation 5', 2, 17, 15),
('Question 1 for lesson 17 - dimension 16', 'Explanation 1', 3, 17, 16),
('Question 2 for lesson 17 - dimension 16', 'Explanation 2', 1, 17, 16),
('Question 3 for lesson 17 - dimension 16', 'Explanation 3', 2, 17, 16),
('Question 4 for lesson 17 - dimension 16', 'Explanation 4', 3, 17, 16),
('Question 5 for lesson 17 - dimension 16', 'Explanation 5', 1, 17, 16),
('Question 1 for lesson 18 - dimension 13', 'Explanation 1', 2, 18, 13),
('Question 2 for lesson 18 - dimension 13', 'Explanation 2', 3, 18, 13),
('Question 3 for lesson 18 - dimension 13', 'Explanation 3', 1, 18, 13),
('Question 4 for lesson 18 - dimension 13', 'Explanation 4', 2, 18, 13),
('Question 5 for lesson 18 - dimension 13', 'Explanation 5', 3, 18, 13),
('Question 1 for lesson 18 - dimension 14', 'Explanation 1', 1, 18, 14),
('Question 2 for lesson 18 - dimension 14', 'Explanation 2', 2, 18, 14),
('Question 3 for lesson 18 - dimension 14', 'Explanation 3', 3, 18, 14),
('Question 4 for lesson 18 - dimension 14', 'Explanation 4', 1, 18, 14),
('Question 5 for lesson 18 - dimension 14', 'Explanation 5', 2, 18, 14),
('Question 1 for lesson 18 - dimension 15', 'Explanation 1', 3, 18, 15),
('Question 2 for lesson 18 - dimension 15', 'Explanation 2', 1, 18, 15),
('Question 3 for lesson 18 - dimension 15', 'Explanation 3', 2, 18, 15),
('Question 4 for lesson 18 - dimension 15', 'Explanation 4', 3, 18, 15),
('Question 5 for lesson 18 - dimension 15', 'Explanation 5', 1, 18, 15),
('Question 1 for lesson 18 - dimension 16', 'Explanation 1', 2, 18, 16),
('Question 2 for lesson 18 - dimension 16', 'Explanation 2', 3, 18, 16),
('Question 3 for lesson 18 - dimension 16', 'Explanation 3', 1, 18, 16),
('Question 4 for lesson 18 - dimension 16', 'Explanation 4', 2, 18, 16),
('Question 5 for lesson 18 - dimension 16', 'Explanation 5', 3, 18, 16),
('Question 1 for lesson 19 - dimension 13', 'Explanation 1', 1, 19, 13),
('Question 2 for lesson 19 - dimension 13', 'Explanation 2', 2, 19, 13),
('Question 3 for lesson 19 - dimension 13', 'Explanation 3', 3, 19, 13),
('Question 4 for lesson 19 - dimension 13', 'Explanation 4', 1, 19, 13),
('Question 5 for lesson 19 - dimension 13', 'Explanation 5', 2, 19, 13),
('Question 1 for lesson 19 - dimension 14', 'Explanation 1', 3, 19, 14),
('Question 2 for lesson 19 - dimension 14', 'Explanation 2', 1, 19, 14),
('Question 3 for lesson 19 - dimension 14', 'Explanation 3', 2, 19, 14),
('Question 4 for lesson 19 - dimension 14', 'Explanation 4', 3, 19, 14),
('Question 5 for lesson 19 - dimension 14', 'Explanation 5', 1, 19, 14),
('Question 1 for lesson 19 - dimension 15', 'Explanation 1', 2, 19, 15),
('Question 2 for lesson 19 - dimension 15', 'Explanation 2', 3, 19, 15),
('Question 3 for lesson 19 - dimension 15', 'Explanation 3', 1, 19, 15),
('Question 4 for lesson 19 - dimension 15', 'Explanation 4', 2, 19, 15),
('Question 5 for lesson 19 - dimension 15', 'Explanation 5', 3, 19, 15),
('Question 1 for lesson 19 - dimension 16', 'Explanation 1', 1, 19, 16),
('Question 2 for lesson 19 - dimension 16', 'Explanation 2', 2, 19, 16),
('Question 3 for lesson 19 - dimension 16', 'Explanation 3', 3, 19, 16),
('Question 4 for lesson 19 - dimension 16', 'Explanation 4', 1, 19, 16),
('Question 5 for lesson 19 - dimension 16', 'Explanation 5', 2, 19, 16),
('Question 1 for lesson 20 - dimension 13', 'Explanation 1', 3, 20, 13),
('Question 2 for lesson 20 - dimension 13', 'Explanation 2', 1, 20, 13),
('Question 3 for lesson 20 - dimension 13', 'Explanation 3', 2, 20, 13),
('Question 4 for lesson 20 - dimension 13', 'Explanation 4', 3, 20, 13),
('Question 5 for lesson 20 - dimension 13', 'Explanation 5', 1, 20, 13),
('Question 1 for lesson 20 - dimension 14', 'Explanation 1', 2, 20, 14),
('Question 2 for lesson 20 - dimension 14', 'Explanation 2', 3, 20, 14),
('Question 3 for lesson 20 - dimension 14', 'Explanation 3', 1, 20, 14),
('Question 4 for lesson 20 - dimension 14', 'Explanation 4', 2, 20, 14),
('Question 5 for lesson 20 - dimension 14', 'Explanation 5', 3, 20, 14),
('Question 1 for lesson 20 - dimension 15', 'Explanation 1', 1, 20, 15),
('Question 2 for lesson 20 - dimension 15', 'Explanation 2', 2, 20, 15),
('Question 3 for lesson 20 - dimension 15', 'Explanation 3', 3, 20, 15),
('Question 4 for lesson 20 - dimension 15', 'Explanation 4', 1, 20, 15),
('Question 5 for lesson 20 - dimension 15', 'Explanation 5', 2, 20, 15),
('Question 1 for lesson 20 - dimension 16', 'Explanation 1', 3, 20, 16),
('Question 2 for lesson 20 - dimension 16', 'Explanation 2', 1, 20, 16),
('Question 3 for lesson 20 - dimension 16', 'Explanation 3', 2, 20, 16),
('Question 4 for lesson 20 - dimension 16', 'Explanation 4', 3, 20, 16),
('Question 5 for lesson 20 - dimension 16', 'Explanation 5', 1, 20, 16);

INSERT INTO [quiz_settings] ([number_question], [question_type])
VALUES 
(40, 'dimension'), (41, 'lesson'), (42, 'dimension'), (43, 'lesson'), (44, 'dimension'),
(45, 'lesson'), (46, 'dimension'), (47, 'lesson'), (48, 'dimension'), (49, 'lesson'),
(50, 'dimension'), (51, 'lesson'), (52, 'dimension'), (53, 'lesson'), (54, 'dimension'),
(55, 'lesson'), (56, 'dimension'), (57, 'lesson'), (58, 'dimension'), (59, 'lesson'),
(60, 'dimension'), (61, 'lesson'), (62, 'dimension'), (63, 'lesson'), (64, 'dimension'),
(65, 'lesson'), (66, 'dimension'), (67, 'lesson'), (68, 'dimension'), (69, 'lesson'),
(70, 'dimension'), (40, 'lesson'), (41, 'dimension'), (42, 'lesson'), (43, 'dimension'),
(44, 'lesson'), (45, 'dimension'), (46, 'lesson'), (47, 'dimension'), (48, 'lesson');

-- Insert 40 quizzes
INSERT INTO [quizzes] ([name], [level], [duration], [pass_rate], [description], [status], [test_type_id], [subject_id], [quiz_setting_id])
VALUES 
('Programming Fundamentals Quiz', 'Easy', 60, 70, 'Test your basic programming knowledge with variables, loops, and functions', 1, 1, 1, 1),
('Advanced Programming Challenge', 'Hard', 90, 80, 'Complex programming scenarios and algorithm design', 1, 2, 1, 2),
('SQL Basics Assessment', 'Easy', 45, 65, 'Basic SQL queries, SELECT statements, and simple joins', 1, 1, 2, 3),
('Database Design Quiz', 'Medium', 75, 75, 'Normalization, relationships, and database optimization', 1, 2, 2, 4),
('Network Protocols Test', 'Medium', 60, 70, 'TCP/IP, HTTP, DNS, and network troubleshooting', 1, 1, 3, 5),
('Advanced Networking', 'Hard', 120, 85, 'Subnetting, routing protocols, and network security', 1, 2, 3, 6),
('AI Fundamentals Quiz', 'Easy', 50, 65, 'Introduction to machine learning concepts and algorithms', 1, 1, 4, 7),
('Machine Learning Deep Dive', 'Hard', 100, 80, 'Advanced ML algorithms, neural networks, and deep learning', 1, 2, 4, 8),
('Cybersecurity Basics', 'Medium', 55, 70, 'Common threats, security measures, and best practices', 1, 1, 5, 9),
('Security Advanced Topics', 'Hard', 85, 85, 'Cryptography, penetration testing, and incident response', 1, 2, 5, 10),
('HTML & CSS Fundamentals', 'Easy', 40, 60, 'Basic web structure, styling, and responsive design', 1, 1, 6, 11),
('JavaScript Essentials', 'Medium', 65, 75, 'DOM manipulation, events, and asynchronous programming', 1, 2, 6, 12),
('Data Analysis Basics', 'Easy', 55, 65, 'Statistical concepts, data visualization, and basic analytics', 1, 1, 7, 13),
('Advanced Data Science', 'Hard', 95, 85, 'Complex statistical models, machine learning, and big data', 1, 2, 7, 14),
('Node.js Fundamentals', 'Medium', 70, 70, 'Server-side JavaScript, Express.js, and API development', 1, 1, 8, 15),
('Backend Architecture Quiz', 'Hard', 90, 80, 'Scalable systems, microservices, and database integration', 1, 2, 8, 16),
('Neural Networks Intro', 'Medium', 80, 75, 'Basic neural network concepts and training algorithms', 1, 1, 9, 17),
('Deep Learning Mastery', 'Hard', 110, 85, 'CNNs, RNNs, and advanced deep learning architectures', 1, 2, 9, 18),
('Programming Logic Test', 'Easy', 45, 65, 'Problem-solving with basic programming constructs', 1, 1, 1, 19),
('Object-Oriented Programming', 'Medium', 75, 75, 'Classes, inheritance, polymorphism, and design patterns', 1, 2, 1, 20),
('Database Queries Advanced', 'Hard', 85, 80, 'Complex joins, subqueries, and performance optimization', 1, 1, 2, 21),
('SQL Performance Tuning', 'Hard', 90, 85, 'Index optimization, query plans, and database tuning', 1, 2, 2, 22),
('Network Security Basics', 'Medium', 60, 70, 'Firewalls, VPNs, and network attack prevention', 1, 1, 3, 23),
('Enterprise Networking', 'Hard', 105, 85, 'Large-scale network design and management', 1, 2, 3, 24),
('AI Ethics and Applications', 'Easy', 50, 65, 'Responsible AI, bias detection, and real-world applications', 1, 1, 4, 25),
('Computer Vision Basics', 'Medium', 80, 75, 'Image processing, feature detection, and CNN applications', 1, 2, 4, 26),
('Information Security', 'Easy', 55, 65, 'Data protection, access control, and security policies', 1, 1, 5, 27),
('Ethical Hacking Intro', 'Hard', 95, 85, 'Penetration testing, vulnerability assessment, and tools', 1, 2, 5, 28),
('React Fundamentals', 'Medium', 70, 70, 'Component-based development, state management, and hooks', 1, 1, 6, 29),
('Full-Stack Development', 'Hard', 100, 80, 'End-to-end web application development', 1, 2, 6, 30),
('Statistical Analysis', 'Medium', 75, 75, 'Hypothesis testing, regression analysis, and statistical inference', 1, 1, 7, 31),
('Big Data Analytics', 'Hard', 110, 85, 'Hadoop, Spark, and large-scale data processing', 1, 2, 7, 32),
('RESTful API Design', 'Medium', 65, 70, 'API best practices, authentication, and documentation', 1, 1, 8, 33),
('Microservices Architecture', 'Hard', 95, 85, 'Distributed systems, containerization, and service mesh', 1, 2, 8, 34),
('TensorFlow Basics', 'Medium', 80, 75, 'Building and training models with TensorFlow', 1, 1, 9, 35),
('Advanced Deep Learning', 'Hard', 120, 85, 'GANs, transfer learning, and model optimization', 1, 2, 9, 36),
('Web Development Basics', 'Easy', 50, 60, 'HTML5, CSS3, and basic JavaScript concepts', 1, 1, 6, 37),
('Database Administration', 'Medium', 85, 75, 'Backup, recovery, and database maintenance', 1, 2, 2, 38),
('Cloud Computing Intro', 'Easy', 60, 65, 'Cloud services, deployment models, and basic concepts', 1, 1, 3, 39),
('DevOps Fundamentals', 'Medium', 75, 70, 'CI/CD, automation, and infrastructure as code', 1, 2, 8, 40),

('q1', 'Easy', 50, 60, 'HTML5, CSS3, and basic JavaScript concepts', 1, 1, 1, 1),
('q2', 'Medium', 85, 75, 'Backup, recovery, and database maintenance', 1, 1, 10, 1),
('q3', 'Easy', 60, 65, 'Cloud services, deployment models, and basic concepts', 1, 1, 10, 1),
('q4', 'Medium', 75, 70, 'CI/CD, automation, and infrastructure as code', 1, 1, 10, 40),
('q5', 'Easy', 50, 60, 'HTML5, CSS3, and basic JavaScript concepts', 1, 1, 1, 1),
('q6', 'Medium', 85, 75, 'Backup, recovery, and database maintenance', 1, 1, 10, 1),
('q7', 'Easy', 60, 65, 'Cloud services, deployment models, and basic concepts', 1, 1, 10, 1),
('q8', 'Medium', 75, 70, 'CI/CD, automation, and infrastructure as code', 1, 1, 10, 40),
('q9', 'Easy', 50, 60, 'HTML5, CSS3, and basic JavaScript concepts', 1, 1, 1, 1),
('q10', 'Medium', 85, 75, 'Backup, recovery, and database maintenance', 1, 1, 10, 1),
('q11', 'Easy', 60, 65, 'Cloud services, deployment models, and basic concepts', 1, 1, 1, 1),
('q12', 'Medium', 75, 70, 'CI/CD, automation, and infrastructure as code', 1, 1, 10, 40);

SET NOCOUNT ON;

DECLARE @question_id INT = 1;
DECLARE @correct_option INT;

WHILE @question_id <= 400
BEGIN
    SET @correct_option = FLOOR(RAND() * 4) + 1;

    INSERT INTO [question_options] (option_content, is_answer, question_id)
    VALUES 
        ('Option A', IIF(@correct_option = 1, 1, 0), @question_id),
        ('Option B', IIF(@correct_option = 2, 1, 0), @question_id),
        ('Option C', IIF(@correct_option = 3, 1, 0), @question_id),
        ('Option D', IIF(@correct_option = 4, 1, 0), @question_id);

    SET @question_id += 1;
END

-- Insert quiz_setting_groups records
-- Each quiz_setting can have multiple groups
-- Each group contains different lessons OR dimensions (not mixed)
-- Total number_question across all groups for same quiz_setting_id equals number_question in quiz_settings
-- Based on question_type: 'lesson' groups -> subject_lesson_id populated, 'dimension' groups -> subject_dimension_id populated

INSERT INTO [quiz_setting_groups] ([number_question], [subject_lesson_id], [subject_dimension_id], [quiz_setting_id])
VALUES 
-- Quiz Setting ID 1: 40 questions total, type 'dimension' -> split across multiple dimensions
(15, NULL, 1, 1),  -- Variables and Data Types
(12, NULL, 2, 1),  -- Control Structures  
(8, NULL, 3, 1),   -- Programming Tools
(5, NULL, 4, 1),   -- Problem Solving

-- Quiz Setting ID 2: 41 questions total, type 'lesson' -> split across multiple lessons
(12, 1, NULL, 2),  -- Intro to Programming
(10, 2, NULL, 2),  -- Variables in Programming
(10, 3, NULL, 2),  -- Control Flow
(9, 4, NULL, 2),   -- Functions and Methods

-- Quiz Setting ID 3: 42 questions total, type 'dimension' -> split across SQL dimensions
(15, NULL, 5, 3),  -- SQL Basics
(12, NULL, 6, 3),  -- Joins & Relationships
(10, NULL, 7, 3),  -- SQL Platforms
(5, NULL, 8, 3),   -- Database Design

-- Quiz Setting ID 4: 43 questions total, type 'lesson' -> split across SQL lessons
(12, 6, NULL, 4),  -- Intro to SQL
(11, 7, NULL, 4),  -- SELECT Statements
(10, 8, NULL, 4),  -- Filtering with WHERE
(10, 9, NULL, 4),  -- JOIN Operations

-- Quiz Setting ID 5: 44 questions total, type 'dimension' -> split across Network dimensions
(15, NULL, 9, 5),  -- Network Fundamentals
(12, NULL, 10, 5), -- Subnetting & Routing
(10, NULL, 11, 5), -- Network Tools
(7, NULL, 12, 5),  -- Troubleshooting

-- Quiz Setting ID 6: 45 questions total, type 'lesson' -> split across Network lessons
(12, 11, NULL, 6), -- Intro to Networking
(11, 12, NULL, 6), -- IP Addressing
(11, 13, NULL, 6), -- Subnetting Explained
(11, 14, NULL, 6), -- Common Protocols

-- Quiz Setting ID 7: 46 questions total, type 'dimension' -> split across AI dimensions
(15, NULL, 13, 7), -- AI Concepts
(12, NULL, 14, 7), -- Machine Learning Basics
(10, NULL, 15, 7), -- Python Libraries
(9, NULL, 16, 7),  -- AI Applications

-- Quiz Setting ID 8: 47 questions total, type 'lesson' -> split across AI lessons
(12, 16, NULL, 8), -- What is AI?
(12, 17, NULL, 8), -- Types of Learning
(12, 18, NULL, 8), -- Working with Data
(11, 19, NULL, 8), -- Intro to Python Libraries

-- Quiz Setting ID 9: 48 questions total, type 'dimension' -> mixed dimensions from different subjects
(15, NULL, 1, 9),  -- Variables and Data Types (Programming)
(12, NULL, 5, 9),  -- SQL Basics
(10, NULL, 9, 9),  -- Network Fundamentals
(11, NULL, 13, 9), -- AI Concepts

-- Quiz Setting ID 10: 49 questions total, type 'lesson' -> mixed lessons
(13, 1, NULL, 10), -- Intro to Programming
(12, 6, NULL, 10), -- Intro to SQL
(12, 11, NULL, 10), -- Intro to Networking
(12, 16, NULL, 10), -- What is AI?

-- Quiz Setting ID 11: 50 questions total, type 'dimension'
(18, NULL, 2, 11), -- Control Structures
(16, NULL, 6, 11), -- Joins & Relationships
(16, NULL, 10, 11), -- Subnetting & Routing

-- Quiz Setting ID 12: 51 questions total, type 'lesson'
(17, 2, NULL, 12), -- Variables in Programming
(17, 7, NULL, 12), -- SELECT Statements
(17, 12, NULL, 12), -- IP Addressing

-- Quiz Setting ID 13: 52 questions total, type 'dimension'
(20, NULL, 3, 13), -- Programming Tools
(16, NULL, 7, 13), -- SQL Platforms
(16, NULL, 11, 13), -- Network Tools

-- Quiz Setting ID 14: 53 questions total, type 'lesson'
(18, 3, NULL, 14), -- Control Flow
(18, 8, NULL, 14), -- Filtering with WHERE
(17, 13, NULL, 14), -- Subnetting Explained

-- Quiz Setting ID 15: 54 questions total, type 'dimension'
(18, NULL, 4, 15), -- Problem Solving
(18, NULL, 8, 15), -- Database Design
(18, NULL, 12, 15), -- Troubleshooting

-- Quiz Setting ID 16: 55 questions total, type 'lesson'
(18, 4, NULL, 16), -- Functions and Methods
(19, 9, NULL, 16), -- JOIN Operations
(18, 14, NULL, 16), -- Common Protocols

-- Quiz Setting ID 17: 56 questions total, type 'dimension'
(20, NULL, 14, 17), -- Machine Learning Basics
(18, NULL, 15, 17), -- Python Libraries
(18, NULL, 16, 17), -- AI Applications

-- Quiz Setting ID 18: 57 questions total, type 'lesson'
(19, 17, NULL, 18), -- Types of Learning
(19, 18, NULL, 18), -- Working with Data
(19, 19, NULL, 18), -- Intro to Python Libraries

-- Quiz Setting ID 19: 58 questions total, type 'dimension'
(20, NULL, 1, 19), -- Variables and Data Types
(19, NULL, 2, 19), -- Control Structures
(19, NULL, 3, 19), -- Programming Tools

-- Quiz Setting ID 20: 59 questions total, type 'lesson'
(15, 5, NULL, 20), -- Project: Simple Calculator
(15, 10, NULL, 20), -- SQL Project: Report System
(15, 15, NULL, 20), -- Networking Lab
(14, 20, NULL, 20), -- Mini AI Project

-- Quiz Setting ID 21: 60 questions total, type 'dimension'
(20, NULL, 5, 21), -- SQL Basics
(20, NULL, 6, 21), -- Joins & Relationships
(20, NULL, 7, 21), -- SQL Platforms

-- Quiz Setting ID 22: 61 questions total, type 'lesson'
(21, 6, NULL, 22), -- Intro to SQL
(20, 7, NULL, 22), -- SELECT Statements
(20, 8, NULL, 22), -- Filtering with WHERE

-- Quiz Setting ID 23: 62 questions total, type 'dimension'
(21, NULL, 9, 23), -- Network Fundamentals
(21, NULL, 10, 23), -- Subnetting & Routing
(20, NULL, 11, 23), -- Network Tools

-- Quiz Setting ID 24: 63 questions total, type 'lesson'
(21, 11, NULL, 24), -- Intro to Networking
(21, 12, NULL, 24), -- IP Addressing
(21, 13, NULL, 24), -- Subnetting Explained

-- Quiz Setting ID 25: 64 questions total, type 'dimension'
(22, NULL, 13, 25), -- AI Concepts
(21, NULL, 14, 25), -- Machine Learning Basics
(21, NULL, 15, 25), -- Python Libraries

-- Quiz Setting ID 26: 65 questions total, type 'lesson'
(22, 16, NULL, 26), -- What is AI?
(22, 17, NULL, 26), -- Types of Learning
(21, 18, NULL, 26), -- Working with Data

-- Quiz Setting ID 27: 66 questions total, type 'dimension'
(22, NULL, 4, 27), -- Problem Solving
(22, NULL, 8, 27), -- Database Design
(22, NULL, 12, 27), -- Troubleshooting

-- Quiz Setting ID 28: 67 questions total, type 'lesson'
(23, 4, NULL, 28), -- Functions and Methods
(22, 9, NULL, 28), -- JOIN Operations
(22, 14, NULL, 28), -- Common Protocols

-- Quiz Setting ID 29: 68 questions total, type 'dimension'
(23, NULL, 16, 29), -- AI Applications
(23, NULL, 1, 29), -- Variables and Data Types
(22, NULL, 5, 29), -- SQL Basics

-- Quiz Setting ID 30: 69 questions total, type 'lesson'
(23, 19, NULL, 30), -- Intro to Python Libraries
(23, 20, NULL, 30), -- Mini AI Project
(23, 1, NULL, 30), -- Intro to Programming

-- Quiz Setting ID 31: 70 questions total, type 'dimension'
(24, NULL, 2, 31), -- Control Structures
(23, NULL, 6, 31), -- Joins & Relationships
(23, NULL, 10, 31), -- Subnetting & Routing

-- Quiz Setting ID 32: 40 questions total, type 'lesson'
(20, 2, NULL, 32), -- Variables in Programming
(20, 7, NULL, 32), -- SELECT Statements

-- Quiz Setting ID 33: 41 questions total, type 'dimension'
(21, NULL, 3, 33), -- Programming Tools
(20, NULL, 7, 33), -- SQL Platforms

-- Quiz Setting ID 34: 42 questions total, type 'lesson'
(21, 3, NULL, 34), -- Control Flow
(21, 8, NULL, 34), -- Filtering with WHERE

-- Quiz Setting ID 35: 43 questions total, type 'dimension'
(22, NULL, 11, 35), -- Network Tools
(21, NULL, 15, 35), -- Python Libraries

-- Quiz Setting ID 36: 44 questions total, type 'lesson'
(22, 12, NULL, 36), -- IP Addressing
(22, 17, NULL, 36), -- Types of Learning

-- Quiz Setting ID 37: 45 questions total, type 'dimension'
(23, NULL, 9, 37), -- Network Fundamentals
(22, NULL, 13, 37), -- AI Concepts

-- Quiz Setting ID 38: 46 questions total, type 'lesson'
(23, 13, NULL, 38), -- Subnetting Explained
(23, 18, NULL, 38), -- Working with Data

-- Quiz Setting ID 39: 47 questions total, type 'dimension'
(24, NULL, 14, 39), -- Machine Learning Basics
(23, NULL, 4, 39), -- Problem Solving

-- Quiz Setting ID 40: 48 questions total, type 'lesson'
(24, 15, NULL, 40), -- Networking Lab
(24, 20, NULL, 40); -- Mini AI Project

INSERT INTO [practices]([name],[number_question],[subject_lesson_id],[subject_dimension_id] ,[user_id]) VALUES
('Practice 1', 20, 1, NULL, 2),
('Practice 2', 30, 2, NULL, 2),
('Practice 3', 25, NULL, 1, 2),
('Practice 4', 20, NULL, 3, 2),
('Practice 5', 30, 4, NULL, 2);

INSERT INTO [practice_question_levels]([practice_id], [question_level_id])  VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 2),
(2, 1),
(3, 3),
(4, 1),
(5, 2);

INSERT INTO [exam_attempts]([type], [duration], [number_correct_question], [user_id], [quiz_id], [practice_id]) VALUES
('Practice', 1*60*60 + 162, 15, 2, NULL, 1),
('Practice', 1*60*60 + 300, 15, 2, NULL, 2),
('Practice', 1*60*60 + 104, 15, 2, NULL, 3),
('Practice', 1*60*60 + 123, 15, 2, NULL, 4),
('Practice', 1*60*60 + 456, 15, 2, NULL, 5),
('Quiz', 50*60, 30, 4, 1, NULL);

INSERT INTO [subject_description_images]([subject_id], [url], [caption])
VALUES
(1, 'Test1.jpg', 'This is 1st image'),
(1, 'Test2.jpg', 'This is 2nd image'),
(1, 'Test3.jpg', 'This is 3rd image');