CREATE DATABASE Hospital;
USE Hospital;



CREATE TABLE Departments
(
    [Id]        INT PRIMARY KEY IDENTITY (1, 1),
    [Name]      NVARCHAR(100)                                   NOT NULL UNIQUE CHECK ([Name] NOT LIKE N''),
    [Building]  INT CHECK ([Building] >= 1 AND [Building] <= 5) NOT NULL,
    [Financing] MONEY                                           NOT NULL CHECK ([Financing] >= 0) DEFAULT (0),
    [Floor]     INT                                             NOT NULL CHECK ([Floor] >= 1)

);

CREATE TABLE Diseases
(
    [Id]       INT PRIMARY KEY IDENTITY (1, 1),
    [Name]     NVARCHAR(100) NOT NULL UNIQUE CHECK ([Name] NOT LIKE N''),
    [Severity] INT           NOT NULL CHECK ([Severity] >= 1) DEFAULT (1)
);

CREATE TABLE Doctors
(
    [Id]      INT PRIMARY KEY IDENTITY (1, 1),
    [Name]    NVARCHAR(100) NOT NULL UNIQUE CHECK ([Name] NOT LIKE N''),
    [Surname] NVARCHAR(100) NOT NULL UNIQUE CHECK ([Surname] NOT LIKE N''),
    [Phone]   CHAR(10)      NOT NULL,
    [Premium] MONEY         NOT NULL CHECK ([Premium] >= 0) DEFAULT (0),
    [Salary]  MONEY         NOT NULL CHECK ([Salary] >= 0)  DEFAULT (300)
);

CREATE TABLE Examinations
(
    [Id]        INT PRIMARY KEY IDENTITY (1, 1),
    [Name]      NVARCHAR(100) NOT NULL UNIQUE CHECK ([Name] NOT LIKE N''),
    [DayOfWeek] INT           NOT NULL CHECK ([DayOfWeek] >= 1 AND [DayOfWeek] <= 7),
    [StartTime] TIME          NOT NULL,
    [EndTime]   TIME          NOT NULL
);
use Hospital
drop TABLE Wards

CREATE TABLE Wards
(
    [Id]       INT PRIMARY KEY IDENTITY (1, 1),
    [Name]     NVARCHAR(100) NOT NULL UNIQUE CHECK ([Name] NOT LIKE N''),
    [Building] INT           NOT NULL CHECK ([Building] >= 1 AND [Building] <= 5),
    [Floor]    INT           NOT NULL CHECK ([Floor] >= 1),
    [Places]   INT           NOT NULL CHECK([Places] >= 1),
    [DepartmentId] INT       NOT NULL FOREIGN KEY REFERENCES [Departments]
);


insert into Doctors(Name, Surname, Phone, Premium, Salary)
values
    ('Jake', 'Steele', '001' ,100, 350),
    ('Sienna', 'Lynch', '020' ,0, 300),
    ('Marshall', 'Bonilla', '050' ,200, 400),
    ('Howard', 'Small', '050' ,200, 400),
    ('Dewi', 'Hall', '040' ,200, 400),
    ('Harriet ', 'Connolly', '050' ,200, 400),
    ('Imogen ', 'Mccann', '050' ,200, 400),
    ('Molly ', 'Butler', '050' ,200, 400),
    ('Anisa ', 'Calderon', '050' ,200, 400),
    ('Will', 'Smitt', '050' ,200, 400)


insert into Departments(Name,Building ,Financing, Floor)
values
    ('Xray','1', '500', '1'),
    ('Analiz','2', '500', '1'),
    ('Labaratory','3', '500', '2')

insert into Diseases(Name, Severity)
values
    ('Legs fracture', '2'),
    ('Cancer', '1'),
    ('Heart disease', '3')

insert into Examinations(Name, DayOfWeek, StartTime, EndTime)
values
    ('Radiography', '3', '9:00', '22:00'),
    ('Diagnostics', '1', '8:00', '23:00'),
    ('MRT', '6', '14:00', '22:00')

insert into Wards(Name, Building, Floor, Places, DepartmentId)
values
    ('Emergency cardiology', '3', '1',5 , 2),
    ('Child', '1', '2', 12, 3),
    ('Gynecological', '4', '3',18, 3)

SELECT COUNT(Wards.Id)
FROM Wards
WHERE Wards.Places > 10;

use barbershop;

CREATE TABLE [Barbers] (
    [Id] INT NOT NULL PRIMARY KEY,
    [Name] NVARCHAR(100) NOT NULL CHECK (NOT [Name] LIKE N''),
    [Surname] NVARCHAR(100) NOT NULL CHECK (NOT [Surname] LIKE N''),
    [Age] DATE
);


CREATE TABLE Customers (
    [Id] INT NOT NULL PRIMARY KEY,
    [Name] NVARCHAR(100) NOT NULL CHECK (NOT [Name] LIKE N''),
    [Surname] NVARCHAR(100) NOT NULL CHECK (NOT [Surname] LIKE N''),
    [Card] INT NOT NULL UNIQUE,
    [Number] INT NOT NULL UNIQUE CHECK (NOT [Number] LIKE N''),
    [FavBarber] INT REFERENCES Barbers,
    [Age] DATE NOT NULL
);

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

use Hospital;

create table Proffesors(
    Id int not null identity(1,1) primary key ,
    DoctorId int not null foreign key references Doctors
)

create table DoctorsExaminations(
    Id int not null identity(1,1) primary key ,
    Date date not null,
    DiseaseId int not null foreign key references Diseases,
    DoctorId int not null  foreign key references Doctors,
    ExaminationId int not null foreign key references Examinations,
    WardId int not null foreign key references Wards
)

create table Interns(
    Id int not null identity(1,1) primary key ,
    DoctorId int not null foreign key references Doctors
)


