USE [quiz_practicing_system]
GO

-- system_settings
INSERT INTO [system_settings] ([type], [value], [description], [status], [mandatory])
VALUES 
('User Roles', 'Admin', 'System administrator with full access', 1, 1),
('User Roles', 'Expert', 'Expert responsible for providing answers and content', 1, 1),
('User Roles', 'Customer', 'Regular user with limited permissions', 1, 1),
('User Roles', 'Sale', 'The sale members of the organization ', 1, 1),
('Subject Categories', 'Programming', 'Topics related to programming languages and software development', 1, 1),
('Subject Categories', 'Database', 'Subjects covering relational databases and SQL queries', 1, 1),
('Subject Categories', 'Network', 'Topics related to computer networks and communication protocols', 1, 1),
('Subject Categories', 'AI', 'Artificial Intelligence and Machine Learning concepts', 1, 1),
('Subject Categories', 'Security', 'Cybersecurity principles and practices', 1, 1),
('Subject Categories', 'Web', 'Frontend and backend web development topics', 1, 1),
('Subject Categories', 'Data Science', 'Data analysis, visualization, and machine learning', 1, 1),
('Test Types', 'Simulation', 'Full test simulation under exam conditions', 1, 1),
('Test Types', 'Lesson-Quiz', 'Short quizzes for each lesson or topic', 1, 1),
('Question Levels', 'Hard', 'Challenging questions for advanced learners', 1, 1),
('Question Levels', 'Medium', 'Moderate difficulty questions for practice', 1, 1),
('Question Levels', 'Easy', 'Basic questions for beginners or review', 1, 1),
('Lesson Types', 'Lesson', 'In-depth lesson material for study', 1, 1),
('Lesson Types', 'Quiz', 'Practice quiz to assess understanding', 1, 1);

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
    ('expert6@example.com', '9IvR609uK4oh0w4QpeapLfvPBB37oA5EmVTjpF/liwQ=', N'Faye Ngo', 0, '0920000006', N'33 Phan Xich Long, Phu Nhuan District, HCM City', 1, 2, NULL, NULL),
    ('sale1@example.com', '9IvR609uK4oh0w4QpeapLfvPBB37oA5EmVTjpF/liwQ=', N'Faye Ngo', 0, '0920000007', N'33 Phan Xich Long, Phu Nhuan District, HCM City', 1, 4, NULL, NULL),
    ('sale2@example.com', '9IvR609uK4oh0w4QpeapLfvPBB37oA5EmVTjpF/liwQ=', N'Faye Ngo', 0, '0920000008', N'33 Phan Xich Long, Phu Nhuan District, HCM City', 1, 4, NULL, NULL);

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
    ('Premium', null, 300.99, 249.99, 'Full access for every time', 1, 29),
-- Subject ID 30
    ('Bronze', 1, 49.99, 29.99, 'Basic access for one month', 1, 30),
    ('Silver', 3, 99.99, 59.99, 'Standard access for three months', 1, 30),
    ('Gold', 6, 199.99, 99.99, 'Full access for six months', 1, 30),
    ('Premium', null, 300.99, 249.99, 'Full access for every time', 1, 30);

INSERT INTO [registrations] ([time], [total_cost], [duration], [valid_from], [valid_to], [status], [price_package_id], [user_id], [last_updated_by]) VALUES
    ('2025-05-19 08:50:00.000', 29.99, 1,'2025-05-20 09:00:00.000', '2025-06-20 09:00:00.000', 'Paid', 1, 2, 28),
    ('2025-06-09 08:50:00.000', 49.99, 3,null, null, 'Pending Confirmation', 5, 2, null),
    ('2025-06-09 08:50:00.000', 49.99, 3,null, null, 'Pending Payment', 8, 2, 29),
    ('2024-06-19 08:50:00.000', 114.99, 6,'2024-06-20 09:00:00.000', '2024-12-20 09:00:00.000', 'Expired', 27, 2, 28),
    ('2025-06-05 08:50:00.000', 99.99, 6,null, null, 'Canceled', 24, 2, null),
    ('2025-06-05 08:50:00.000', 99.99, 6,null, null, 'Rejected', 21, 2, 29),
    ('2025-03-11 08:50:00.000', 249.99, null, null, null, 'Pending Confirmation', 88, 2, null),
    ('2025-03-11 08:50:00.000', 249.99, null,'2025-03-13 09:00:00.000', null, 'Paid', 92, 2, 28),
    ('2025-05-19 08:50:00.000', 29.99, 1,'2025-05-20 09:00:00.000', '2025-06-20 09:00:00.000', 'Paid', 1, 3, 28),
    ('2025-06-09 08:50:00.000', 49.99, 3,null, null, 'Pending Confirmation', 5, 4, null),
    ('2025-06-09 08:50:00.000', 49.99, 3,null, null, 'Pending Payment', 8, 5, 29),
    ('2024-06-19 08:50:00.000', 114.99, 6,'2024-06-20 09:00:00.000', '2024-12-20 09:00:00.000', 'Expired', 27, 6, 28),
    ('2025-06-05 08:50:00.000', 99.99, 6,null, null, 'Canceled', 24, 7, null),
    ('2025-06-05 08:50:00.000', 99.99, 6,null, null, 'Rejected', 21, 8, 29);

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

-- Questions (ID 1 - 10) - Dimension 1: Variables and Data Types
INSERT INTO questions (content, explaination, question_format, question_level_id, subject_lesson_id, subject_dimension_id) VALUES
                                                                                                                               ('Which of the following are primitive data types in Java?', 'Primitive types include int, boolean, etc.', 'multiple', 1, NULL, 1),
                                                                                                                               ('Which of the following is a valid way to declare an integer variable?', 'Only option with type and variable name correctly used is valid.', 'multiple', 1, NULL, 1),
                                                                                                                               ('Which methods can convert a string to an integer in Java?', 'parseInt and valueOf can both be used.', 'multiple', 2, NULL, 1),
                                                                                                                               ('Which of the following is a valid Java variable name?', 'Java variable names must follow rules: can’t start with digits, no keywords.', 'multiple', 1, NULL, 1),
                                                                                                                               ('What type of value can a boolean variable store in Java?', 'Boolean values are only true or false.', 'multiple', 1, NULL, 1),
                                                                                                                               ('Explain the difference between primitive and reference data types in Java.', 'Primitive types store actual values, reference types store memory addresses.', 'essay', 2, NULL, 1),
                                                                                                                               ('Describe the default values of primitive data types in Java.', 'Each primitive type has a defined default (e.g., int is 0).', 'essay', 2, NULL, 1),
                                                                                                                               ('How does type casting work in Java? Provide examples.', 'Casting allows converting one data type to another.', 'essay', 3, NULL, 1),
                                                                                                                               ('Discuss the memory allocation of primitive vs reference types.', 'Primitive types go on the stack; references point to heap objects.', 'essay', 3, NULL, 1),
                                                                                                                               ('Explain how variable scope affects accessibility in Java.', 'Variable scope determines where a variable can be accessed.', 'essay', 2, NULL, 1);

-- Options for Multiple Choice (Q1 → Q5)
INSERT INTO question_options (question_id, option_content, is_answer) VALUES
-- Q1: multiple answers
(1, 'int', 1),
(1, 'String', 0),
(1, 'boolean', 1),
(1, 'double', 1),
(1, 'ArrayList', 0),

-- Q2: only 1 correct answer
(2, 'int number = 5;', 1),
(2, 'number = int 5;', 0),
(2, 'declare int number = 5;', 0),
(2, 'let number = 5;', 0),

-- Q3: multiple answers
(3, 'Integer.parseInt("123")', 1),
(3, 'Integer.valueOf("123")', 1),
(3, 'String.toInteger("123")', 0),
(3, 'new Integer("123")', 1),

-- Q4: only 1 correct answer
(4, '2value', 0),
(4, '_value', 1),
(4, 'class', 0),
(4, 'value$', 0),

-- Q5: only 1 correct answer
(5, 'true', 1),
(5, 'false', 0),
(5, '1', 0),
(5, 'null', 0);

-- Questions (ID 11 - 30) - Dimension 2: Control Structures
INSERT INTO questions (content, explaination, question_format, question_level_id, subject_lesson_id, subject_dimension_id) VALUES
-- MULTIPLE - one answer
( 'Which keyword is used for a conditional branch in Java?', 'The "if" keyword introduces a conditional branch.', 'multiple', 1, NULL, 2),
( 'Which of the following is a valid while loop?', 'The correct syntax uses while(condition).', 'multiple', 1, NULL, 2),
( 'Which of the following keywords exits the current loop?', 'The "break" statement is used to exit loops.', 'multiple', 1, NULL, 2),
( 'Which of these is a valid syntax for a for loop?', 'The for loop has three parts: init, condition, update.', 'multiple', 2, NULL, 2),
( 'Which of these statements checks multiple values in Java?', 'Switch is used for checking multiple discrete values.', 'multiple', 1, NULL, 2),
( 'Which type of loop is guaranteed to execute at least once?', 'do-while loop runs at least once before checking the condition.', 'multiple', 2, NULL, 2),
( 'Which statement is used to skip an iteration?', 'The continue statement skips the current iteration.', 'multiple', 2, NULL, 2),
( 'Which of these is a ternary operator?', 'The ternary operator is written as condition ? trueVal : falseVal.', 'multiple', 2, NULL, 2),
( 'What is the output of: if (false) { System.out.println("Hi"); }?', 'Since the condition is false, the statement will not run.', 'multiple', 1, NULL, 2),
( 'Which control structure handles multiple branches based on one variable?', 'Switch handles multiple branches based on a variable.', 'multiple', 1, NULL, 2),

-- MULTIPLE - multiple answers
( 'Which of the following are valid loop structures in Java?', 'Java supports for, while, and do-while loops.', 'multiple', 2, NULL, 2),
( 'Which of the following can be used in a switch statement?', 'switch supports int, char, String, enums.', 'multiple', 3, NULL, 2),
( 'Which statements control flow in Java?', 'Control flow includes if, switch, break, continue.', 'multiple', 2, NULL, 2),
( 'Which are possible results of using break inside a loop?', 'Break exits the loop, sometimes prematurely.', 'multiple', 3, NULL, 2),
( 'Which of the following affect loop conditions?', 'Conditions may involve counters, booleans, function calls.', 'multiple', 2, NULL, 2),

-- ESSAY
( 'Explain how if-else statements work in Java with an example.', 'if-else allows conditional branching.', 'essay', 1, NULL, 2),
( 'Describe differences between while and do-while loops.', 'do-while executes once before checking the condition.', 'essay', 2, NULL, 2),
( 'How does a switch statement improve code readability?', 'switch makes multiple condition checks more concise.', 'essay', 2, NULL, 2),
( 'Discuss the importance of break and continue in loops.', 'They control flow inside loops.', 'essay', 3, NULL, 2),
( 'Write a program using nested loops and explain its logic.', 'Nested loops are useful for 2D iterations.', 'essay', 3, NULL, 2);


-- Options for MULTIPLE (Q11 → Q25)
INSERT INTO question_options (question_id, option_content, is_answer) VALUES
-- One-answer questions
(11, 'if', 1), (11, 'loop', 0), (11, 'for', 0), (11, 'switch', 0),
(12, 'while (x < 10) { }', 1), (12, 'loop x < 10 {}', 0), (12, 'x < 10 while', 0), (12, 'if (x < 10) loop', 0),
(13, 'break', 1), (13, 'return', 0), (13, 'stop', 0), (13, 'exit', 0),
(14, 'for (int i = 0; i < 10; i++)', 1), (14, 'loop int i = 0', 0), (14, 'for (i < 10)', 0), (14, 'int for (i=0)', 0),
(15, 'switch', 1), (15, 'if', 0), (15, 'for', 0), (15, 'else', 0),
(16, 'do-while', 1), (16, 'while', 0), (16, 'for', 0), (16, 'if', 0),
(17, 'continue', 1), (17, 'break', 0), (17, 'return', 0), (17, 'exit', 0),
(18, '?:', 1), (18, '++', 0), (18, '==', 0), (18, '&&', 0),
(19, 'No output', 1), (19, 'Hi', 0), (19, 'Error', 0), (19, 'Runtime Exception', 0),
(20, 'switch', 1), (20, 'if', 0), (20, 'for', 0), (20, 'while', 0),

-- Multi-answer questions
(21, 'for', 1), (21, 'while', 1), (21, 'do-while', 1), (21, 'loop', 0),
(22, 'int', 1), (22, 'String', 1), (22, 'boolean', 0), (22, 'enum', 1),
(23, 'if', 1), (23, 'switch', 1), (23, 'break', 1), (23, 'System.out.println', 0),
(24, 'Exit current loop', 1), (24, 'Skip to next iteration', 0), (24, 'Exit program', 0), (24, 'Continue outer loop', 0),
(25, 'Counter variables', 1), (25, 'Boolean conditions', 1), (25, 'Function results', 1), (25, 'Print statements', 0);

-- Questions (ID 31 - 50) - Dimension 3: Programming Tools
INSERT INTO questions (content, explaination, question_format, question_level_id, subject_lesson_id, subject_dimension_id) VALUES
-- MULTIPLE - one answer
( 'Which tool compiles Java code into bytecode?', 'javac compiles .java files into .class bytecode.', 'multiple', 1, NULL, 3),
( 'What is the standard IDE for Java development?', 'Eclipse and IntelliJ IDEA are common IDEs.', 'multiple', 1, NULL, 3),
( 'Which file extension represents compiled Java bytecode?', 'Compiled Java classes use the .class extension.', 'multiple', 1, NULL, 3),
( 'What command runs a compiled Java program?', 'java runs a .class file.', 'multiple', 1, NULL, 3),
( 'Which tool helps detect syntax errors before runtime?', 'IDEs like IntelliJ can highlight syntax issues.', 'multiple', 2, NULL, 3),
( 'Which IDE is known for its smart code completion for Java?', 'IntelliJ IDEA is praised for advanced code completion.', 'multiple', 2, NULL, 3),
( 'Which of these is used to build Java projects and manage dependencies?', 'Maven is a build tool and dependency manager.', 'multiple', 2, NULL, 3),
( 'Which folder typically contains compiled .class files?', 'The /bin folder usually stores compiled code.', 'multiple', 2, NULL, 3),
( 'Which of the following is a debugging tool in IDEs?', 'Breakpoints allow step-by-step debugging.', 'multiple', 1, NULL, 3),
( 'Which command-line tool lists directory contents?', 'The "ls" command lists files in Unix-based systems.', 'multiple', 1, NULL, 3),

-- MULTIPLE - multiple answers
( 'Which of the following are Java IDEs?', 'Eclipse, NetBeans, and IntelliJ IDEA are popular Java IDEs.', 'multiple', 2, NULL, 3),
( 'Which of the following are build tools used in Java projects?', 'Maven and Gradle are Java build tools.', 'multiple', 3, NULL, 3),
( 'Which tools assist in version control?', 'Git, GitHub, and GitLab are version control tools.', 'multiple', 3, NULL, 3),
( 'Which tools can be used to test Java code?', 'JUnit and TestNG are Java testing tools.', 'multiple', 2, NULL, 3),
( 'Which features are commonly found in modern IDEs?', 'IDEs often include debugging, auto-completion, and version control integration.', 'multiple', 3, NULL, 3),

-- ESSAY
( 'Explain the role of an IDE in software development.', 'IDEs provide a complete development environment with editing, compiling, and debugging.', 'essay', 2, NULL, 3),
( 'Compare Maven and Gradle in Java project management.', 'Both manage dependencies and build processes but differ in approach.', 'essay', 3, NULL, 3),
( 'Describe how breakpoints help in debugging.', 'Breakpoints pause execution for variable inspection and control flow.', 'essay', 2, NULL, 3),
( 'Discuss the importance of using version control tools like Git.', 'Version control allows collaboration, tracking, and history of code.', 'essay', 3, NULL, 3),
( 'Write steps to compile and run a Java program using the terminal.', 'Use javac to compile and java to execute the .class file.', 'essay', 1, NULL, 3);
-- Options for MULTIPLE (Q31 → Q45)
INSERT INTO question_options (question_id, option_content, is_answer) VALUES
-- One-answer questions
(31, 'javac', 1), (31, 'java', 0), (31, 'javadoc', 0), (31, 'jar', 0),
(32, 'IntelliJ IDEA', 1), (32, 'Visual Studio Code', 0), (32, 'Notepad++', 0), (32, 'Nano', 0),
(33, '.class', 1), (33, '.java', 0), (33, '.jar', 0), (33, '.exe', 0),
(34, 'java', 1), (34, 'run', 0), (34, 'javac', 0), (34, 'execute', 0),
(35, 'IDE', 1), (35, 'Command line', 0), (35, 'Notepad', 0), (35, 'Text editor', 0),
(36, 'IntelliJ IDEA', 1), (36, 'BlueJ', 0), (36, 'Nano', 0), (36, 'Vi', 0),
(37, 'Maven', 1), (37, 'Notepad++', 0), (37, 'WinRAR', 0), (37, 'Firefox', 0),
(38, 'bin', 1), (38, 'src', 0), (38, 'lib', 0), (38, 'res', 0),
(39, 'Breakpoints', 1), (39, 'Console logs', 0), (39, 'Compilers', 0), (39, 'Syntax highlighter', 0),
(40, 'ls', 1), (40, 'dir', 0), (40, 'cd', 0), (40, 'pwd', 0),

-- Multi-answer questions
(41, 'Eclipse', 1), (41, 'NetBeans', 1), (41, 'IntelliJ IDEA', 1), (41, 'Photoshop', 0),
(42, 'Maven', 1), (42, 'Gradle', 1), (42, 'WinZip', 0), (42, 'Git', 0),
(43, 'Git', 1), (43, 'GitHub', 1), (43, 'GitLab', 1), (43, 'Eclipse', 0),
(44, 'JUnit', 1), (44, 'TestNG', 1), (44, 'Notepad', 0), (44, 'Paint', 0),
(45, 'Debugging', 1), (45, 'Auto-completion', 1), (45, 'Version control integration', 1), (45, 'Image editing', 0);

-- Questions (ID 51 - 70) - Dimension 4: Problem Solving
INSERT INTO questions (content, explaination, question_format, question_level_id, subject_lesson_id, subject_dimension_id) VALUES
-- MULTIPLE - one answer
( 'Which of the following best describes algorithm efficiency?', 'Efficiency refers to time and space usage.', 'multiple', 2, NULL, 4),
( 'What is the result of 3 + 4 * 2?', 'Multiplication has higher precedence than addition.', 'multiple', 1, NULL, 4),
( 'Which sorting algorithm has the best average-case performance?', 'Merge Sort has O(n log n) average performance.', 'multiple', 2, NULL, 4),
( 'What does Big-O notation measure?', 'It describes the upper bound of algorithm performance.', 'multiple', 2, NULL, 4),
( 'Which data structure uses LIFO principle?', 'Stacks use Last-In-First-Out ordering.', 'multiple', 1, NULL, 4),
( 'Which keyword is used to exit a loop early in Java?', 'break stops a loop immediately.', 'multiple', 1, NULL, 4),
( 'Which method is best for finding an item in a sorted list?', 'Binary Search is optimal for sorted lists.', 'multiple', 2, NULL, 4),
( 'Which of the following is not a brute-force method?', 'Dynamic programming optimizes by storing solutions.', 'multiple', 2, NULL, 4),
( 'Which of these control structures is used for decision making?', 'if-else handles conditional logic.', 'multiple', 1, NULL, 4),
( 'Which algorithm is used to find the shortest path in a graph?', 'Dijkstra’s algorithm solves shortest path problems.', 'multiple', 3, NULL, 4),

-- MULTIPLE - multiple answers
( 'Which are examples of divide-and-conquer algorithms?', 'Merge Sort and Quick Sort divide problems recursively.', 'multiple', 3, NULL, 4),
( 'Which problems can be solved using greedy algorithms?', 'Greedy works for coin change, activity selection, etc.', 'multiple', 3, NULL, 4),
( 'Which strategies help in solving complex problems?', 'Breaking down problems and dry-run are helpful.', 'multiple', 2, NULL, 4),
( 'Which techniques can improve code readability when solving problems?', 'Comments, indentation, and good naming help.', 'multiple', 1, NULL, 4),
( 'Which of the following algorithms are used for searching?', 'Linear and Binary Search are common searching algorithms.', 'multiple', 2, NULL, 4),

-- ESSAY
( 'Explain the importance of problem-solving skills in programming.', 'Good problem-solving is key to effective coding.', 'essay', 2, NULL, 4),
( 'Describe how recursion works with an example.', 'Recursion calls itself with a reduced problem.', 'essay', 2, NULL, 4),
( 'Compare Linear Search and Binary Search in terms of efficiency.', 'Binary Search is faster on sorted data.', 'essay', 3, NULL, 4),
( 'Discuss the benefits of dry-running code before execution.', 'Dry-run helps catch logic errors early.', 'essay', 1, NULL, 4),
( 'Write pseudocode for a simple bubble sort algorithm.', 'Bubble Sort repeatedly swaps adjacent elements.', 'essay', 3, NULL, 4);

-- Options for MULTIPLE (Q51 → Q65)
INSERT INTO question_options (question_id, option_content, is_answer) VALUES
-- One-answer questions
(51, 'Time and space complexity', 1), (51, 'Number of lines in code', 0), (51, 'Programming language used', 0), (51, 'Indentation', 0),
(52, '11', 1), (52, '14', 0), (52, '16', 0), (52, '10', 0),
(53, 'Merge Sort', 1), (53, 'Bubble Sort', 0), (53, 'Selection Sort', 0), (53, 'Insertion Sort', 0),
(54, 'Worst-case time complexity', 1), (54, 'Memory size', 0), (54, 'Actual runtime', 0), (54, 'CPU frequency', 0),
(55, 'Stack', 1), (55, 'Queue', 0), (55, 'Array', 0), (55, 'LinkedList', 0),
(56, 'break', 1), (56, 'exit', 0), (56, 'return', 0), (56, 'continue', 0),
(57, 'Binary Search', 1), (57, 'Linear Search', 0), (57, 'Brute-force Search', 0), (57, 'DFS', 0),
(58, 'Dynamic programming', 1), (58, 'Linear Search', 0), (58, 'Nested loops', 0), (58, 'Trial-and-error', 0),
(59, 'if-else', 1), (59, 'while', 0), (59, 'for', 0), (59, 'switch', 0),
(60, 'Dijkstra’s Algorithm', 1), (60, 'DFS', 0), (60, 'BFS', 0), (60, 'Quick Sort', 0),

-- Multi-answer questions
(61, 'Merge Sort', 1), (61, 'Quick Sort', 1), (61, 'Bubble Sort', 0), (61, 'Linear Search', 0),
(62, 'Activity Selection', 1), (62, 'Huffman Coding', 1), (62, 'Factorial Calculation', 0), (62, 'Binary Search', 0),
(63, 'Break problem into subproblems', 1), (63, 'Dry-run the solution', 1), (63, 'Ignore constraints', 0), (63, 'Guess randomly', 0),
(64, 'Proper indentation', 1), (64, 'Meaningful variable names', 1), (64, 'Use emojis', 0), (64, 'Add comments', 1),
(65, 'Linear Search', 1), (65, 'Binary Search', 1), (65, 'Bubble Sort', 0), (65, 'Merge Sort', 0);

-- Questions (ID 71 - 90) - Dimension 5: SQL Basics
INSERT INTO questions (content, explaination, question_format, question_level_id, subject_lesson_id, subject_dimension_id) VALUES
-- MULTIPLE - one answer
( 'Which keyword is used to sort the result set in SQL?', 'ORDER BY is used for sorting in ascending/descending order.', 'multiple', 1, NULL, 5),
( 'What does the SELECT statement do?', 'SELECT retrieves data from a table.', 'multiple', 1, NULL, 5),
( 'Which SQL clause is used to filter records?', 'WHERE clause filters rows based on conditions.', 'multiple', 1, NULL, 5),
( 'Which symbol is used for pattern matching in LIKE?', 'The % symbol matches zero or more characters.', 'multiple', 2, NULL, 5),
( 'What is the default sorting order for ORDER BY?', 'Ascending (ASC) is the default sort order.', 'multiple', 1, NULL, 5),
( 'Which function returns the number of rows in a table?', 'COUNT() returns the total number of rows.', 'multiple', 1, NULL, 5),
( 'What is the purpose of the DISTINCT keyword?', 'DISTINCT removes duplicate values.', 'multiple', 2, NULL, 5),
( 'Which clause groups rows that have the same values?', 'GROUP BY groups records with identical values.', 'multiple', 2, NULL, 5),
( 'Which SQL function returns the highest value?', 'MAX() returns the highest value from a column.', 'multiple', 2, NULL, 5),
( 'Which command is used to remove all records from a table but not the table itself?', 'TRUNCATE removes all rows but keeps the structure.', 'multiple', 3, NULL, 5),

-- MULTIPLE - multiple answers
( 'Which statements can be used to modify table data?', 'UPDATE and DELETE are used for data modification.', 'multiple', 2, NULL, 5),
( 'Which of the following are aggregate functions?', 'Aggregate functions perform calculations on a set of values.', 'multiple', 2, NULL, 5),
( 'Which are valid SQL data types?', 'SQL supports data types such as INT, VARCHAR, etc.', 'multiple', 1, NULL, 5),
( 'Which statements can retrieve data from a database?', 'SELECT and JOIN can be used to extract data.', 'multiple', 2, NULL, 5),
( 'Which SQL commands affect the structure of a table?', 'ALTER and DROP change table structure.', 'multiple', 3, NULL, 5),

-- ESSAY
( 'Explain the difference between WHERE and HAVING clauses.', 'WHERE filters before grouping, HAVING filters after.', 'essay', 3, NULL, 5),
( 'Describe how the GROUP BY clause works with aggregate functions.', 'GROUP BY groups rows; aggregates summarize them.', 'essay', 2, NULL, 5),
( 'Compare DELETE and TRUNCATE in SQL.', 'DELETE logs each row deletion; TRUNCATE is faster.', 'essay', 3, NULL, 5),
( 'Explain the purpose of using aliases in SQL queries.', 'Aliases rename columns or tables for readability.', 'essay', 1, NULL, 5),
( 'Write an SQL query to find employees with salary above average.', 'Use AVG and subquery in WHERE clause.', 'essay', 3, NULL, 5);

-- Options for MULTIPLE (Q71 → Q85)
INSERT INTO question_options (question_id, option_content, is_answer) VALUES
-- One-answer questions
(71, 'ORDER BY', 1), (71, 'GROUP BY', 0), (71, 'SORT BY', 0), (71, 'FILTER BY', 0),
(72, 'Retrieve data from a table', 1), (72, 'Insert new rows', 0), (72, 'Delete rows', 0), (72, 'Update data', 0),
(73, 'WHERE', 1), (73, 'GROUP BY', 0), (73, 'HAVING', 0), (73, 'ORDER BY', 0),
(74, '%', 1), (74, '#', 0), (74, '@', 0), (74, '*', 0),
(75, 'Ascending', 1), (75, 'Descending', 0), (75, 'Random', 0), (75, 'None', 0),
(76, 'COUNT()', 1), (76, 'MAX()', 0), (76, 'SUM()', 0), (76, 'AVG()', 0),
(77, 'To remove duplicates', 1), (77, 'To group values', 0), (77, 'To filter rows', 0), (77, 'To sort values', 0),
(78, 'GROUP BY', 1), (78, 'ORDER BY', 0), (78, 'HAVING', 0), (78, 'WHERE', 0),
(79, 'MAX()', 1), (79, 'MIN()', 0), (79, 'AVG()', 0), (79, 'SUM()', 0),
(80, 'TRUNCATE', 1), (80, 'DELETE', 0), (80, 'DROP', 0), (80, 'CLEAR', 0),

-- Multi-answer questions
(81, 'UPDATE', 1), (81, 'DELETE', 1), (81, 'SELECT', 0), (81, 'CREATE', 0),
(82, 'SUM()', 1), (82, 'AVG()', 1), (82, 'MAX()', 1), (82, 'SELECT()', 0),
(83, 'INT', 1), (83, 'VARCHAR', 1), (83, 'CHAR', 1), (83, 'INTEGER()', 0),
(84, 'SELECT', 1), (84, 'JOIN', 1), (84, 'INSERT', 0), (84, 'DROP', 0),
(85, 'ALTER', 1), (85, 'DROP', 1), (85, 'UPDATE', 0), (85, 'SELECT', 0);

-- Questions (ID 91 - 110) - Dimension 6: Joins & Relationships
INSERT INTO questions (content, explaination, question_format, question_level_id, subject_lesson_id, subject_dimension_id) VALUES
-- MULTIPLE - one answer
( 'Which SQL JOIN returns all rows from both tables, with NULLs where there is no match?', 'FULL OUTER JOIN combines both LEFT and RIGHT JOIN results.', 'multiple', 2, NULL, 6),
( 'What is a primary key in SQL?', 'A primary key uniquely identifies each record in a table.', 'multiple', 1, NULL, 6),
( 'Which JOIN is used to return matching rows from both tables?', 'INNER JOIN returns only matching records.', 'multiple', 1, NULL, 6),
( 'What is a foreign key?', 'A foreign key links a child table to a parent table.', 'multiple', 1, NULL, 6),
( 'Which SQL keyword defines a relationship between two tables?', 'FOREIGN KEY defines a relational link.', 'multiple', 2, NULL, 6),
( 'What kind of JOIN returns all records from the left table and the matched ones from the right?', 'LEFT JOIN returns all from the left table.', 'multiple', 2, NULL, 6),
( 'Which constraint ensures that no duplicate values exist in a column?', 'UNIQUE enforces all values to be distinct.', 'multiple', 2, NULL, 6),
( 'Which type of JOIN may result in a Cartesian product?', 'CROSS JOIN returns all combinations.', 'multiple', 3, NULL, 6),
( 'What happens if you omit the ON clause in an INNER JOIN?', 'It causes a syntax error or a Cartesian product.', 'multiple', 3, NULL, 6),
( 'What is required for a JOIN to work properly?', 'A common key or condition is necessary.', 'multiple', 1, NULL, 6),

-- MULTIPLE - multiple answers
( 'Which are types of SQL JOINs?', 'JOIN types include INNER, LEFT, RIGHT, FULL, CROSS.', 'multiple', 1, NULL, 6),
( 'Which constraints help maintain referential integrity?', 'PRIMARY and FOREIGN KEY constraints enforce relationships.', 'multiple', 2, NULL, 6),
( 'Which clauses are commonly used with JOIN?', 'JOIN typically includes ON or USING for match condition.', 'multiple', 2, NULL, 6),
( 'Which statements about foreign keys are true?', 'Foreign keys link tables and restrict actions.', 'multiple', 3, NULL, 6),
( 'Which conditions may cause a JOIN to fail or behave incorrectly?', 'Missing ON clause or mismatched keys may cause problems.', 'multiple', 3, NULL, 6),

-- ESSAY
( 'Explain the difference between INNER JOIN and OUTER JOIN.', 'INNER returns only matches; OUTER includes unmatched rows.', 'essay', 2, NULL, 6),
( 'Discuss how foreign keys enforce relationships between tables.', 'Foreign keys prevent orphan records.', 'essay', 2, NULL, 6),
( 'What are the advantages of using JOINs instead of subqueries?', 'JOINs are often faster and more readable.', 'essay', 3, NULL, 6),
( 'Describe a scenario where a LEFT JOIN is preferable.', 'LEFT JOIN is useful for preserving all records from one side.', 'essay', 2, NULL, 6),
( 'Write a query that uses a RIGHT JOIN and explain its output.', 'RIGHT JOIN includes all records from the right table.', 'essay', 3, NULL, 6);

-- Options for MULTIPLE (Q91 → Q105)
INSERT INTO question_options (question_id, option_content, is_answer) VALUES
-- One-answer questions
(91, 'FULL OUTER JOIN', 1), (91, 'INNER JOIN', 0), (91, 'LEFT JOIN', 0), (91, 'CROSS JOIN', 0),
(92, 'A unique identifier for each row', 1), (92, 'A duplicate value column', 0), (92, 'A column with NULLs', 0), (92, 'An external reference', 0),
(93, 'INNER JOIN', 1), (93, 'FULL JOIN', 0), (93, 'RIGHT JOIN', 0), (93, 'LEFT JOIN', 0),
(94, 'A key linking to another table’s primary key', 1), (94, 'A column with unique values', 0), (94, 'A type of JOIN', 0), (94, 'A keyword for sorting', 0),
(95, 'FOREIGN KEY', 1), (95, 'UNIQUE', 0), (95, 'DEFAULT', 0), (95, 'ORDER BY', 0),
(96, 'LEFT JOIN', 1), (96, 'RIGHT JOIN', 0), (96, 'FULL JOIN', 0), (96, 'INNER JOIN', 0),
(97, 'UNIQUE', 1), (97, 'PRIMARY KEY', 0), (97, 'FOREIGN KEY', 0), (97, 'CHECK', 0),
(98, 'CROSS JOIN', 1), (98, 'LEFT JOIN', 0), (98, 'INNER JOIN', 0), (98, 'RIGHT JOIN', 0),
(99, 'It produces a Cartesian product or syntax error', 1), (99, 'It returns no rows', 0), (99, 'It ignores the condition', 0), (99, 'It returns NULLs', 0),
(100, 'A matching key or condition', 1), (100, 'Same column names', 0), (100, 'Same table structure', 0), (100, 'Using WHERE only', 0),

-- Multi-answer questions
(101, 'INNER JOIN', 1), (101, 'LEFT JOIN', 1), (101, 'FULL JOIN', 1), (101, 'SELF JOIN', 1), (101, 'CROSS JOIN', 1),
(102, 'PRIMARY KEY', 1), (102, 'FOREIGN KEY', 1), (102, 'DEFAULT', 0), (102, 'UNIQUE', 0),
(103, 'ON', 1), (103, 'USING', 1), (103, 'FROM', 0), (103, 'ORDER BY', 0),
(104, 'They link child and parent tables', 1), (104, 'They prevent deletion of referenced data', 1), (104, 'They allow NULLs freely', 0), (104, 'They are used only in SELECT', 0),
(105, 'Missing ON condition', 1), (105, 'Mismatched data types', 1), (105, 'Ambiguous column names', 1), (105, 'Correct key usage', 0);

-- Questions (ID 111 - 130) - Dimension 7: SQL Platforms
INSERT INTO questions (content, explaination, question_format, question_level_id, subject_lesson_id, subject_dimension_id) VALUES
-- MULTIPLE - one answer
( 'Which SQL platform is developed by Microsoft?', 'SQL Server is Microsoft’s relational database platform.', 'multiple', 1, NULL, 7),
( 'Which SQL platform is most commonly used in web development with PHP?', 'MySQL is popular with LAMP stacks.', 'multiple', 1, NULL, 7),
( 'Which SQL engine is embedded and file-based?', 'SQLite is lightweight and stores data in a single file.', 'multiple', 1, NULL, 7),
( 'Which open-source database was acquired by Oracle?', 'Oracle acquired MySQL.', 'multiple', 2, NULL, 7),
( 'Which database offers the SSMS (SQL Server Management Studio)?', 'SQL Server is managed via SSMS.', 'multiple', 2, NULL, 7),
( 'Which database is known for its strict typing and row-level locking?', 'PostgreSQL emphasizes standards and locking.', 'multiple', 2, NULL, 7),
( 'What is the default database in Android mobile apps?', 'SQLite is used as the default embedded DB.', 'multiple', 1, NULL, 7),
( 'Which platform supports PL/pgSQL?', 'PL/pgSQL is specific to PostgreSQL.', 'multiple', 3, NULL, 7),
( 'Which DBMS has a built-in graphical tool called Workbench?', 'MySQL Workbench is a GUI tool for MySQL.', 'multiple', 1, NULL, 7),
( 'Which SQL engine supports T-SQL as its proprietary language?', 'T-SQL is used in SQL Server.', 'multiple', 2, NULL, 7),

-- MULTIPLE - multiple answers
( 'Which platforms are open-source SQL databases?', 'MySQL, PostgreSQL, and SQLite are open-source.', 'multiple', 1, NULL, 7),
( 'Which platforms support stored procedures?', 'Most enterprise SQL platforms support procedures.', 'multiple', 2, NULL, 7),
( 'Which tools are used to manage MySQL?', 'Common tools include CLI and Workbench.', 'multiple', 2, NULL, 7),
( 'Which SQL platforms are commonly used in enterprise systems?', 'SQL Server and Oracle are popular in enterprises.', 'multiple', 2, NULL, 7),
( 'Which SQL databases support JSON data type?', 'PostgreSQL and MySQL offer native JSON support.', 'multiple', 3, NULL, 7),

-- ESSAY
( 'Compare SQLite and MySQL in terms of architecture and use cases.', 'SQLite is embedded; MySQL is server-based.', 'essay', 2, NULL, 7),
( 'Explain why PostgreSQL is considered highly standard-compliant.', 'PostgreSQL closely follows SQL standards.', 'essay', 3, NULL, 7),
( 'Discuss the advantages of using stored procedures.', 'Stored procedures improve performance and reusability.', 'essay', 2, NULL, 7),
( 'Describe the role of SQL Server in enterprise data solutions.', 'SQL Server offers scalability, SSMS, and T-SQL.', 'essay', 2, NULL, 7),
( 'What are the benefits of using open-source databases?', 'They offer flexibility, cost savings, and community support.', 'essay', 2, NULL, 7);

-- Options for MULTIPLE (Q111 → Q125)
INSERT INTO question_options (question_id, option_content, is_answer) VALUES
-- One-answer questions
(111, 'SQL Server', 1), (111, 'PostgreSQL', 0), (111, 'MySQL', 0), (111, 'SQLite', 0),
(112, 'MySQL', 1), (112, 'SQL Server', 0), (112, 'Oracle', 0), (112, 'SQLite', 0),
(113, 'SQLite', 1), (113, 'PostgreSQL', 0), (113, 'MySQL', 0), (113, 'Oracle', 0),
(114, 'MySQL', 1), (114, 'PostgreSQL', 0), (114, 'SQLite', 0), (114, 'SQL Server', 0),
(115, 'SQL Server', 1), (115, 'MySQL', 0), (115, 'Oracle', 0), (115, 'SQLite', 0),
(116, 'PostgreSQL', 1), (116, 'SQLite', 0), (116, 'MySQL', 0), (116, 'SQL Server', 0),
(117, 'SQLite', 1), (117, 'MySQL', 0), (117, 'Oracle', 0), (117, 'SQL Server', 0),
(118, 'PostgreSQL', 1), (118, 'SQL Server', 0), (118, 'Oracle', 0), (118, 'MySQL', 0),
(119, 'MySQL', 1), (119, 'PostgreSQL', 0), (119, 'Oracle', 0), (119, 'SQL Server', 0),
(120, 'SQL Server', 1), (120, 'MySQL', 0), (120, 'PostgreSQL', 0), (120, 'Oracle', 0),

-- Multi-answer questions
(121, 'MySQL', 1), (121, 'PostgreSQL', 1), (121, 'SQLite', 1), (121, 'SQL Server', 0),
(122, 'MySQL', 1), (122, 'SQL Server', 1), (122, 'PostgreSQL', 1), (122, 'SQLite', 0),
(123, 'MySQL Workbench', 1), (123, 'Command Line Interface', 1), (123, 'SSMS', 0), (123, 'pgAdmin', 0),
(124, 'SQL Server', 1), (124, 'Oracle', 1), (124, 'MySQL', 0), (124, 'SQLite', 0),
(125, 'PostgreSQL', 1), (125, 'MySQL', 1), (125, 'SQLite', 0), (125, 'SQL Server', 0);

-- Questions (ID 131 - 150) - Dimension 8: Database Design
INSERT INTO questions (content, explaination, question_format, question_level_id, subject_lesson_id, subject_dimension_id) VALUES
-- MULTIPLE - one answer
( 'Which normal form eliminates partial dependencies?', '2NF removes partial dependencies on a composite key.', 'multiple', 2, NULL, 8),
( 'Which normal form removes transitive dependencies?', '3NF handles transitive dependencies.', 'multiple', 2, NULL, 8),
( 'What is the goal of normalization in databases?', 'Normalization reduces redundancy and improves integrity.', 'multiple', 1, NULL, 8),
( 'Which diagram is used to represent database schemas visually?', 'ERD (Entity Relationship Diagram) represents database models.', 'multiple', 1, NULL, 8),
( 'Which type of relationship describes "many-to-many"?', 'Many-to-many requires a junction table.', 'multiple', 1, NULL, 8),
( 'What is a foreign key used for?', 'Foreign keys create relationships between tables.', 'multiple', 1, NULL, 8),
( 'Which constraint ensures a column only accepts unique values?', 'The UNIQUE constraint enforces uniqueness.', 'multiple', 1, NULL, 8),
( 'Which statement defines a primary key?', 'PRIMARY KEY ensures unique and non-null values.', 'multiple', 1, NULL, 8),
( 'Which attribute uniquely identifies an entity in a table?', 'A primary key is used for unique identification.', 'multiple', 1, NULL, 8),
( 'Which key can accept NULL values in a table?', 'Foreign keys can be nullable.', 'multiple', 2, NULL, 8),

-- MULTIPLE - multiple answers
( 'Which are valid types of database constraints?', 'Common constraints include PRIMARY KEY, FOREIGN KEY, UNIQUE, etc.', 'multiple', 2, NULL, 8),
( 'Which of the following are steps in normalization?', 'Normalization includes multiple structured steps.', 'multiple', 2, NULL, 8),
( 'Which issues does normalization address?', 'Normalization deals with redundancy and update anomalies.', 'multiple', 2, NULL, 8),
( 'Which tools help in designing database schemas?', 'Several tools assist in ER modeling and design.', 'multiple', 2, NULL, 8),
( 'Which fields are typically good candidates for primary keys?', 'Primary keys must be unique and non-null.', 'multiple', 2, NULL, 8),

-- ESSAY
( 'Explain the importance of foreign keys in relational databases.', 'They enforce referential integrity between tables.', 'essay', 2, NULL, 8),
( 'Describe the purpose and process of database normalization.', 'Normalization organizes data efficiently and reduces redundancy.', 'essay', 2, NULL, 8),
( 'Discuss the role of ER diagrams in database planning.', 'ERDs visualize entities and their relationships.', 'essay', 2, NULL, 8),
( 'What are the differences between primary and foreign keys?', 'Primary keys identify records; foreign keys create links.', 'essay', 2, NULL, 8),
( 'How does a many-to-many relationship work in databases?', 'It uses a junction table with foreign keys to each side.', 'essay', 2, NULL, 8);

-- Options for MULTIPLE (Q131 → Q145)
INSERT INTO question_options (question_id, option_content, is_answer) VALUES
-- One-answer questions
(131, 'Second Normal Form (2NF)', 1), (131, 'First Normal Form (1NF)', 0), (131, 'Third Normal Form (3NF)', 0), (131, 'Boyce-Codd Normal Form (BCNF)', 0),
(132, 'Third Normal Form (3NF)', 1), (132, 'First Normal Form (1NF)', 0), (132, 'Fourth Normal Form (4NF)', 0), (132, 'Second Normal Form (2NF)', 0),
(133, 'Reduce redundancy', 1), (133, 'Improve performance', 0), (133, 'Add security', 0), (133, 'Enforce data types', 0),
(134, 'ER Diagram (ERD)', 1), (134, 'Flowchart', 0), (134, 'UML Diagram', 0), (134, 'Data Tree', 0),
(135, 'Needs junction table', 1), (135, 'Uses only two tables directly', 0), (135, 'Does not need foreign key', 0), (135, 'Is always one-to-one', 0),
(136, 'To link related data in tables', 1), (136, 'To enforce data types', 0), (136, 'To duplicate rows', 0), (136, 'To compress data', 0),
(137, 'UNIQUE', 1), (137, 'CHECK', 0), (137, 'NOT NULL', 0), (137, 'DEFAULT', 0),
(138, 'PRIMARY KEY', 1), (138, 'FOREIGN KEY', 0), (138, 'UNIQUE', 0), (138, 'AUTO_INCREMENT', 0),
(139, 'Primary Key', 1), (139, 'Foreign Key', 0), (139, 'Index', 0), (139, 'Default', 0),
(140, 'Foreign Key', 1), (140, 'Primary Key', 0), (140, 'Unique Key', 0), (140, 'Check Constraint', 0),

-- Multi-answer questions
(141, 'PRIMARY KEY', 1), (141, 'FOREIGN KEY', 1), (141, 'UNIQUE', 1), (141, 'RENAME', 0),
(142, 'Remove repeating groups', 1), (142, 'Remove partial dependencies', 1), (142, 'Remove transitive dependencies', 1), (142, 'Drop indexes', 0),
(143, 'Data redundancy', 1), (143, 'Update anomalies', 1), (143, 'Incorrect joins', 0), (143, 'Slow queries', 0),
(144, 'Lucidchart', 1), (144, 'dbdiagram.io', 1), (144, 'MS Word', 0), (144, 'Photoshop', 0),
(145, 'StudentID', 1), (145, 'Email (if unique)', 1), (145, 'Age', 0), (145, 'Country', 0);

-- Questions (ID 151 - 170) - Dimension 9: Network Fundamentals
INSERT INTO questions (content, explaination, question_format, question_level_id, subject_lesson_id, subject_dimension_id) VALUES
-- MULTIPLE - one answer
( 'Which layer of the OSI model handles data routing?', 'The Network layer (Layer 3) handles routing between devices.', 'multiple', 2, NULL, 9),
( 'What is the function of a MAC address?', 'MAC addresses identify devices at the data link layer.', 'multiple', 1, NULL, 9),
( 'Which protocol is used to assign IP addresses automatically?', 'DHCP assigns IP addresses dynamically.', 'multiple', 1, NULL, 9),
( 'Which device connects different networks together?', 'A router connects multiple networks.', 'multiple', 1, NULL, 9),
( 'Which protocol guarantees reliable data transmission?', 'TCP provides error checking and guaranteed delivery.', 'multiple', 2, NULL, 9),
( 'What is the size of an IPv4 address?', 'IPv4 addresses are 32 bits long.', 'multiple', 1, NULL, 9),
( 'Which port is used for HTTP traffic?', 'Port 80 is used by HTTP.', 'multiple', 1, NULL, 9),
( 'What is a private IP address?', 'It is an IP reserved for internal network use.', 'multiple', 2, NULL, 9),
( 'Which device operates at Layer 2 of the OSI model?', 'A switch works at the Data Link layer.', 'multiple', 2, NULL, 9),
( 'What does DNS stand for?', 'DNS stands for Domain Name System.', 'multiple', 1, NULL, 9),

-- MULTIPLE - multiple answers
( 'Which of the following are transport layer protocols?', 'TCP and UDP are part of the transport layer.', 'multiple', 2, NULL, 9),
( 'Which addresses are valid private IP ranges?', 'Private IP ranges are defined by standards.', 'multiple', 2, NULL, 9),
( 'Which are valid Layer 1 devices?', 'Layer 1 involves hardware transmitting raw bits.', 'multiple', 2, NULL, 9),
( 'Which protocols operate at the application layer?', 'Application layer protocols provide services to the user.', 'multiple', 2, NULL, 9),
( 'Which are functions of the network layer?', 'Network layer handles addressing and routing.', 'multiple', 3, NULL, 9),

-- ESSAY
( 'Explain the role of routers in a network.', 'Routers connect networks and direct data packets.', 'essay', 2, NULL, 9),
( 'Describe the structure of an IPv4 address.', 'IPv4 addresses are 32-bit and typically shown in dotted-decimal notation.', 'essay', 2, NULL, 9),
( 'Discuss the differences between TCP and UDP.', 'TCP is reliable and connection-based, UDP is faster but connectionless.', 'essay', 2, NULL, 9),
( 'How does DNS help in web browsing?', 'DNS resolves domain names to IP addresses, enabling access to websites.', 'essay', 2, NULL, 9),
( 'What is the importance of MAC addresses in networking?', 'MAC addresses identify hardware devices at the data link layer.', 'essay', 2, NULL, 9);

-- Options for MULTIPLE (Q151 → Q165)
INSERT INTO question_options (question_id, option_content, is_answer) VALUES
-- One-answer questions
(151, 'Network Layer', 1), (151, 'Transport Layer', 0), (151, 'Application Layer', 0), (151, 'Data Link Layer', 0),
(152, 'Identifies hardware on a LAN', 1), (152, 'Assigns IP addresses', 0), (152, 'Encrypts data', 0), (152, 'Routes internet traffic', 0),
(153, 'DHCP', 1), (153, 'DNS', 0), (153, 'IPSec', 0), (153, 'FTP', 0),
(154, 'Router', 1), (154, 'Switch', 0), (154, 'Hub', 0), (154, 'Bridge', 0),
(155, 'TCP', 1), (155, 'UDP', 0), (155, 'IP', 0), (155, 'HTTP', 0),
(156, '32 bits', 1), (156, '64 bits', 0), (156, '16 bits', 0), (156, '128 bits', 0),
(157, 'Port 80', 1), (157, 'Port 443', 0), (157, 'Port 25', 0), (157, 'Port 21', 0),
(158, 'An IP not routable on the internet', 1), (158, 'Assigned by ISPs', 0), (158, 'Always static', 0), (158, 'Used by firewalls', 0),
(159, 'Switch', 1), (159, 'Router', 0), (159, 'Gateway', 0), (159, 'Firewall', 0),
(160, 'Domain Name System', 1), (160, 'Data Network Service', 0), (160, 'Dynamic Name Source', 0), (160, 'Digital Number Server', 0),

-- Multi-answer questions
(161, 'TCP', 1), (161, 'UDP', 1), (161, 'ICMP', 0), (161, 'HTTP', 0),
(162, '192.168.0.0/16', 1), (162, '172.16.0.0/12', 1), (162, '10.0.0.0/8', 1), (162, '8.8.8.8', 0),
(163, 'Hub', 1), (163, 'Cable', 1), (163, 'Switch', 0), (163, 'Router', 0),
(164, 'HTTP', 1), (164, 'FTP', 1), (164, 'TCP', 0), (164, 'IP', 0),
(165, 'Routing', 1), (165, 'Logical addressing', 1), (165, 'Error correction', 0), (165, 'Data framing', 0);

-- Questions (ID 171 - 190) - Dimension 10: Subnetting & Routing
INSERT INTO questions (content, explaination, question_format, question_level_id, subject_lesson_id, subject_dimension_id) VALUES
-- MULTIPLE - one answer
( 'What does CIDR stand for in networking?', 'CIDR is a method for allocating IP addresses and routing.', 'multiple', 2, NULL, 10),
( 'What is the subnet mask for a /24 network?', 'A /24 network has 255.255.255.0 as subnet mask.', 'multiple', 1, NULL, 10),
( 'Which part of an IP address identifies the host?', 'The host part comes after the subnet portion.', 'multiple', 2, NULL, 10),
( 'What is the result of subnetting a /24 network into 4 equal parts?', 'Each subnet becomes a /26 network.', 'multiple', 2, NULL, 10),
( 'Which routing protocol uses hop count as its metric?', 'RIP is a distance-vector routing protocol.', 'multiple', 2, NULL, 10),
( 'What does a default route (0.0.0.0/0) do?', 'It directs packets when no specific route is available.', 'multiple', 2, NULL, 10),
( 'What is the maximum number of hosts in a /29 subnet?', 'A /29 allows 6 usable host addresses.', 'multiple', 2, NULL, 10),
( 'Which device determines the next hop in a routed network?', 'Routers decide the best path for forwarding packets.', 'multiple', 1, NULL, 10),
( 'What is the purpose of a routing table?', 'It stores routes to determine how to forward packets.', 'multiple', 1, NULL, 10),
( 'Which class of IP addresses supports the most hosts?', 'Class A addresses support the largest number of hosts.', 'multiple', 2, NULL, 10),

-- MULTIPLE - multiple answers
( 'Which are valid subnet masks?', 'Valid subnet masks must consist of contiguous 1s followed by 0s.', 'multiple', 2, NULL, 10),
( 'Which protocols are used for dynamic routing?', 'Dynamic routing protocols update routes automatically.', 'multiple', 2, NULL, 10),
( 'Which factors affect routing decisions?', 'Routers choose paths based on metrics like cost and distance.', 'multiple', 3, NULL, 10),
( 'Which features are associated with OSPF?', 'OSPF is a link-state routing protocol used in large networks.', 'multiple', 3, NULL, 10),
( 'Which are private IP address ranges suitable for subnetting?', 'Private ranges can be subnetted to organize internal networks.', 'multiple', 2, NULL, 10),

-- ESSAY
( 'Explain how subnetting improves network efficiency.', 'Subnetting helps reduce broadcast traffic and improves security.', 'essay', 2, NULL, 10),
( 'Describe the role of routing protocols in a large network.', 'Routing protocols help determine optimal paths.', 'essay', 2, NULL, 10),
( 'Compare static and dynamic routing.', 'Static routing is manual; dynamic uses protocols to adjust routes.', 'essay', 2, NULL, 10),
( 'How does CIDR differ from classful addressing?', 'CIDR allows more efficient IP allocation.', 'essay', 2, NULL, 10),
( 'What problems can arise from incorrect subnetting?', 'It can lead to unreachable networks or IP conflicts.', 'essay', 2, NULL, 10);

-- Options for MULTIPLE (Q171 → Q185)
INSERT INTO question_options (question_id, option_content, is_answer) VALUES
-- One-answer
(171, 'Classless Inter-Domain Routing', 1), (171, 'Common Internet Domain Registry', 0), (171, 'Code Injection Detection Routine', 0), (171, 'Clustered IP Domain Routing', 0),
(172, '255.255.255.0', 1), (172, '255.255.0.0', 0), (172, '255.0.0.0', 0), (172, '255.255.255.192', 0),
(173, 'The part after the subnet mask bits', 1), (173, 'The first octet', 0), (173, 'All 32 bits', 0), (173, 'Only the MAC address', 0),
(174, '/26', 1), (174, '/28', 0), (174, '/25', 0), (174, '/30', 0),
(175, 'RIP', 1), (175, 'OSPF', 0), (175, 'BGP', 0), (175, 'EIGRP', 0),
(176, 'Sends packets when no specific route is found', 1), (176, 'Blocks all outbound traffic', 0), (176, 'Assigns IP addresses', 0), (176, 'Encrypts traffic', 0),
(177, '6', 1), (177, '8', 0), (177, '14', 0), (177, '30', 0),
(178, 'Router', 1), (178, 'Switch', 0), (178, 'Modem', 0), (178, 'Firewall', 0),
(179, 'Stores routes for packet forwarding', 1), (179, 'Assigns IP addresses to devices', 0), (179, 'Encrypts data', 0), (179, 'Tracks bandwidth usage', 0),
(180, 'Class A', 1), (180, 'Class B', 0), (180, 'Class C', 0), (180, 'Class D', 0),

-- Multi-answer
(181, '255.255.255.0', 1), (181, '255.255.255.128', 1), (181, '255.0.255.0', 0), (181, '255.255.224.0', 1),
(182, 'OSPF', 1), (182, 'RIP', 1), (182, 'BGP', 1), (182, 'FTP', 0),
(183, 'Hop count', 1), (183, 'Bandwidth', 1), (183, 'Packet size', 0), (183, 'Delay', 1),
(184, 'Uses cost as a metric', 1), (184, 'Link-state protocol', 1), (184, 'Distance-vector protocol', 0), (184, 'Broadcast-based', 0),
(185, '10.0.0.0/8', 1), (185, '192.168.1.0/24', 1), (185, '172.31.0.0/16', 1), (185, '8.8.8.8', 0);

-- Questions (ID 191 - 210) - Dimension 11: Network Tools
INSERT INTO questions (content, explaination, question_format, question_level_id, subject_lesson_id, subject_dimension_id) VALUES
-- MULTIPLE - one answer
( 'Which tool is commonly used to capture and analyze network traffic?', 'Wireshark is a packet sniffer used to monitor and analyze network traffic.', 'multiple', 2, NULL, 11),
( 'Which command is used to test connectivity between two hosts?', 'Ping sends ICMP echo requests to check network connectivity.', 'multiple', 1, NULL, 11),
( 'Which tool maps the route packets take to a destination?', 'Traceroute shows each hop a packet takes to reach its destination.', 'multiple', 1, NULL, 11),
( 'What does the nslookup tool do?', 'nslookup queries DNS to obtain domain name or IP address mapping.', 'multiple', 2, NULL, 11),
( 'Which command displays the current TCP/IP network configuration on a Windows machine?', 'ipconfig is used in Windows to show IP address, gateway, etc.', 'multiple', 1, NULL, 11),
( 'Which port scanner is widely used for security auditing?', 'Nmap is a powerful tool used to scan for open ports and services.', 'multiple', 2, NULL, 11),
( 'What protocol does Ping use?', 'Ping uses the Internet Control Message Protocol (ICMP).', 'multiple', 2, NULL, 11),
( 'Which tool is typically used to monitor real-time bandwidth usage?', 'Tools like iftop or nload show live bandwidth statistics.', 'multiple', 3, NULL, 11),
( 'What is the primary purpose of netstat?', 'netstat shows active network connections and listening ports.', 'multiple', 2, NULL, 11),
( 'Which tool can detect ARP spoofing or poisoning attacks?', 'arpwatch is used to monitor ARP traffic and detect anomalies.', 'multiple', 3, NULL, 11),

-- MULTIPLE - multiple answers
( 'Which tools can help in diagnosing DNS issues?', 'These tools query or simulate DNS lookups.', 'multiple', 2, NULL, 11),
( 'Which features are commonly found in Wireshark?', 'Wireshark is a feature-rich network analysis tool.', 'multiple', 3, NULL, 11),
( 'Which network utilities are available by default on most Unix systems?', 'Tools like ping and netstat are built into most distributions.', 'multiple', 2, NULL, 11),
( 'Which tools are used for port scanning?', 'These tools allow administrators to discover open ports.', 'multiple', 3, NULL, 11),
( 'Which tools are useful for measuring network latency?', 'These tools provide latency metrics through ICMP or TCP.', 'multiple', 2, NULL, 11),

-- ESSAY
( 'Describe how Wireshark can be used to troubleshoot a slow network.', 'Wireshark can capture and filter traffic to identify congestion, delays, or errors.', 'essay', 3, NULL, 11),
( 'Explain how traceroute helps diagnose routing issues.', 'It reveals each hop and the delay along the path to a destination.', 'essay', 2, NULL, 11),
( 'Compare the usage of netstat and ipconfig.', 'Both provide network information but with different scopes.', 'essay', 2, NULL, 11),
( 'What are the security risks of using port scanners like Nmap?', 'Port scanning can reveal vulnerabilities but may be considered intrusive.', 'essay', 2, NULL, 11),
( 'How do bandwidth monitoring tools help in network management?', 'They help identify which hosts or applications consume the most resources.', 'essay', 2, NULL, 11);

-- Options for MULTIPLE (Q191 → Q205)
INSERT INTO question_options (question_id, option_content, is_answer) VALUES
-- One-answer
(191, 'Wireshark', 1), (191, 'Netcat', 0), (191, 'Traceroute', 0), (191, 'Telnet', 0),
(192, 'Ping', 1), (192, 'FTP', 0), (192, 'SSH', 0), (192, 'HTTP', 0),
(193, 'Traceroute', 1), (193, 'Ping', 0), (193, 'Nslookup', 0), (193, 'ARP', 0),
(194, 'It queries DNS records', 1), (194, 'It measures latency', 0), (194, 'It scans open ports', 0), (194, 'It monitors bandwidth', 0),
(195, 'ipconfig', 1), (195, 'netstat', 0), (195, 'ping', 0), (195, 'nslookup', 0),
(196, 'Nmap', 1), (196, 'Telnet', 0), (196, 'ftp', 0), (196, 'ARP', 0),
(197, 'ICMP', 1), (197, 'TCP', 0), (197, 'UDP', 0), (197, 'HTTP', 0),
(198, 'iftop', 1), (198, 'ipconfig', 0), (198, 'traceroute', 0), (198, 'arp', 0),
(199, 'View active connections and ports', 1), (199, 'Capture packets', 0), (199, 'Scan Wi-Fi networks', 0), (199, 'Resolve DNS', 0),
(200, 'arpwatch', 1), (200, 'telnet', 0), (200, 'nslookup', 0), (200, 'ftp', 0),

-- Multi-answer
(201, 'nslookup', 1), (201, 'dig', 1), (201, 'ping', 0), (201, 'netstat', 0),
(202, 'Packet filtering', 1), (202, 'Live capture', 1), (202, 'Port scanning', 0), (202, 'MAC address spoofing', 0),
(203, 'ping', 1), (203, 'netstat', 1), (203, 'nmap', 0), (203, 'whois', 0),
(204, 'Nmap', 1), (204, 'Zenmap', 1), (204, 'Traceroute', 0), (204, 'iftop', 0),
(205, 'Ping', 1), (205, 'Traceroute', 1), (205, 'Wireshark', 0), (205, 'FTP', 0);

-- Questions (ID 211 - 230) - Dimension 12: Troubleshooting
INSERT INTO questions (content, explaination, question_format, question_level_id, subject_lesson_id, subject_dimension_id) VALUES
-- MULTIPLE - one answer
( 'What is the first step in troubleshooting a network issue?', 'Identifying the problem is the initial step in troubleshooting.', 'multiple', 1, NULL, 12),
( 'Which command helps determine if a device is reachable?', 'Ping checks connectivity by sending ICMP requests.', 'multiple', 1, NULL, 12),
( 'Which tool shows the path packets take to a destination?', 'Traceroute helps identify where packets are dropped or delayed.', 'multiple', 1, NULL, 12),
( 'What does a 169.254.x.x IP address indicate?', 'It means the device failed to get an IP from DHCP and is using APIPA.', 'multiple', 2, NULL, 12),
( 'Which layer would you examine if a cable is unplugged?', 'The Physical layer deals with hardware and cabling.', 'multiple', 1, NULL, 12),
( 'Which protocol is typically used to resolve domain names?', 'DNS translates domain names to IP addresses.', 'multiple', 1, NULL, 12),
( 'What should you check if users can’t access websites by name but can by IP?', 'This suggests a DNS issue.', 'multiple', 2, NULL, 12),
( 'Which command clears the DNS cache in Windows?', 'ipconfig /flushdns is used to reset DNS resolver cache.', 'multiple', 2, NULL, 12),
( 'Which tool shows open ports and active connections?', 'netstat reveals listening ports and current connections.', 'multiple', 2, NULL, 12),
( 'What is the likely cause of high packet loss?', 'Network congestion or faulty hardware can cause packet loss.', 'multiple', 3, NULL, 12),

-- MULTIPLE - multiple answers
( 'Which symptoms indicate a DNS issue?', 'These symptoms often suggest DNS is failing to resolve domain names.', 'multiple', 2, NULL, 12),
( 'Which tools can help identify the source of latency?', 'These tools trace the path and measure time between hops.', 'multiple', 3, NULL, 12),
( 'Which issues may cause intermittent network connectivity?', 'These factors can disrupt stable network connections.', 'multiple', 3, NULL, 12),
( 'Which methods help troubleshoot IP conflicts?', 'Tools and steps for identifying and resolving IP duplication.', 'multiple', 2, NULL, 12),
( 'What are common signs of physical layer problems?', 'These indicators suggest hardware or cabling issues.', 'multiple', 2, NULL, 12),

-- ESSAY
( 'Describe the OSI model’s role in troubleshooting.', 'The OSI model provides a layered approach to identify and isolate network issues.', 'essay', 2, NULL, 12),
( 'Explain how to diagnose slow internet on a local network.', 'Include steps like checking router load, client activity, and external speed.', 'essay', 3, NULL, 12),
( 'Discuss how to handle a suspected DNS poisoning attack.', 'Explain using alternate DNS, flushing cache, and checking for malware.', 'essay', 3, NULL, 12),
( 'What’s the importance of a network baseline in troubleshooting?', 'A baseline helps compare current performance to known good levels.', 'essay', 2, NULL, 12),
( 'Compare using ping vs traceroute for diagnosing connection problems.', 'Highlight differences in what each tool reveals.', 'essay', 2, NULL, 12);

-- Options for MULTIPLE (Q211 → Q225)
INSERT INTO question_options (question_id, option_content, is_answer) VALUES
-- One-answer
(211, 'Identify the problem', 1), (211, 'Replace cables', 0), (211, 'Restart router', 0), (211, 'Check DNS settings', 0),
(212, 'Ping', 1), (212, 'ARP', 0), (212, 'Whois', 0), (212, 'FTP', 0),
(213, 'Traceroute', 1), (213, 'Ping', 0), (213, 'SSH', 0), (213, 'ipconfig', 0),
(214, 'Automatic Private IP Addressing (APIPA)', 1), (214, 'DHCP lease', 0), (214, 'Manual configuration', 0), (214, 'Static IP error', 0),
(215, 'Physical', 1), (215, 'Data Link', 0), (215, 'Network', 0), (215, 'Application', 0),
(216, 'DNS', 1), (216, 'DHCP', 0), (216, 'FTP', 0), (216, 'SMTP', 0),
(217, 'Check DNS configuration', 1), (217, 'Change subnet', 0), (217, 'Inspect cables', 0), (217, 'Reboot PC', 0),
(218, 'ipconfig /flushdns', 1), (218, 'ping localhost', 0), (218, 'tracert google.com', 0), (218, 'nslookup', 0),
(219, 'netstat', 1), (219, 'ping', 0), (219, 'ftp', 0), (219, 'ipconfig', 0),
(220, 'Faulty network hardware', 1), (220, 'New firewall rules', 0), (220, 'Low RAM', 0), (220, 'File permission issues', 0),

-- Multi-answer
(221, 'Cannot browse by name', 1), (221, 'Ping by IP works', 1), (221, 'Slow local file transfers', 0), (221, 'No DHCP response', 0),
(222, 'Traceroute', 1), (222, 'Ping with time stats', 1), (222, 'ARP', 0), (222, 'FTP', 0),
(223, 'Loose cable', 1), (223, 'Wi-Fi interference', 1), (223, 'Incorrect subnet mask', 0), (223, 'Expired SSL certificate', 0),
(224, 'Check IP manually', 1), (224, 'Use arp -a', 1), (224, 'Check DNS cache', 0), (224, 'Restart browser', 0),
(225, 'No link lights', 1), (225, 'Frequent disconnections', 1), (225, 'Slow website load', 0), (225, 'Browser crash', 0);

-- Questions (ID 231 - 250) - Dimension 13: AI Concepts
INSERT INTO questions (content, explaination, question_format, question_level_id, subject_lesson_id, subject_dimension_id) VALUES
-- MULTIPLE - one answer
( 'What does AI stand for?', 'AI is short for Artificial Intelligence.', 'multiple', 1, NULL, 13),
( 'Which of the following is an example of narrow AI?', 'Narrow AI is designed to perform a specific task.', 'multiple', 1, NULL, 13),
( 'Who is considered the father of Artificial Intelligence?', 'John McCarthy coined the term AI and contributed to its early development.', 'multiple', 2, NULL, 13),
( 'Which of the following best describes artificial general intelligence?', 'AGI can perform any intellectual task a human can.', 'multiple', 2, NULL, 13),
( 'Which area of philosophy is most relevant to AI ethics?', 'Ethics is concerned with moral behavior, which AI can affect.', 'multiple', 2, NULL, 13),
( 'What is the Turing Test used for?', 'It tests whether a machine exhibits intelligent behavior indistinguishable from a human.', 'multiple', 2, NULL, 13),
( 'Which of the following is not a typical application of AI?', 'Basic text editors do not use AI.', 'multiple', 1, NULL, 13),
( 'Which component is essential for an AI system to learn?', 'Data is fundamental for training AI systems.', 'multiple', 1, NULL, 13),
( 'Which company developed the AlphaGo AI?', 'DeepMind developed AlphaGo to play the board game Go.', 'multiple', 2, NULL, 13),
( 'Which of the following represents a major concern in AI development?', 'Bias can lead to unfair or harmful outcomes.', 'multiple', 3, NULL, 13),

-- MULTIPLE - multiple answers
( 'Which technologies are used in AI systems?', 'These are foundational technologies supporting AI.', 'multiple', 2, NULL, 13),
( 'Which are types of Artificial Intelligence?', 'AI can be categorized based on capability.', 'multiple', 2, NULL, 13),
( 'Which fields contribute to AI development?', 'AI is an interdisciplinary field.', 'multiple', 3, NULL, 13),
( 'Which concerns are associated with AI ethics?', 'Ethical AI involves fairness, accountability, and transparency.', 'multiple', 3, NULL, 13),
( 'Which abilities are associated with strong AI?', 'Strong AI mimics full human reasoning and understanding.', 'multiple', 3, NULL, 13),

-- ESSAY
( 'Discuss the difference between narrow AI and general AI.', 'Narrow AI focuses on specific tasks, while AGI aims for general reasoning.', 'essay', 2, NULL, 13),
( 'Explain the importance of data in training AI models.', 'AI models require quality data to learn patterns and make decisions.', 'essay', 2, NULL, 13),
( 'What are the ethical implications of AI in hiring?', 'AI bias in recruitment tools can lead to discrimination.', 'essay', 3, NULL, 13),
( 'Describe how the Turing Test evaluates machine intelligence.', 'The Turing Test assesses if a machine can imitate human responses.', 'essay', 2, NULL, 13),
( 'How can we ensure AI systems are transparent and fair?', 'Include model interpretability, diverse datasets, and auditing processes.', 'essay', 3, NULL, 13);

-- Options for MULTIPLE (Q231 → Q245)
INSERT INTO question_options (question_id, option_content, is_answer) VALUES
-- One-answer
(231, 'Artificial Intelligence', 1), (231, 'Automated Input', 0), (231, 'Applied Integration', 0), (231, 'Augmented Infrastructure', 0),
(232, 'Spam email filter', 1), (232, 'Conscious robot', 0), (232, 'AGI system', 0), (232, 'Human-level AI', 0),
(233, 'John McCarthy', 1), (233, 'Alan Turing', 0), (233, 'Elon Musk', 0), (233, 'Andrew Ng', 0),
(234, 'AI that can do anything a human can', 1), (234, 'AI limited to one task', 0), (234, 'AI in games only', 0), (234, 'AI without learning', 0),
(235, 'Ethics', 1), (235, 'Aesthetics', 0), (235, 'Logic', 0), (235, 'Ontology', 0),
(236, 'To test machine intelligence', 1), (236, 'To measure processing speed', 0), (236, 'To check for syntax errors', 0), (236, 'To train neural networks', 0),
(237, 'Basic text editor', 1), (237, 'Chatbot', 0), (237, 'Image recognition system', 0), (237, 'Autonomous vehicle', 0),
(238, 'Data', 1), (238, 'Paint', 0), (238, 'Screws', 0), (238, 'Glue', 0),
(239, 'DeepMind', 1), (239, 'Google Translate', 0), (239, 'OpenAI', 0), (239, 'Meta AI', 0),
(240, 'Bias in decision-making', 1), (240, 'Faster typing', 0), (240, 'Color theme design', 0), (240, 'Power supply', 0),

-- Multi-answer
(241, 'Machine learning', 1), (241, 'Neural networks', 1), (241, 'Bluetooth', 0), (241, 'Big data', 1),
(242, 'Narrow AI', 1), (242, 'General AI', 1), (242, 'Meta AI', 0), (242, 'Supervised Data', 0),
(243, 'Mathematics', 1), (243, 'Psychology', 1), (243, 'Literature', 0), (243, 'Computer science', 1),
(244, 'Bias', 1), (244, 'Accountability', 1), (244, 'Transparency', 1), (244, 'Color blindness', 0),
(245, 'Self-awareness', 1), (245, 'Reasoning', 1), (245, 'Limited task completion', 0), (245, 'Task repetition', 0);

-- Questions (ID 251 - 270) - Dimension 14: Machine Learning Basics
INSERT INTO questions (content, explaination, question_format, question_level_id, subject_lesson_id, subject_dimension_id) VALUES
-- MULTIPLE - one answer
( 'What is the main goal of supervised learning?', 'Supervised learning aims to predict labels from labeled data.', 'multiple', 2, NULL, 14),
( 'Which algorithm is commonly used for classification tasks?', 'Decision trees are widely used for classification.', 'multiple', 2, NULL, 14),
( 'Which evaluation metric is best for imbalanced classification?', 'F1 score balances precision and recall.', 'multiple', 3, NULL, 14),
( 'Which method helps prevent overfitting in machine learning models?', 'Regularization penalizes model complexity.', 'multiple', 3, NULL, 14),
( 'Which algorithm is best suited for clustering problems?', 'K-Means is a popular clustering technique.', 'multiple', 2, NULL, 14),
( 'Which of the following is a supervised learning problem?', 'Predicting house price with known prices is supervised.', 'multiple', 2, NULL, 14),
( 'Which machine learning algorithm works by constructing decision boundaries?', 'Support Vector Machines separate data using hyperplanes.', 'multiple', 3, NULL, 14),
( 'What is a common cause of underfitting?', 'Models that are too simple can underfit the data.', 'multiple', 2, NULL, 14),
( 'Which model is most interpretable by humans?', 'Decision trees are easier to understand than black-box models.', 'multiple', 1, NULL, 14),
( 'Which of the following involves learning without labels?', 'Unsupervised learning uses only input data.', 'multiple', 1, NULL, 14),

-- MULTIPLE - multiple answers
( 'Which are examples of supervised learning algorithms?', 'Supervised algorithms learn from labeled data.', 'multiple', 2, NULL, 14),
( 'Which issues can arise from overfitting?', 'Overfitting leads to poor generalization.', 'multiple', 3, NULL, 14),
( 'Which tasks can machine learning solve?', 'ML applies to many real-world prediction and classification tasks.', 'multiple', 2, NULL, 14),
( 'Which steps are typically involved in the ML pipeline?', 'From data preprocessing to evaluation.', 'multiple', 2, NULL, 14),
( 'Which practices improve model performance?', 'These methods enhance model accuracy and generalization.', 'multiple', 3, NULL, 14),

-- ESSAY
( 'Explain the difference between supervised and unsupervised learning.', 'Focus on label availability and task types.', 'essay', 2, NULL, 14),
( 'Discuss the role of training and testing data in model evaluation.', 'Split data prevents data leakage and ensures fairness.', 'essay', 2, NULL, 14),
( 'Why is feature selection important in machine learning?', 'It reduces dimensionality and improves model efficiency.', 'essay', 3, NULL, 14),
( 'How does cross-validation help assess model performance?', 'It provides a more robust estimate of generalization error.', 'essay', 3, NULL, 14),
( 'Describe the trade-off between bias and variance in ML models.', 'Balance is needed for optimal model performance.', 'essay', 3, NULL, 14);

-- Options for MULTIPLE (Q251 → Q265)
INSERT INTO question_options (question_id, option_content, is_answer) VALUES
-- One-answer
(251, 'To predict output labels from input data', 1), (251, 'To find clusters in data', 0), (251, 'To compress data', 0), (251, 'To clean missing values', 0),
(252, 'Decision Tree', 1), (252, 'K-Means', 0), (252, 'Autoencoder', 0), (252, 'Apriori', 0),
(253, 'F1 Score', 1), (253, 'Accuracy', 0), (253, 'Mean Squared Error', 0), (253, 'R-squared', 0),
(254, 'Regularization', 1), (254, 'Over-sampling', 0), (254, 'Gradient descent', 0), (254, 'Dropout only', 0),
(255, 'K-Means', 1), (255, 'Logistic Regression', 0), (255, 'Linear Regression', 0), (255, 'Naive Bayes', 0),
(256, 'Predicting house prices', 1), (256, 'Customer segmentation', 0), (256, 'Market basket analysis', 0), (256, 'Anomaly detection without labels', 0),
(257, 'Support Vector Machine', 1), (257, 'Linear Regression', 0), (257, 'KNN', 0), (257, 'Naive Bayes', 0),
(258, 'Model too simple', 1), (258, 'Too much data', 0), (258, 'High variance', 0), (258, 'No missing values', 0),
(259, 'Decision Tree', 1), (259, 'Neural Network', 0), (259, 'Ensemble models', 0), (259, 'Autoencoder', 0),
(260, 'Unsupervised learning', 1), (260, 'Supervised learning', 0), (260, 'Semi-supervised learning', 0), (260, 'Reinforcement learning', 0),

-- Multi-answer
(261, 'Logistic Regression', 1), (261, 'Random Forest', 1), (261, 'K-Means', 0), (261, 'SVM', 1),
(262, 'Poor generalization', 1), (262, 'Memorizing training data', 1), (262, 'High test accuracy', 0), (262, 'Bias reduction only', 0),
(263, 'Image classification', 1), (263, 'Speech recognition', 1), (263, 'Weather simulation', 1), (263, 'Fingerprint scanning hardware', 0),
(264, 'Data cleaning', 1), (264, 'Feature engineering', 1), (264, 'Model training', 1), (264, 'Keyboard input', 0),
(265, 'Hyperparameter tuning', 1), (265, 'Cross-validation', 1), (265, 'Data leakage', 0), (265, 'Adding noise randomly', 0);

-- Questions (ID 271 - 290) - Dimension 15: Python Libraries
INSERT INTO questions (content, explaination, question_format, question_level_id, subject_lesson_id, subject_dimension_id) VALUES
-- MULTIPLE - one answer
( 'Which Python library is widely used for numerical computations?', 'NumPy provides efficient array operations and numerical tools.', 'multiple', 2, NULL, 15),
( 'Which Python library provides data structures like Series and DataFrame?', 'Pandas is commonly used for data manipulation.', 'multiple', 2, NULL, 15),
( 'Which library is commonly used for plotting graphs in Python?', 'Matplotlib allows creation of various chart types.', 'multiple', 1, NULL, 15),
( 'Which library is built on top of NumPy and supports machine learning?', 'Scikit-learn provides ML algorithms and tools.', 'multiple', 2, NULL, 15),
( 'Which Python package is designed specifically for deep learning?', 'TensorFlow supports neural network modeling and training.', 'multiple', 3, NULL, 15),
( 'Which function in NumPy creates an array filled with zeros?', 'np.zeros creates an array of zeros.', 'multiple', 1, NULL, 15),
( 'Which data structure does pandas use to store tabular data?', 'DataFrame is a 2D labeled data structure.', 'multiple', 1, NULL, 15),
( 'Which method is used in pandas to handle missing values?', 'fillna is used to replace missing values.', 'multiple', 2, NULL, 15),
( 'Which package is most suitable for building neural networks?', 'TensorFlow is used for designing and training neural nets.', 'multiple', 3, NULL, 15),
( 'Which visualization library is used to create interactive web-based plots?', 'Plotly enables interactive, dynamic plots.', 'multiple', 2, NULL, 15),

-- MULTIPLE - multiple answers
( 'Which libraries are used for machine learning in Python?', 'These libraries offer tools for training and testing ML models.', 'multiple', 3, NULL, 15),
( 'Which pandas methods are used for data selection?', 'loc and iloc are used for indexing and slicing.', 'multiple', 2, NULL, 15),
( 'Which libraries can be used for data visualization?', 'Multiple Python libraries are available for plotting.', 'multiple', 2, NULL, 15),
( 'Which Python libraries support tensor operations?', 'TensorFlow and PyTorch are built to handle tensors.', 'multiple', 3, NULL, 15),
( 'Which are common uses of NumPy?', 'NumPy handles array math and linear algebra operations.', 'multiple', 2, NULL, 15),

-- ESSAY
( 'Compare NumPy and pandas in terms of their use cases.', 'NumPy is for numerical arrays, pandas is for labeled tabular data.', 'essay', 2, NULL, 15),
( 'Explain the role of scikit-learn in a machine learning project.', 'It provides accessible tools for training, evaluation, and model selection.', 'essay', 3, NULL, 15),
( 'Discuss how Matplotlib and Seaborn differ in data visualization.', 'Matplotlib offers more control, Seaborn provides prettier defaults.', 'essay', 2, NULL, 15),
( 'Describe how missing data can be handled using pandas.', 'Use methods like dropna or fillna depending on context.', 'essay', 2, NULL, 15),
( 'Explain why TensorFlow and PyTorch are important for AI development.', 'They offer efficient computation for deep learning tasks.', 'essay', 3, NULL, 15);

-- Options for MULTIPLE (Q271 → Q285)
INSERT INTO question_options (question_id, option_content, is_answer) VALUES
-- One-answer
(271, 'NumPy', 1), (271, 'matplotlib', 0), (271, 'scikit-learn', 0), (271, 'flask', 0),
(272, 'pandas', 1), (272, 'seaborn', 0), (272, 'NumPy', 0), (272, 'OpenCV', 0),
(273, 'matplotlib', 1), (273, 'pandas', 0), (273, 'NumPy', 0), (273, 'Keras', 0),
(274, 'scikit-learn', 1), (274, 'pandas', 0), (274, 'matplotlib', 0), (274, 'SQLAlchemy', 0),
(275, 'TensorFlow', 1), (275, 'OpenCV', 0), (275, 'matplotlib', 0), (275, 'pandas', 0),
(276, 'np.zeros()', 1), (276, 'np.ones()', 0), (276, 'np.array()', 0), (276, 'np.fill()', 0),
(277, 'DataFrame', 1), (277, 'Series', 0), (277, 'Array', 0), (277, 'List', 0),
(278, 'fillna()', 1), (278, 'drop_duplicates()', 0), (278, 'groupby()', 0), (278, 'merge()', 0),
(279, 'TensorFlow', 1), (279, 'pandas', 0), (279, 'matplotlib', 0), (279, 'skimage', 0),
(280, 'Plotly', 1), (280, 'scikit-learn', 0), (280, 'NumPy', 0), (280, 'bs4', 0),

-- Multi-answer
(281, 'scikit-learn', 1), (281, 'XGBoost', 1), (281, 'Keras', 1), (281, 'pandas', 0),
(282, 'loc', 1), (282, 'iloc', 1), (282, 'merge', 0), (282, 'append', 0),
(283, 'matplotlib', 1), (283, 'seaborn', 1), (283, 'Plotly', 1), (283, 'NumPy', 0),
(284, 'TensorFlow', 1), (284, 'PyTorch', 1), (284, 'Requests', 0), (284, 'SciPy', 0),
(285, 'Linear algebra', 1), (285, 'Array broadcasting', 1), (285, 'Image scraping', 0), (285, 'HTML parsing', 0);

-- Questions (ID 291 - 310) - Dimension 16: AI Applications
INSERT INTO questions (content, explaination, question_format, question_level_id, subject_lesson_id, subject_dimension_id) VALUES
-- MULTIPLE - one answer
( 'Which application commonly uses AI for speech recognition?', 'Virtual assistants like Siri use speech-to-text powered by AI.', 'multiple', 1, NULL, 16),
( 'Which domain uses AI to detect fraudulent transactions?', 'AI models analyze transaction patterns to spot fraud.', 'multiple', 2, NULL, 16),
( 'Which AI technique powers recommendation systems like Netflix?', 'Collaborative filtering is commonly used in recommendations.', 'multiple', 2, NULL, 16),
( 'What is used in AI to recognize faces in photos?', 'Computer vision with deep learning is applied in face recognition.', 'multiple', 2, NULL, 16),
( 'Which application of AI helps in autonomous driving?', 'Computer vision and sensor fusion are key in self-driving cars.', 'multiple', 3, NULL, 16),
( 'Which platform is known for using AI to detect spam emails?', 'Gmail applies ML models to detect and filter spam.', 'multiple', 1, NULL, 16),
( 'Which retail technology uses AI to suggest personalized products?', 'E-commerce platforms use AI to recommend products.', 'multiple', 2, NULL, 16),
( 'Which AI approach is often used in chatbots?', 'Natural Language Processing (NLP) enables understanding user inputs.', 'multiple', 2, NULL, 16),
( 'Which device typically uses AI for voice command control?', 'Smart speakers interpret spoken commands using AI.', 'multiple', 1, NULL, 16),
( 'Which type of AI system is used in financial market predictions?', 'Predictive models forecast market trends based on data.', 'multiple', 3, NULL, 16),

-- MULTIPLE - multiple answers
( 'Which of the following use AI in real life?', 'Many industries leverage AI to automate and improve systems.', 'multiple', 1, NULL, 16),
( 'Which AI applications are found in healthcare?', 'AI supports diagnosis, imaging, and patient monitoring.', 'multiple', 2, NULL, 16),
( 'Which industries are adopting AI rapidly?', 'Several sectors use AI for automation and decision-making.', 'multiple', 2, NULL, 16),
( 'Which features are typical in AI-powered virtual assistants?', 'They can understand voice and perform tasks via AI.', 'multiple', 1, NULL, 16),
( 'Which tools are used in AI-driven image classification?', 'Deep learning frameworks support image classification.', 'multiple', 3, NULL, 16),

-- ESSAY
( 'Describe how AI is used in e-commerce platforms.', 'AI helps personalize product recommendations and optimize pricing.', 'essay', 2, NULL, 16),
( 'Discuss the impact of AI in modern healthcare systems.', 'AI improves diagnostics and patient care via data-driven insights.', 'essay', 3, NULL, 16),
( 'Compare the use of AI in autonomous vehicles and drones.', 'Both rely on sensors and computer vision, but environments differ.', 'essay', 3, NULL, 16),
( 'Explain the importance of explainable AI in critical systems.', 'Transparency in AI decisions is vital for trust and accountability.', 'essay', 3, NULL, 16),
( 'Evaluate the ethical concerns of AI in surveillance.', 'AI surveillance raises issues around privacy and bias.', 'essay', 2, NULL, 16);

-- Options for MULTIPLE (Q291 → Q305)
INSERT INTO question_options (question_id, option_content, is_answer) VALUES
-- One-answer
(291, 'Siri', 1), (291, 'Google Maps', 0), (291, 'Instagram', 0), (291, 'Slack', 0),
(292, 'Banking systems', 1), (292, 'Weather apps', 0), (292, 'Gaming consoles', 0), (292, 'Video players', 0),
(293, 'Collaborative filtering', 1), (293, 'Neural translation', 0), (293, 'Backpropagation', 0), (293, 'Web scraping', 0),
(294, 'Deep learning', 1), (294, 'Sorting algorithm', 0), (294, 'Web crawler', 0), (294, 'Syntax tree', 0),
(295, 'Computer vision', 1), (295, 'File compression', 0), (295, 'HTTP caching', 0), (295, 'DNS lookup', 0),
(296, 'Gmail', 1), (296, 'Google Docs', 0), (296, 'WhatsApp', 0), (296, 'Excel', 0),
(297, 'Amazon', 1), (297, 'Reddit', 0), (297, 'Zoom', 0), (297, 'Dropbox', 0),
(298, 'NLP', 1), (298, 'Regex', 0), (298, 'DNS', 0), (298, 'HTML parser', 0),
(299, 'Smart speakers', 1), (299, 'MP3 players', 0), (299, 'Flash drives', 0), (299, 'Projectors', 0),
(300, 'Predictive analytics', 1), (300, 'File encryption', 0), (300, 'Word processing', 0), (300, 'Screen recording', 0),

-- Multi-answer
(301, 'Self-driving cars', 1), (301, 'Email spam filters', 1), (301, 'Online shopping', 1), (301, 'Electric fans', 0),
(302, 'Medical image analysis', 1), (302, 'Patient data prediction', 1), (302, 'Online booking', 0), (302, 'Blog writing', 0),
(303, 'Finance', 1), (303, 'Retail', 1), (303, 'Agriculture', 1), (303, 'Washing machines', 0),
(304, 'Voice recognition', 1), (304, 'Context understanding', 1), (304, 'Manual configuration', 0), (304, 'Firewall setting', 0),
(305, 'TensorFlow', 1), (305, 'PyTorch', 1), (305, 'Notepad', 0), (305, 'Photoshop', 0);

-- Questions for lesson_id = 1, starting from question_id = 311
-- Multiple choice (10 single answer, 5 multiple answers) and 5 essay questions

INSERT INTO questions (content, explaination, question_format, question_level_id, subject_lesson_id, subject_dimension_id) VALUES
                                                                                                                               ('What is the primary purpose of a compiler?', 'A compiler translates source code into machine code.', 'multiple', 1, 1, NULL), -- 311
                                                                                                                               ('Which of the following best describes an algorithm?', 'An algorithm is a step-by-step procedure to solve a problem.', 'multiple', 1, 1, NULL), -- 312
                                                                                                                               ('Which language is commonly used for teaching introductory programming?', 'Python is widely used due to its simplicity and readability.', 'multiple', 1, 1, NULL), -- 313
                                                                                                                               ('Which of the following is NOT a programming language?', 'HTML is a markup language, not a programming language.', 'multiple', 1, 1, NULL), -- 314
                                                                                                                               ('What is the output of 5 + 3 * 2 in most programming languages?', 'Multiplication has higher precedence than addition.', 'multiple', 2, 1, NULL), -- 315
                                                                                                                               ('Which tool helps in writing and managing source code?', 'An IDE provides features like debugging, syntax highlighting.', 'multiple', 1, 1, NULL), -- 316
                                                                                                                               ('Which of the following is used for version control?', 'Git is a widely used distributed version control system.', 'multiple', 1, 1, NULL), -- 317
                                                                                                                               ('What is a variable in programming?', 'A variable is a storage location associated with a name.', 'multiple', 1, 1, NULL), -- 318
                                                                                                                               ('Which of these is a valid data type?', 'Integer is a common data type used to store whole numbers.', 'multiple', 1, 1, NULL), -- 319
                                                                                                                               ('Which statement is used to output text in most programming languages?', 'Print statements are used to display output.', 'multiple', 1, 1, NULL), -- 320
-- Multiple answers
                                                                                                                               ('Which of the following are programming languages?', 'Python, Java, and C++ are programming languages.', 'multiple', 1, 1, NULL), -- 321
                                                                                                                               ('Which of these tools are used for debugging?', 'Both IDEs and command-line tools support debugging.', 'multiple', 2, 1, NULL), -- 322
                                                                                                                               ('Which components are part of an IDE?', 'IDEs include editors, compilers, and debuggers.', 'multiple', 2, 1, NULL), -- 323
                                                                                                                               ('Which of the following are examples of interpreted languages?', 'Python and JavaScript are interpreted languages.', 'multiple', 2, 1, NULL), -- 324
                                                                                                                               ('Which file extensions indicate source code files?', 'Source code files use extensions like .py, .java, .c.', 'multiple', 1, 1, NULL), -- 325
-- Essay
                                                                                                                               ('Explain the role of a compiler in program execution.', 'Compilers translate high-level code into machine-executable code.', 'essay', 2, 1, NULL), -- 326
                                                                                                                               ('Describe the difference between syntax and semantics in programming.', 'Syntax refers to structure; semantics to meaning.', 'essay', 2, 1, NULL), -- 327
                                                                                                                               ('How does an IDE help a beginner programmer?', 'IDEs offer tools to simplify writing and testing code.', 'essay', 1, 1, NULL), -- 328
                                                                                                                               ('Discuss the importance of learning programming fundamentals.', 'Understanding fundamentals builds a strong programming foundation.', 'essay', 2, 1, NULL), -- 329
                                                                                                                               ('What are the common errors faced by new programmers?', 'Syntax errors, logic errors, and runtime errors are typical.', 'essay', 2, 1, NULL);

-- Options for the multiple choice questions
INSERT INTO question_options (question_id, option_content, is_answer) VALUES
-- Q311
(311, 'To translate source code into machine code', 1),
(311, 'To run the program step-by-step', 0),
(311, 'To store data in memory', 0),
(311, 'To connect to the internet', 0),
-- Q312
(312, 'A programming error', 0),
(312, 'A data structure', 0),
(312, 'A set of instructions', 1),
(312, 'A type of variable', 0),
-- Q313
(313, 'Python', 1),
(313, 'Assembly', 0),
(313, 'COBOL', 0),
(313, 'Haskell', 0),
-- Q314
(314, 'Python', 0),
(314, 'HTML', 1),
(314, 'Java', 0),
(314, 'C#', 0),
-- Q315
(315, '16', 0),
(315, '11', 1),
(315, '13', 0),
(315, '10', 0),
-- Q316
(316, 'Spreadsheet', 0),
(316, 'IDE', 1),
(316, 'Text Editor only', 0),
(316, 'Compiler only', 0),
-- Q317
(317, 'Git', 1),
(317, 'FTP', 0),
(317, 'SSH', 0),
(317, 'VPN', 0),
-- Q318
(318, 'A number only', 0),
(318, 'A memory location with a name', 1),
(318, 'A type of loop', 0),
(318, 'A type of operator', 0),
-- Q319
(319, 'Integer', 1),
(319, 'Method', 0),
(319, 'Loop', 0),
(319, 'Function', 0),
-- Q320
(320, 'print', 1),
(320, 'write', 0),
(320, 'speak', 0),
(320, 'log', 0),
-- Q321
(321, 'Python', 1),
(321, 'Excel', 0),
(321, 'C++', 1),
(321, 'Java', 1),
(321, 'Photoshop', 0),
-- Q322
(322, 'Debugger', 1),
(322, 'Compiler', 0),
(322, 'IDE', 1),
(322, 'File manager', 0),
-- Q323
(323, 'Code editor', 1),
(323, 'Compiler', 1),
(323, 'Debugger', 1),
(323, 'Search engine', 0),
-- Q324
(324, 'Python', 1),
(324, 'C++', 0),
(324, 'JavaScript', 1),
(324, 'Assembly', 0),
-- Q325
(325, '.exe', 0),
(325, '.py', 1),
(325, '.java', 1),
(325, '.docx', 0),
(325, '.c', 1);

-- MULTIPLE (1 đáp án đúng)
INSERT INTO questions (content, explaination, question_format, question_level_id, subject_lesson_id, subject_dimension_id) VALUES
                                                                                                                               ('Which keyword is used to declare a variable in Java?', 'The "int" keyword is used to declare an integer variable.', 'multiple', 1, 2, NULL),
                                                                                                                               ('What is the default value of an uninitialized boolean in Java?', 'Default boolean value is false.', 'multiple', 1, 2, NULL),
                                                                                                                               ('Which of the following denotes a character in Java?', 'Single quotes are used for characters.', 'multiple', 1, 2, NULL),
                                                                                                                               ('Which data type is used to store decimal values in Java?', 'float and double are used for decimals.', 'multiple', 2, 2, NULL),
                                                                                                                               ('Which of the following is a valid variable name in Java?', 'A variable name must start with a letter and not contain special characters.', 'multiple', 1, 2, NULL),
                                                                                                                               ('Which type of casting is done automatically in Java?', 'Widening casting is done automatically.', 'multiple', 2, 2, NULL),
                                                                                                                               ('What does "int x = 5.5;" cause in Java?', 'This causes a compilation error due to type mismatch.', 'multiple', 2, 2, NULL),
                                                                                                                               ('Which is the largest primitive data type in Java?', 'The double data type has the largest range.', 'multiple', 3, 2, NULL),
                                                                                                                               ('How many bytes does a Java int occupy?', 'int occupies 4 bytes or 32 bits.', 'multiple', 2, 2, NULL),
                                                                                                                               ('Which of the following can hold only one character?', 'char is used for single characters.', 'multiple', 1, 2, NULL),

-- MULTIPLE (nhiều đáp án đúng)
                                                                                                                               ('Which of the following are valid primitive data types in Java?', 'Java has 8 primitive types.', 'multiple', 2, 2, NULL),
                                                                                                                               ('Which names are invalid for variable declaration in Java?', 'Variables cannot start with digits or use reserved words.', 'multiple', 3, 2, NULL),
                                                                                                                               ('Which types can store whole numbers in Java?', 'byte, short, int, and long store integers.', 'multiple', 1, 2, NULL),
                                                                                                                               ('Which of the following are widening conversions in Java?', 'Widening happens from smaller to larger types.', 'multiple', 3, 2, NULL),
                                                                                                                               ('Which of the following keywords are used to declare constants in Java?', 'The "final" keyword makes a variable constant.', 'multiple', 2, 2, NULL),

-- ESSAY
                                                                                                                               ('Explain the difference between float and double in Java.', 'Discuss precision and size of each type.', 'essay', 2, 2, NULL),
                                                                                                                               ('Describe the naming conventions for Java variables.', 'CamelCase, no starting digits, no special characters.', 'essay', 1, 2, NULL),
                                                                                                                               ('Compare primitive and reference data types in Java.', 'Discuss memory use and how values are stored.', 'essay', 3, 2, NULL),
                                                                                                                               ('Explain implicit and explicit type casting in Java.', 'Implicit is automatic, explicit requires cast syntax.', 'essay', 3, 2, NULL),
                                                                                                                               ('What happens when a variable is used before initialization in Java?', 'It causes a compile-time error.', 'essay', 2, 2, NULL);

-- OPTIONS for Multiple (1 đáp án đúng)
INSERT INTO question_options (question_id, option_content, is_answer) VALUES
                                                                          (331, 'var', 0), (331, 'int', 1), (331, 'String', 0), (331, 'define', 0),
                                                                          (332, 'true', 0), (332, 'false', 1), (332, '0', 0), (332, 'null', 0),
                                                                          (333, '"A"', 0), (333, 'A', 1), (333, 'AB', 0), (333, '"AB"', 0),
                                                                          (334, 'String', 0), (334, 'int', 0), (334, 'double', 1), (334, 'boolean', 0),
                                                                          (335, '2name', 0), (335, 'first_name', 1), (335, 'name!', 0), (335, 'void', 0),
                                                                          (336, 'Narrowing', 0), (336, 'Widening', 1), (336, 'Casting', 0), (336, 'Object', 0),
                                                                          (337, 'It runs normally', 0), (337, 'Causes warning', 0), (337, 'Causes error', 1), (337, 'Converts automatically', 0),
                                                                          (338, 'int', 0), (338, 'float', 0), (338, 'double', 1), (338, 'byte', 0),
                                                                          (339, '2 bytes', 0), (339, '4 bytes', 1), (339, '8 bytes', 0), (339, '1 byte', 0),
                                                                          (340, 'char', 1), (340, 'String', 0), (340, 'int', 0), (340, 'double', 0),

-- OPTIONS for Multiple (nhiều đáp án đúng)
                                                                          (341, 'int', 1), (341, 'float', 1), (341, 'char', 1), (341, 'String', 0),
                                                                          (342, '2cool', 1), (342, 'first-name', 1), (342, 'total$', 1), (342, 'void', 1),
                                                                          (343, 'byte', 1), (343, 'int', 1), (343, 'float', 0), (343, 'long', 1),
                                                                          (344, 'int to long', 1), (344, 'short to int', 1), (344, 'long to byte', 0), (344, 'double to int', 0),
                                                                          (345, 'const', 0), (345, 'final', 1), (345, 'var', 0), (345, 'static final', 1);

-- INSERT cả câu hỏi và lựa chọn cho lesson_id = 3
INSERT INTO questions (content, explaination, question_format, question_level_id, subject_lesson_id, subject_dimension_id) VALUES
-- MULTIPLE - 1 correct
('What is the correct syntax of an if-statement in Java?', 'An if-statement requires parentheses around condition and braces for block.', 'multiple', 1, 3, NULL),
('Which keyword is used for an alternative block in conditional statements?', 'The "else" keyword is used for the alternative path.', 'multiple', 1, 3, NULL),
('Which loop is guaranteed to execute at least once?', 'The do-while loop checks the condition after executing once.', 'multiple', 2, 3, NULL),
('What is the output of: if(false) { System.out.println("Hi"); } else { System.out.println("Bye"); }', 'Since condition is false, "Bye" is printed.', 'multiple', 1, 3, NULL),
('Which keyword is used to exit a loop prematurely?', 'The "break" statement exits the loop immediately.', 'multiple', 2, 3, NULL),
('What is the purpose of continue statement in a loop?', 'It skips the current iteration and continues with the next one.', 'multiple', 2, 3, NULL),
('Which loop is most suitable when the number of iterations is known?', 'A for loop is ideal when loop count is fixed.', 'multiple', 1, 3, NULL),
('What type of loop is best for reading input until a condition is met?', 'A while loop is suited for unknown iteration count.', 'multiple', 2, 3, NULL),
('What does a switch statement operate on?', 'Switch can work with int, char, String, enums (since Java 7).', 'multiple', 2, 3, NULL),
('What is the output of: for(int i=0;i<3;i++) { System.out.print(i); }', 'It prints 012 as loop runs 3 times.', 'multiple', 2, 3, NULL),

-- MULTIPLE - multiple correct
('Which are valid loop control structures in Java?', 'for, while, and do-while are all valid loop types.', 'multiple', 1, 3, NULL),
('Which of the following can be used in a switch expression?', 'As of Java 7+, String is allowed; also int and char.', 'multiple', 3, 3, NULL),
('Which of the following are true about break and continue?', 'They control loop flow in different ways.', 'multiple', 2, 3, NULL),
('Which statements are valid inside an if block?', 'Any valid Java statement can go inside a block.', 'multiple', 2, 3, NULL),
('Which are best practices in control structures?', 'Readable code and avoiding deep nesting are best practices.', 'multiple', 3, 3, NULL),

-- ESSAY
('Compare while and do-while loops with examples.', 'Focus on entry-check vs exit-check behavior.', 'essay', 2, 3, NULL),
('Explain the working of a switch-case structure in Java.', 'Show how it selects cases and importance of break.', 'essay', 2, 3, NULL),
('Describe nested if-else and how to avoid deep nesting.', 'Discuss use of switch or early returns.', 'essay', 3, 3, NULL),
('What is the role of break and continue in loops?', 'Discuss differences and use cases.', 'essay', 2, 3, NULL),
('How does loop variable scope work in Java?', 'Explain visibility of loop counters inside and outside loop.', 'essay', 3, 3, NULL);

-- OPTIONS
INSERT INTO question_options (question_id, option_content, is_answer) VALUES
-- One correct
(351, 'if condition then { ... }', 0), (351, 'if (condition) { ... }', 1), (351, 'if condition: { ... }', 0), (351, 'if { condition }', 0),
(352, 'elseif', 0), (352, 'else', 1), (352, 'switch', 0), (352, 'otherwise', 0),
(353, 'for loop', 0), (353, 'while loop', 0), (353, 'do-while loop', 1), (353, 'foreach loop', 0),
(354, 'Hi', 0), (354, 'Bye', 1), (354, 'HiBye', 0), (354, 'Nothing', 0),
(355, 'exit', 0), (355, 'break', 1), (355, 'continue', 0), (355, 'stop', 0),
(356, 'Ends the loop', 0), (356, 'Restarts the loop', 0), (356, 'Skips current iteration', 1), (356, 'Throws error', 0),
(357, 'while', 0), (357, 'for', 1), (357, 'do-while', 0), (357, 'switch', 0),
(358, 'for', 0), (358, 'while', 1), (358, 'do-while', 0), (358, 'goto', 0),
(359, 'Only int', 0), (359, 'int and char', 1), (359, 'int, char, String', 1), (359, 'float', 0),
(360, '123', 0), (360, '012', 1), (360, '0123', 0), (360, '0 1 2', 0),

-- Multiple correct
(361, 'for', 1), (361, 'foreach', 0), (361, 'while', 1), (361, 'do-while', 1),
(362, 'int', 1), (362, 'String', 1), (362, 'boolean', 0), (362, 'float', 0),
(363, 'break exits loop', 1), (363, 'continue skips iteration', 1), (363, 'break skips iteration', 0), (363, 'continue exits loop', 0),
(364, 'Variable declarations', 1), (364, 'Method calls', 1), (364, 'Class declarations', 0), (364, 'Print statements', 1),
(365, 'Use braces even for 1 line', 1), (365, 'Use switch over deep if-else', 1), (365, 'Avoid meaningful names', 0), (365, 'Deep nesting is fine', 0);

-- INSERT câu hỏi
INSERT INTO questions (content, explaination, question_format, question_level_id, subject_lesson_id, subject_dimension_id) VALUES
-- MULTIPLE - 1 correct
('What is the keyword used to define a method in Java?', 'Methods are defined using the "void" or return type and a name.', 'multiple', 1, 4, NULL),
('Which part of a method defines its return type?', 'Return type appears before the method name.', 'multiple', 1, 4, NULL),
('Which keyword is used to exit from a method?', 'The "return" keyword sends back a value and exits method.', 'multiple', 1, 4, NULL),
('What is the purpose of method overloading?', 'It allows methods with the same name but different parameters.', 'multiple', 2, 4, NULL),
('What is the correct way to call a method named greet?', 'Method calls must include parentheses.', 'multiple', 1, 4, NULL),
('Which modifier makes a method accessible without creating an object?', 'Static methods belong to the class, not the instance.', 'multiple', 2, 4, NULL),
('Which of the following is true about parameters and arguments?', 'Parameters are in the method declaration, arguments are passed during call.', 'multiple', 2, 4, NULL),
('What is the default return type if none is specified in Java?', 'All methods must specify a return type; void means no return.', 'multiple', 2, 4, NULL),
('Which type of methods are inherited from Object class?', 'Every class inherits methods like toString(), equals().', 'multiple', 3, 4, NULL),
('Which is an example of a recursive method?', 'A method calling itself is recursive.', 'multiple', 3, 4, NULL),

-- MULTIPLE - multiple correct
('Which of the following are valid return types for a method?', 'Any data type including void, int, String etc.', 'multiple', 1, 4, NULL),
('Which statements are true about static methods?', 'Static methods can be called using the class name.', 'multiple', 2, 4, NULL),
('Which are benefits of using methods in programming?', 'Modularity and reusability are key benefits.', 'multiple', 1, 4, NULL),
('Which components make up a method signature?', 'Method name and parameter types define the signature.', 'multiple', 2, 4, NULL),
('Which are rules for method overloading?', 'It must differ by number or type of parameters.', 'multiple', 2, 4, NULL),

-- ESSAY
('Explain the difference between parameters and arguments in methods.', 'Focus on declaration vs calling time.', 'essay', 2, 4, NULL),
('Describe method overloading with an example.', 'Use two methods with same name but different parameters.', 'essay', 2, 4, NULL),
('What are static methods? Give a real example.', 'Mention utility functions like Math.sqrt().', 'essay', 2, 4, NULL),
('Discuss the importance of using return values in methods.', 'Return values allow functions to output results.', 'essay', 3, 4, NULL),
('What is recursion? Describe with an example.', 'A function calling itself repeatedly.', 'essay', 3, 4, NULL);

-- INSERT options
INSERT INTO question_options (question_id, option_content, is_answer) VALUES
-- One correct
(371, 'method', 0), (371, 'define', 0), (371, 'void', 0), (371, 'public void greet()', 0), (371, 'int', 1),
(372, 'Method name', 0), (372, 'Return type', 1), (372, 'Parameters', 0), (372, 'Access modifier', 0),
(373, 'return', 1), (373, 'exit', 0), (373, 'stop', 0), (373, 'end', 0),
(374, 'To define variables', 0), (374, 'To reuse logic with different data', 1), (374, 'To compile code', 0), (374, 'To create loops', 0),
(375, 'call.greet', 0), (375, 'greet;', 0), (375, 'greet()', 1), (375, 'greet{}', 0),
(376, 'public', 0), (376, 'private', 0), (376, 'static', 1), (376, 'abstract', 0),
(377, 'Arguments are in declaration', 0), (377, 'Parameters are passed at runtime', 0), (377, 'Parameters are in declaration, arguments in call', 1), (377, 'They are the same', 0),
(378, 'void is the default', 0), (378, 'return is optional', 0), (378, 'Return type is required', 1), (378, 'Java assumes String return', 0),
(379, 'toString()', 1), (379, 'main()', 0), (379, 'print()', 0), (379, 'parseInt()', 0),
(380, 'A method that compiles another method', 0), (380, 'A method calling itself', 1), (380, 'Method with same name', 0), (380, 'None of the above', 0),

-- Multiple correct
(381, 'void', 1), (381, 'int', 1), (381, 'class', 0), (381, 'String', 1),
(382, 'Can use this keyword', 0), (382, 'Can be called without object', 1), (382, 'Access via class name', 1), (382, 'They can’t return values', 0),
(383, 'Helps organize code', 1), (383, 'Reduces duplication', 1), (383, 'Increases bugs', 0), (383, 'Improves readability', 1),
(384, 'Return type + method name', 0), (384, 'Method name + parameter types', 1), (384, 'Only method name', 0), (384, 'Modifiers + name', 0),
(385, 'Different return types', 0), (385, 'Same name, different parameter count', 1), (385, 'Same name, different parameter types', 1), (385, 'Same name only', 0);

-- INSERT câu hỏi
INSERT INTO questions (content, explaination, question_format, question_level_id, subject_lesson_id, subject_dimension_id) VALUES
-- MULTIPLE - 1 correct
('What is the first step in building a calculator program?', 'You must plan the functionality and user interaction.', 'multiple', 1, 5, NULL),
('Which operator is used for multiplication in Java?', 'The asterisk (*) is used to multiply numbers.', 'multiple', 1, 5, NULL),
('What data type is suitable to store decimal results?', 'float or double are used for decimal numbers.', 'multiple', 2, 5, NULL),
('How can you take input from the user in Java?', 'Scanner class reads input from the console.', 'multiple', 2, 5, NULL),
('What is the purpose of a switch-case in calculator apps?', 'Switch can help manage different operations.', 'multiple', 2, 5, NULL),
('Which keyword is used to define constant values in Java?', 'Use final to declare constants.', 'multiple', 2, 5, NULL),
('Which exception should be handled when dividing by zero?', 'ArithmeticException is thrown on divide by zero.', 'multiple', 3, 5, NULL),
('What will 10 / 3 return if both are integers in Java?', 'Integer division discards decimal part.', 'multiple', 1, 5, NULL),
('Which loop is best suited for repeatedly asking user input?', 'while loop is good when condition depends on user.', 'multiple', 2, 5, NULL),
('Which of the following is a valid method name in Java?', 'Method names follow camelCase and should be meaningful.', 'multiple', 1, 5, NULL),

-- MULTIPLE - multiple correct
('Which components are needed in a calculator app?', 'Input, processing logic, and output are essential.', 'multiple', 2, 5, NULL),
('Which types of errors should a calculator handle?', 'Divide by zero, invalid input, overflow etc.', 'multiple', 3, 5, NULL),
('Which classes can be used for user input?', 'Scanner and BufferedReader are common.', 'multiple', 2, 5, NULL),
('Which control structures are typically used in calculator apps?', 'If-else and switch are used to handle different operations.', 'multiple', 2, 5, NULL),
('Which data types can store calculation results?', 'int, float, double etc. can be used depending on precision.', 'multiple', 2, 5, NULL),

-- ESSAY
('Design a simple calculator that supports +, -, *, /. Explain how you’d handle invalid inputs.', 'Mention input validation, arithmetic logic, and error handling.', 'essay', 3, 5, NULL),
('Why is it important to modularize code in calculator programs?', 'Modularity makes testing and debugging easier.', 'essay', 2, 5, NULL),
('How can you enhance the calculator to support floating point arithmetic?', 'Discuss using double and handling rounding issues.', 'essay', 3, 5, NULL),
('Explain how loops can be used to build a continuous-use calculator.', 'Using while or do-while to repeat until exit.', 'essay', 2, 5, NULL),
('Describe how exception handling improves user experience in calculator programs.', 'Try-catch helps avoid crashes and give messages.', 'essay', 3, 5, NULL);

-- INSERT options
INSERT INTO question_options (question_id, option_content, is_answer) VALUES
-- One correct
(391, 'Start coding immediately', 0), (391, 'Plan the requirements', 1), (391, 'Install Java', 0), (391, 'Write main method', 0),
(392, '/', 0), (392, '*', 1), (392, 'x', 0), (392, '^', 0),
(393, 'int', 0), (393, 'float', 1), (393, 'boolean', 0), (393, 'char', 0),
(394, 'System.out.println()', 0), (394, 'Scanner', 1), (394, 'BufferedWriter', 0), (394, 'JOptionPane', 0),
(395, 'To perform calculations', 0), (395, 'To decide among operations', 1), (395, 'To declare variables', 0), (395, 'To end the program', 0),
(396, 'const', 0), (396, 'define', 0), (396, 'final', 1), (396, 'let', 0),
(397, 'IOException', 0), (397, 'NullPointerException', 0), (397, 'ArithmeticException', 1), (397, 'InputMismatchException', 0),
(398, '3.33', 0), (398, '3', 1), (398, '3.0', 0), (398, 'Error', 0),
(399, 'for loop', 0), (399, 'while loop', 1), (399, 'do-while only', 0), (399, 'foreach loop', 0),
(400, 'CalculateSum', 1), (400, '123method', 0), (400, 'class', 0), (400, 'public static', 0),

-- Multiple correct
(401, 'Input collection', 1), (401, 'Processing logic', 1), (401, 'AI module', 0), (401, 'Output display', 1),
(402, 'Divide by zero', 1), (402, 'Syntax error', 0), (402, 'InputMismatch', 1), (402, 'Overflow', 1),
(403, 'Scanner', 1), (403, 'BufferedReader', 1), (403, 'Random', 0), (403, 'Formatter', 0),
(404, 'if-else', 1), (404, 'for loop', 0), (404, 'switch-case', 1), (404, 'interface', 0),
(405, 'boolean', 0), (405, 'int', 1), (405, 'double', 1), (405, 'float', 1);

INSERT INTO [quiz_settings] ([number_question], [question_type])
VALUES
    (20, 'dimension'), (41, 'lesson'), (42, 'dimension'), (43, 'lesson'), (44, 'dimension'),
    (45, 'lesson'), (46, 'dimension'), (47, 'lesson'), (48, 'dimension'), (49, 'lesson'),
    (50, 'dimension'), (51, 'lesson'), (52, 'dimension'), (53, 'lesson'), (54, 'dimension'),
    (55, 'lesson'), (56, 'dimension'), (57, 'lesson'), (58, 'dimension'), (59, 'lesson'),
    (60, 'dimension'), (61, 'lesson'), (62, 'dimension'), (63, 'lesson'), (64, 'dimension'),
    (65, 'lesson'), (66, 'dimension'), (67, 'lesson'), (68, 'dimension'), (69, 'lesson'),
    (70, 'dimension'), (40, 'lesson'), (41, 'dimension'), (42, 'lesson'), (43, 'dimension'),
    (44, 'lesson'), (45, 'dimension'), (46, 'lesson'), (47, 'dimension'), (48, 'lesson');

-- Insert 40 quizzes
INSERT INTO [quizzes] ([format], [name], [question_level_id], [duration], [pass_rate], [description], [status], [test_type_id], [subject_id], [quiz_setting_id])
VALUES
    ('multiple', 'Programming Fundamentals Quiz', 1, 60*60, 70, 'Test your basic programming knowledge with variables, loops, and functions', 1, 1, 1, 1),
    ('essay', 'Advanced Programming Challenge', 3, 90, 80, 'Complex programming scenarios and algorithm design', 1, 2, 1, 2),
    ('multiple', 'SQL Basics Assessment', 1, 45, 65, 'Basic SQL queries, SELECT statements, and simple joins', 1, 1, 2, 3),
    ('essay', 'Database Design Quiz', 2, 75, 75, 'Normalization, relationships, and database optimization', 1, 2, 2, 4),
    ('multiple', 'Network Protocols Test', 2, 60, 70, 'TCP/IP, HTTP, DNS, and network troubleshooting', 1, 1, 3, 5),
    ('essay', 'Advanced Networking', 3, 120, 85, 'Subnetting, routing protocols, and network security', 1, 2, 3, 6),
    ('multiple', 'AI Fundamentals Quiz', 1, 50, 65, 'Introduction to machine learning concepts and algorithms', 1, 1, 4, 7),
    ('essay', 'Machine Learning Deep Dive', 3, 100, 80, 'Advanced ML algorithms, neural networks, and deep learning', 1, 2, 4, 8),
    ('multiple', 'Cybersecurity Basics', 2, 55, 70, 'Common threats, security measures, and best practices', 1, 1, 5, 9),
    ('essay', 'Security Advanced Topics', 3, 85, 85, 'Cryptography, penetration testing, and incident response', 1, 2, 5, 10),
    ('multiple', 'HTML & CSS Fundamentals', 1, 40, 60, 'Basic web structure, styling, and responsive design', 1, 1, 6, 11),
    ('multiple', 'JavaScript Essentials', 2, 65, 75, 'DOM manipulation, events, and asynchronous programming', 1, 2, 6, 12),
    ('multiple', 'Data Analysis Basics', 1, 55, 65, 'Statistical concepts, data visualization, and basic analytics', 1, 1, 7, 13),
    ('essay', 'Advanced Data Science', 3, 95, 85, 'Complex statistical models, machine learning, and big data', 1, 2, 7, 14),
    ('multiple', 'Node.js Fundamentals', 2, 70, 70, 'Server-side JavaScript, Express.js, and API development', 1, 1, 8, 15),
    ('essay', 'Backend Architecture Quiz', 3, 90, 80, 'Scalable systems, microservices, and database integration', 1, 2, 8, 16),
    ('multiple', 'Neural Networks Intro', 2, 80, 75, 'Basic neural network concepts and training algorithms', 1, 1, 9, 17),
    ('essay', 'Deep Learning Mastery', 3, 110, 85, 'CNNs, RNNs, and advanced deep learning architectures', 1, 2, 9, 18),
    ('multiple', 'Programming Logic Test', 1, 45, 65, 'Problem-solving with basic programming constructs', 1, 1, 1, 19),
    ('multiple', 'Object-Oriented Programming', 2, 75, 75, 'Classes, inheritance, polymorphism, and design patterns', 1, 2, 1, 20),
    ('essay', 'Database Queries Advanced', 3, 85, 80, 'Complex joins, subqueries, and performance optimization', 1, 1, 2, 21),
    ('essay', 'SQL Performance Tuning', 3, 90, 85, 'Index optimization, query plans, and database tuning', 1, 2, 2, 22),
    ('multiple', 'Network Security Basics', 2, 60, 70, 'Firewalls, VPNs, and network attack prevention', 1, 1, 3, 23),
    ('essay', 'Enterprise Networking', 3, 105, 85, 'Large-scale network design and management', 1, 2, 3, 24),
    ('multiple', 'AI Ethics and Applications', 1, 50, 65, 'Responsible AI, bias detection, and real-world applications', 1, 1, 4, 25),
    ('multiple', 'Computer Vision Basics', 2, 80, 75, 'Image processing, feature detection, and CNN applications', 1, 2, 4, 26),
    ('multiple', 'Information Security', 1, 55, 65, 'Data protection, access control, and security policies', 1, 1, 5, 27),
    ('essay', 'Ethical Hacking Intro', 3, 95, 85, 'Penetration testing, vulnerability assessment, and tools', 1, 2, 5, 28),
    ('multiple', 'React Fundamentals', 2, 70, 70, 'Component-based development, state management, and hooks', 1, 1, 6, 29),
    ('essay', 'Full-Stack Development', 3, 100, 80, 'End-to-end web application development', 1, 2, 6, 30),
    ('multiple', 'Statistical Analysis', 2, 75, 75, 'Hypothesis testing, regression analysis, and statistical inference', 1, 1, 7, 31),
    ('essay', 'Big Data Analytics', 3, 110, 85, 'Hadoop, Spark, and large-scale data processing', 1, 2, 7, 32),
    ('multiple', 'RESTful API Design', 2, 65, 70, 'API best practices, authentication, and documentation', 1, 1, 8, 33),
    ('essay', 'Microservices Architecture', 3, 95, 85, 'Distributed systems, containerization, and service mesh', 1, 2, 8, 34),
    ('multiple', 'TensorFlow Basics', 2, 80, 75, 'Building and training models with TensorFlow', 1, 1, 9, 35),
    ('essay', 'Advanced Deep Learning', 3, 120, 85, 'GANs, transfer learning, and model optimization', 1, 2, 9, 36),
    ('multiple', 'Web Development Basics', 1, 50, 60, 'HTML5, CSS3, and basic JavaScript concepts', 1, 1, 6, 37),
    ('multiple', 'Database Administration', 2, 85, 75, 'Backup, recovery, and database maintenance', 1, 2, 2, 38),
    ('multiple', 'Cloud Computing Intro', 1, 60, 65, 'Cloud services, deployment models, and basic concepts', 1, 1, 3, 39),
    ('multiple', 'DevOps Fundamentals', 2, 75, 70, 'CI/CD, automation, and infrastructure as code', 1, 2, 8, 40);

-- Insert quiz_setting_groups records
-- Each quiz_setting can have multiple groups
-- Each group contains different lessons OR dimensions (not mixed)
-- Total number_question across all groups for same quiz_setting_id equals number_question in quiz_settings
-- Based on question_type: 'lesson' groups -> subject_lesson_id populated, 'dimension' groups -> subject_dimension_id populated

INSERT INTO [quiz_setting_groups] ([number_question], [subject_lesson_id], [subject_dimension_id], [quiz_setting_id])
VALUES
-- Quiz Setting ID 1: 40 questions total, type 'dimension' -> split across multiple dimensions
    (5, NULL, 1, 1),  -- Variables and Data Types
    (5, NULL, 2, 1),  -- Control Structures
    (5, NULL, 3, 1),   -- Programming Tools
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

insert into [practices] (format, name, number_question, question_level_id, subject_dimension_id, subject_lesson_id, user_id) values
    ('multiple', 'practice1', '20', 1, 1, null, 2)

insert into [exam_attempts] (type, duration, number_correct_question, user_id, quiz_id, practice_id) values
    ('practice', 10*60 + 1234, 10, 2, null, 1)

INSERT INTO [subject_description_images]([subject_id], [url], [caption])
VALUES
    (1, 'Test1.jpg', 'This is 1st image'),
    (1, 'Test2.jpg', 'This is 2nd image'),
    (1, 'Test3.jpg', 'This is 3rd image');
