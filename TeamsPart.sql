
USE FootbalTeams
DROP TABLE IF EXISTS RankingTeams, Standings, TeamsMatches
DROP TABLE IF EXISTS ParametresTeams, TeamAttributes,Parametres, TeamsLeagues,  Teams,   RankingSystems
DROP TABLE IF EXISTS Genders, GroupsAge, TeamTypes

CREATE TABLE Genders (
	ID INT NOT NULL 
		CONSTRAINT PK_Gender PRIMARY KEY CLUSTERED,
	Gender BIT
)
CREATE TABLE GroupsAge (
	ID INT NOT NULL
		CONSTRAINT PK_GroupAge PRIMARY KEY CLUSTERED,
	Name VARCHAR(255) NOT NULL
)
CREATE TABLE TeamTypes (
	ID INT NOT NULL
		CONSTRAINT PK_TeamType PRIMARY KEY CLUSTERED,
	Name VARCHAR(255) NOT NULL
)
CREATE TABLE Teams (
	ID INT NOT NULL
		CONSTRAINT PK_Teams PRIMARY KEY CLUSTERED,
	GroupAgeId INT NOT NULL
		CONSTRAINT FK_Teams_GroupsAge FOREIGN KEY REFERENCES GroupsAge(ID),
	TeamTypeId INT NOT NULL
		CONSTRAINT FK_Teams_TeamTypes FOREIGN KEY REFERENCES TeamTypes(ID),   
	TeamGenderId INT NOT NULL
		CONSTRAINT FK_Teams_Genders FOREIGN KEY REFERENCES Genders(ID),
	Name VARCHAR(1000) NOT NULL,
	CountryId INT NOT NULL, --FOREIGN
	EstablishmentDate DATE NOT NULL	
)


CREATE TABLE TeamAttributes(
	ID INT NOT NULL
		CONSTRAINT PK_TeamAttributes PRIMARY KEY CLUSTERED,
	TeamID INT NOT NULL
		CONSTRAINT FK_TeamAttributes_Teams FOREIGN KEY REFERENCES Teams(ID),
	ParametersDate DATE NULL,
)

CREATE TABLE Parametres (
	ID INT NOT NULL
		CONSTRAINT PK_Parametres PRIMARY KEY CLUSTERED,
	Name VARCHAR(255) NOT NULL,
	
)

CREATE TABLE ParametresTeams(
	ID INT NOT NULL
		CONSTRAINT PK_ParametresTeams PRIMARY KEY CLUSTERED,
	TeamAttributesID INT NOT NULL	
		CONSTRAINT FK_ParametresTeams_TeamAttributes FOREIGN KEY REFERENCES TeamAttributes(Id),
	ParametreID INT NOT NULL
		CONSTRAINT FK_ParametresTeams_Parametres FOREIGN KEY REFERENCES Parametres(Id),
	Value INT NULL
)


CREATE TABLE TeamsLeagues (
	ID INT NOT NULL
		CONSTRAINT PK_TeamsLeagues PRIMARY KEY CLUSTERED,
	TeamID INT NOT NULL
		CONSTRAINT FK_Teams_Leagues FOREIGN KEY REFERENCES Teams(ID),
	LeagueID INT NOT NULL, --FOREIGN

)

CREATE TABLE RankingSystems (
	ID INT NOT NULL
		CONSTRAINT PK_RankingSystem PRIMARY KEY CLUSTERED,
	Name VARCHAR(255) NOT NULL
)

CREATE TABLE RankingTeams (
	ID INT NOT NULL
		CONSTRAINT PK_RankingTeams PRIMARY KEY CLUSTERED,
	SeasonID INT NULL, --FOREIGN KEY
	TeamID INT NOT NULL
		CONSTRAINT FK_RankingTeams_Teams FOREIGN KEY REFERENCES Teams(ID),
	TeamRank INT NOT NULL,
	RankDate DATE NULL,
	RatingSystemId INT NULL
		CONSTRAINT FK_RankingTeams_RankingSystem FOREIGN KEY REFERENCES RankingSystems(ID),
	TotalPoint FLOAT NULL,
	PreviousPoints FLOAT NULL,
	RankChange SMALLINT NULL,
)

CREATE TABLE Standings ( 
	ID INT NOT NULL   CONSTRAINT PK_Standings PRIMARY KEY CLUSTERED, 
	LeagueId INT NOT NULL, 
	TourNumber INT NOT NULL, 
	TeamId INT NOT NULL CONSTRAINT FK_Standings_Teams FOREIGN KEY REFERENCES Teams(Id), 
	Place SMALLINT NOT NULL, 
	Points FLOAT NULL,
	Win INT NULL,
	Loss INT NULL, 
	Draw INT NULL,
	GoalsScored INT NULL, 
	GoalsMissed INT NULL,
	GoalsDiff INT NULL, 
	WinRate FLOAT NULL 
)

--����� ������� � �������,
--�������������� ������� � ���� ������ �� �� ������ ������? ���� ��, �� ��� �������� ���������� ������
--������ ������ ������� ������(UEFA,FIFA... ���� ������� �� ��� ������)
--��� ������� ������� �������� ������� �����������
--����� ������� many-to-many � ����������
--����� ������� many-to-many � �����������
--����� ������� many-to-many � ���������
--����� ������� many-to-many � ������ (����������� ������� � �����)
--����� �������  many-to-many � ������� (����������� ������� � ������)
--����� ������� many-to-many � ����������
--����� ������� many-to-many � ��������� ������ �������