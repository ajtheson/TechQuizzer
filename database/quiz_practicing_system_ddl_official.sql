USE [master]
GO

IF EXISTS (SELECT 1 FROM [sys].[databases] WHERE [name] = 'quiz_practicing_system')
BEGIN
	DROP DATABASE [quiz_practicing_system]
END
GO

CREATE DATABASE [quiz_practicing_system]
GO

USE [quiz_practicing_system]
GO

CREATE TABLE [system_settings](
	[id] INT PRIMARY KEY IDENTITY,
	[type] VARCHAR(255) NOT NULL, --in (...) --role
	[value] VARCHAR(255) NOT NULL, --customer
	[description] VARCHAR(MAX) NOT NULL,
	[order] INT DEFAULT null,
	[status] BIT NOT NULL
)

CREATE TABLE [roles](
	[id] INT PRIMARY KEY IDENTITY,
	[name] VARCHAR(255) UNIQUE NOT NULL
)

CREATE TABLE [users](
	[id] INT PRIMARY KEY IDENTITY,
	[email] VARCHAR(255) UNIQUE NOT NULL,
	[password] VARCHAR(255),
	[name] NVARCHAR(255) NOT NULL,
	[gender] BIT,
	[mobile] CHAR(10) UNIQUE NOT NULL,
	[avatar] VARCHAR(MAX) NOT NULL DEFAULT 'default.webp', --save picture by link
	[address] VARCHAR(MAX) NOT NULL,
	[status] BIT NOT NULL DEFAULT 1,
	[balance] DECIMAL(18,2) NOT NULL DEFAULT 0,
	[activate] BIT NOT NULL DEFAULT 0,	
	[token] VARCHAR(100),
	[token_create_at] DATETIME DEFAULT GETDATE(),
	[token_send_at] DATETIME DEFAULT GETDATE(),
	[wrong_password_attempts] INT DEFAULT 0,
	[password_change_locked_until] DATETIME DEFAULT NULL,
	[temp_user] BIT NOT NULL DEFAULT 0, 
	[role_id] INT,
	FOREIGN KEY ([role_id]) REFERENCES [roles]([id]) ON DELETE SET NULL
)

CREATE TABLE [subject_categories](
	[id] INT PRIMARY KEY IDENTITY,
	[name] VARCHAR(255) NOT NULL UNIQUE
)

CREATE TABLE [subjects](
	[id] INT PRIMARY KEY IDENTITY,
	[name] VARCHAR(255) NOT NULL,
	[tag_line] VARCHAR(255) NOT NULL,
	[thumbnail] VARCHAR(255),
	[detail_description] VARCHAR(MAX) NOT NULL,
	[featured_subject] BIT NOT NULL, --!!!unknown
	[status] BIT NOT NULL, -- pulished or unpublished
	[category_id] INT,
	[owner_id] INT, --user_id
	[update_date] DATETIME DEFAULT GETDATE(), 
	FOREIGN KEY ([category_id]) REFERENCES [subject_categories]([id]) ON DELETE SET NULL,
	FOREIGN KEY ([owner_id]) REFERENCES [users]([id]) ON DELETE SET NULL
)

CREATE TABLE [subject_description_images](
	[id] INT PRIMARY KEY IDENTITY,
	[subject_id] INT,
	[url] VARCHAR(255) NOT NULL,
	[caption] VARCHAR(MAX),
	FOREIGN KEY ([subject_id]) REFERENCES [subjects]([id]) ON DELETE SET NULL
)

CREATE TABLE [dimensions](
	[id] INT PRIMARY KEY IDENTITY,
	[type] CHAR(6) NOT NULL DEFAULT 'Domain',
	[name] VARCHAR(255) NOT NULL,
	[description] VARCHAR(MAX),
	[subject_id] INT,
	[status] BIT DEFAULT 1,
	FOREIGN KEY ([subject_id]) REFERENCES [subjects]([id]) ON DELETE CASCADE
)

CREATE TABLE [price_packages](
	[id] INT PRIMARY KEY IDENTITY,
	[name] VARCHAR(255) NOT NULL,
	[duration] INT,
	[list_price] DECIMAL(18,2) NOT NULL, --list price
	[sale_price] DECIMAL(18,2) NOT NULL,
	[description] VARCHAR(MAX) NOT NULL,
	[status] BIT NOT NULL,
	[subject_id] INT,
	FOREIGN KEY ([subject_id]) REFERENCES [subjects]([id]) ON DELETE CASCADE
)

CREATE TABLE [lesson_types](
	[id] INT PRIMARY KEY IDENTITY,
	[name] VARCHAR(255) NOT NULL UNIQUE
)

CREATE TABLE [lessons](
	[id] INT PRIMARY KEY IDENTITY,
	[name] VARCHAR(255) NOT NULL,
	[topic] VARCHAR(255) NOT NULL,
	[order] INT NOT NULL,
	[video_link] VARCHAR(255),
	[content] VARCHAR(MAX),
	[status] BIT NOT NULL,
	[subject_id] INT,
	[lesson_type_id] INT,
	FOREIGN KEY ([subject_id]) REFERENCES [subjects]([id]) ON DELETE CASCADE,
	FOREIGN KEY ([lesson_type_id]) REFERENCES [lesson_types]([id]) ON DELETE SET NULL,
)

CREATE TABLE [registrations](
	[id] INT PRIMARY KEY IDENTITY,
	[time] DATETIME, --registration time
	[total_cost] DECIMAL(18,2) NOT NULL,
	[duration] INT,
	[valid_from] DATETIME,
	[valid_to] DATETIME,
	[status] VARCHAR(255) NOT NULL,
	[note] VARCHAR(255),
	[price_package_id] INT,
	[user_id] INT,
	[last_updated_by] INT
	FOREIGN KEY ([price_package_id]) REFERENCES [price_packages]([id]) ON DELETE SET NULL,
	FOREIGN KEY ([user_id]) REFERENCES [users]([id]) ON DELETE CASCADE,
	FOREIGN KEY ([last_updated_by])REFERENCES [users]([id])
)

CREATE TABLE [question_levels](
	[id] INT PRIMARY KEY IDENTITY,
	[name] VARCHAR(255) NOT NULL UNIQUE
)

CREATE TABLE [questions](
	[id] INT PRIMARY KEY IDENTITY,
	[content] VARCHAR(MAX),
	[explaination] VARCHAR(MAX),
	[question_format] VARCHAR(MAX),
	[status] BIT DEFAULT 1, -- show 1 hide 0
	[is_deleted] BIT DEFAULT 0,
	[question_level_id] INT,
	[subject_lesson_id] INT,
	[subject_dimension_id] INT, 
	FOREIGN KEY ([question_level_id]) REFERENCES [question_levels]([id]) ON DELETE SET NULL,
	FOREIGN KEY ([subject_lesson_id]) REFERENCES [lessons]([id]) ON DELETE SET NULL,
	FOREIGN KEY ([subject_dimension_id]) REFERENCES [dimensions]([id]) 
)

CREATE TABLE [question_options](
	[id] INT PRIMARY KEY IDENTITY,
	[option_content] VARCHAR(255) NOT NULL,
	[is_answer] BIT NOT NULL,
	[question_id] INT NOT NULL,
	FOREIGN KEY ([question_id]) REFERENCES [questions]([id]) ON DELETE CASCADE
)

CREATE TABLE [test_types](
	[id] INT PRIMARY KEY IDENTITY,
	[name] VARCHAR(255) NOT NULL UNIQUE
)

CREATE TABLE [quiz_settings](
	[id] INT PRIMARY KEY IDENTITY,
	[number_question] INT NOT NULL,
	[question_type] CHAR(9) NOT NULL --in (dimension, lesson)
)

CREATE TABLE [quiz_setting_groups](
	[id] INT PRIMARY KEY IDENTITY,
	[number_question] INT NOT NULL,
	[subject_lesson_id] INT,
	[subject_dimension_id] INT,
	[quiz_setting_id] INT,
	FOREIGN KEY ([quiz_setting_id]) REFERENCES [quiz_settings]([id]) ON DELETE CASCADE,
	FOREIGN KEY ([subject_lesson_id]) REFERENCES [lessons]([id]) ON DELETE SET NULL,
	FOREIGN KEY ([subject_dimension_id]) REFERENCES [dimensions]([id]) 
)

CREATE TABLE [quizzes](
	[id] INT PRIMARY KEY IDENTITY,
	[format] CHAR(8) NOT NULL, --multiple / essay
	[name] VARCHAR(255) NOT NULL,
	[duration] INT NOT NULL, --minute
	[pass_rate] INT NOT NULL, --%
	[description] VARCHAR(MAX) NOT NULL,
	[status] BIT NOT NULL DEFAULT 1,
	[test_type_id] INT,
	[subject_id] INT,
	[quiz_setting_id] INT,
	[question_level_id] INT,
	FOREIGN KEY ([test_type_id]) REFERENCES [test_types]([id]) ON DELETE SET NULL,
	FOREIGN KEY ([subject_id]) REFERENCES [subjects]([id]) ON DELETE CASCADE,
	FOREIGN KEY ([quiz_setting_id]) REFERENCES [quiz_settings]([id]) ON DELETE SET NULL,
	FOREIGN KEY ([question_level_id]) REFERENCES [question_levels]([id]),
)

CREATE TABLE [practices](
	[id] INT PRIMARY KEY IDENTITY,
	[format] CHAR(8) NOT NULL, --multiple / essay
	[name] VARCHAR(255) NOT NULL,
	[number_question] INT NOT NULL,
	[question_level_id] INT,
	[subject_lesson_id] INT,
	[subject_dimension_id] INT,
	[user_id] INT,
	FOREIGN KEY ([subject_lesson_id]) REFERENCES [lessons]([id]) ON DELETE SET NULL,
	FOREIGN KEY ([subject_dimension_id]) REFERENCES [dimensions]([id]),
	FOREIGN KEY ([question_level_id]) REFERENCES [question_levels]([id]),
	FOREIGN KEY ([user_id]) REFERENCES [users]([id]) ON DELETE CASCADE
)

CREATE TABLE [exam_attempts](
	[id] INT PRIMARY KEY IDENTITY,
	[type] CHAR(8) NOT NULL, --practice / quiz
	[start_date] DATE NOT NULL DEFAULT GETDATE(),
	[duration] INT,
	[is_taken] BIT DEFAULT 0, 
	[number_correct_question] INT,
	[user_id] INT,
	[quiz_id] INT,
	[practice_id] INT,
	FOREIGN KEY ([user_id]) REFERENCES [users]([id]) ON DELETE SET NULL, --set null to hold to calculate total attempt
	FOREIGN KEY ([quiz_id]) REFERENCES [quizzes]([id]) ON DELETE CASCADE,
	FOREIGN KEY ([practice_id]) REFERENCES [practices]([id])
)

CREATE TABLE [question_attempts](
	[id] INT PRIMARY KEY IDENTITY,
	[is_marked] BIT DEFAULT 0,
	[question_id] INT,
	[exam_attempt_id] INT,
	FOREIGN KEY ([exam_attempt_id]) REFERENCES [exam_attempts]([id]) ON DELETE CASCADE,
	FOREIGN KEY ([question_id]) REFERENCES [questions]([id])
)

CREATE TABLE [user_choices](
	[id] INT PRIMARY KEY IDENTITY,
	[question_option_id] INT,
	[question_attempt_id] INT,
	FOREIGN KEY ([question_option_id]) REFERENCES [question_options]([id]),
	FOREIGN KEY ([question_attempt_id]) REFERENCES [question_attempts]([id]) ON DELETE CASCADE,
)

CREATE TABLE [essay_attempts](
	[id] INT PRIMARY KEY IDENTITY,
	[is_marked] BIT DEFAULT 0,
	[question_id] INT,
	[exam_attempt_id] INT,
	FOREIGN KEY ([exam_attempt_id]) REFERENCES [exam_attempts]([id]) ON DELETE CASCADE,
	FOREIGN KEY ([question_id]) REFERENCES [questions]([id])
)

CREATE TABLE [essay_submissions](
	[id] INT PRIMARY KEY IDENTITY,
	[fileName] NVARCHAR(MAX),
	[essay_attempt_id] INT,
	FOREIGN KEY ([essay_attempt_id]) REFERENCES [essay_attempts]([id]) ON DELETE CASCADE
)

CREATE TABLE [question_medias](
	[id] INT PRIMARY KEY IDENTITY,
	[type] VARCHAR(MAX), --video, audio, image
	[link] VARCHAR(MAX),
	[description] VARCHAR(MAX),
	[question_id] INT,
	FOREIGN KEY ([question_id]) REFERENCES [questions]([id]) 
)

GO
CREATE TRIGGER tr_ai_system_setting
ON [system_settings]
AFTER INSERT
AS
BEGIN
	--role
	IF EXISTS (SELECT 1 FROM inserted WHERE [type] = 'User Roles')
	BEGIN
		INSERT INTO [roles]([name])
		SELECT [value] FROM inserted WHERE [type] = 'User Roles' ORDER BY id ASC
	END

	--subject category
	IF EXISTS (SELECT 1 FROM inserted WHERE [type] = 'Subject Categories')
	BEGIN
		INSERT INTO [subject_categories]([name])
		SELECT [value] FROM inserted WHERE [type] = 'Subject Categories' ORDER BY id ASC
	END

	--test type
	IF EXISTS (SELECT 1 FROM inserted WHERE [type] = 'Test Types')
	BEGIN
		INSERT INTO [test_types]([name])
		SELECT [value] FROM inserted WHERE [type] = 'Test Types' ORDER BY id ASC
	END

	--question level
	IF EXISTS (SELECT 1 FROM inserted WHERE [type] = 'Question Levels')
	BEGIN
		INSERT INTO [question_levels]([name])
		SELECT [value] FROM inserted WHERE [type] = 'Question Levels' ORDER BY id ASC
	END

	--lesson type
	IF EXISTS (SELECT 1 FROM inserted WHERE [type] = 'Lesson Types')
	BEGIN
		INSERT INTO [lesson_types]([name])
		SELECT [value] FROM inserted WHERE [type] = 'Lesson Types' ORDER BY id ASC
	END
	
END
GO
ALTER TABLE [lessons]
ADD [lesson_quiz_id] INT;
ALTER TABLE [lessons]
ADD CONSTRAINT FK_lessons_quiz_id 
FOREIGN KEY ([lesson_quiz_id]) REFERENCES [quizzes]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
