
USE FootbalTeams

DROP TABLE IF EXISTS RankingTeams, Standings
DROP TABLE IF EXISTS ParametresTeams,  TeamAttributes,Parametres,TeamsMatches,  Matches,  RankingSystems
DROP TABLE IF EXISTS  Teams, TeamGenders, GroupsAge, TeamTypes

CREATE TABLE TeamGenders (
	ID INT NOT NULL 
		CONSTRAINT PK_TeamGenders PRIMARY KEY CLUSTERED,
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


CREATE TABLE Matches (
	ID INT NOT NULL
		CONSTRAINT PK_TeamsMatches PRIMARY KEY CLUSTERED,
	VisitorTeamID INT NOT NULL
		CONSTRAINT FK_VisitorTeams_Teams FOREIGN KEY REFERENCES Teams(ID),
	HomeTeamID INT NOT NULL
		CONSTRAINT FK_HomeTeams_Teams FOREIGN KEY REFERENCES Teams(ID)
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
	Confederation VARCHAR(255) NULL,
	TotalPoint FLOAT NULL,
	PreviousSeasonRankingId INT NULL
		CONSTRAINT FK_RankingTeams_RankingTeams FOREIGN KEY REFERENCES RankingTeams(ID),
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

--Нужно связать с рангами,
--Нацильональная сборная и клуб делить их на разные энтити? Если да, то это удвоение количества таблиц
--Бавает разные системы рангов(UEFA,FIFA... туча СИСТЕМА НЕ ТАК ПРОСТА)
--Как держать историю название команды посоветуйте
--Нужно связать many-to-many с спонсорами
--Нужно связать many-to-many с Владелецами
--Нужно связать many-to-many с Тренерами
--Нужно связать many-to-many с Лигами (Статиситика команды в лигах)
--Нужно связать  many-to-many с Матчами (Статиситика команды в Матчах)
--Нужно связать many-to-many с Стадионами
--Нужно связать many-to-many с Игрокамми соства команды