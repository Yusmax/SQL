use university

CREATE TABLE Curators (
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Name NVARCHAR(MAX) NOT NULL CHECK (NOT [Name] LIKE N''),
    Surname NVARCHAR(MAX) NOT NULL CHECK (NOT [Surname] LIKE N'')
);

CREATE TABLE Departments (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(10) NOT NULL UNIQUE CHECK (NOT [Name] LIKE N''),
    Financing MONEY DEFAULT 0 NOT NULL CHECK ([Financing] >= 0)
);

alter table Departments
add FacultyId int not null foreign key references Faculties(Id);

CREATE TABLE Faculties (
  Id int IDENTITY(1,1) PRIMARY KEY,
  Name nvarchar(100) NOT NULL UNIQUE CHECK (Name <> '')
);

CREATE TABLE Groups (
  Id int IDENTITY(1,1) PRIMARY KEY,
  Name nvarchar(10) NOT NULL UNIQUE CHECK (Name <> ''),
  Rating int NOT NULL CHECK (Rating BETWEEN 0 AND 5),
  Year int NOT NULL CHECK ([Year] BETWEEN 1 AND 5)
);

alter table Groups
add DepartmentId int not null foreign key references Departments(Id);

CREATE TABLE GroupsCurators (
    [Id] INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    [CuratorId] INT NOT NULL FOREIGN KEY REFERENCES Curators(Id),
    [GroupId] INT NOT NULL FOREIGN KEY REFERENCES Groups(Id)
);

CREATE TABLE Curators (
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Name NVARCHAR(MAX) NOT NULL CHECK (NOT [Name] LIKE N''),
    Surname NVARCHAR(MAX) NOT NULL CHECK (NOT [Surname] LIKE N'')
);

CREATE TABLE GroupsLecture (
    [Id] INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    GroupId INT NOT NULL FOREIGN KEY REFERENCES Groups(Id),
    LectureId INT NOT NULL FOREIGN KEY REFERENCES Lectures(Id)
);

CREATE TABLE Lectures (
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Date DATE NOT NULL CHECK (Date <= GETDATE()),
    SubjectId INT NOT NULL FOREIGN KEY REFERENCES Subjects(Id),
    TeacherId INT NOT NULL FOREIGN KEY REFERENCES Teachers(Id)
);

CREATE TABLE Subjects (
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Name NVARCHAR(100) NOT NULL UNIQUE CHECK (NOT [Name] LIKE N'')
);

create table Students(
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Name nvarchar(100) NOT NULL UNIQUE,
    Surname nvarchar(100) NOT NULL UNIQUE,
    Rating int not null check (Rating >= 0 and Rating <=5)

)

CREATE TABLE GroupsStudents (
  Id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
  GroupId int NOT NULL FOREIGN KEY REFERENCES dbo.Groups(Id),
  StudentId int NOT NULL FOREIGN KEY REFERENCES dbo.Students(Id)
);

