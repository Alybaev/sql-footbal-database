
USE FootbalTeams
DROP TABLE IF EXISTS RankingTeamsParametrsValues,RankingTeamsParametrs
DROP TABLE IF EXISTS TeamLeagueStatisticsParametrValues, TeamLeagueParametrs
DROP TABLE IF EXISTS TeamLeagueStatistics, TimePeriods
DROP TABLE IF EXISTS RankingTeams, Standings
DROP TABLE IF EXISTS  TeamsMatches,  Matches,  RankingSystems
DROP TABLE IF EXISTS Teams, TeamGenders, AgeCategories, TeamTypes
CREATE TABLE TimePeriods (
	ID INT NOT NULL 
		CONSTRAINT PK_TimePeriods PRIMARY KEY CLUSTERED,
)


CREATE TABLE AgeCategories (
	ID INT NOT NULL
		CONSTRAINT PK_AgeCategories PRIMARY KEY CLUSTERED,
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
	TeamGender BIT,
	AgeCategoryId INT NOT NULL
		CONSTRAINT FK_Teams_AgeCategories FOREIGN KEY REFERENCES AgeCategories(ID),
	TeamTypeId INT NOT NULL
		CONSTRAINT FK_Teams_TeamTypes FOREIGN KEY REFERENCES TeamTypes(ID),   
	Name VARCHAR(1000) NOT NULL,
	CountryId INT NOT NULL,
	EstablishmentDate DATE NOT NULL	
)
CREATE TABLE TeamLeagueStatistics (
	ID INT NOT NULL 
		CONSTRAINT PK_TeamLeagueStatistics PRIMARY KEY CLUSTERED,
	LeagueID INT NOT NULL,--DEPENDS ON th implementationn
	TeamID INT NOT NULL
		CONSTRAINT FK_TeamsLeaguesStatistics_Teams FOREIGN KEY REFERENCES Teams(ID),
	TimePeriodId INT NULL
		CONSTRAINT FK_TeamsLeaguesStatistics_TimePeriods FOREIGN KEY REFERENCES TimePeriods(ID),
	PlaceOfPlay BIT NULL,
	PossessionPercentage FLOAT NULL,
	PassPercentage FLOAT NULL,
	Wins SMALLINT NULL,
	Losses SMALLINT NULL,
	NumberOfMatches INT NULL,

	YellowCards INT NULL,
	RedCards INT NULL,
	GoalsScored SMALLINT NULL,
	GoalsScoredSixYardBox FLOAT NULL,
	GoalsScoredOutOfBox FLOAT NULL,
	GoalsScoredPenaltyArea FLOAT NULL,

	GoalsCondenced SMALLINT NULL,
	GoalsPerGame FLOAT NULL,
	PassesPerGame FLOAT NULL,
	RedCardsPerGame FLOAT NULL,
	YellowCardsPerGame FLOAT NULL,
	OffsidesPerGame FLOAT NULL,
	ShotsOnGoalPerGame FLOAT NULL,
	TacklesPerGame FLOAT NULL,
	FouldPerGame FLOAT NULL,
	DribblesPerGame FLOAT NULL,
	FouledPerGame FLOAT NULL,

	
)
CREATE TABLE TeamLeagueStatisticsParametrs
(
	ID INT NOT NULL
		CONSTRAINT PK_TeamLeagueStatisticsParametrs PRIMARY KEY CLUSTERED,
	Name VARCHAR(255) NOT NULL
)

CREATE TABLE TeamLeagueStatisticsParametrValues
(
	ID INT NOT NULL
		CONSTRAINT PK_TeamLeagueStatisticsParametrValues PRIMARY KEY CLUSTERED,
	ParametrValue FLOAT NOT NULL,
	TeamsLeaguesParametrsId INT 
		CONSTRAINT FK_TeamsLeaguesStatisticsParametrsValues_TeamsLeaguesParametrs FOREIGN KEY REFERENCES TeamLeagueStatisticsParametrs(ID),
	TeamLeagueStatisticsId INT 
		CONSTRAINT FK_TeamsLeaguesStatisticsParametrsValues_TTeamLeagueStatisticsId FOREIGN KEY REFERENCES TeamLeagueStatistics(ID)

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
	SeasonID INT NULL,
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
	ThreeYearsAgoAverage FLOAT NULL,
	ThreeYearsAgoWeighted FLOAT NULL,
	TwoYearsAgoAverage FLOAT NULL,
	TwoYearsAgoWeighted FLOAT NULL,
	LastYearAgoAverage FLOAT NULL,
	LastYearAgoWeighted FLOAT NULL,
	CurrentYearAgoAverage FLOAT NULL,
	CurrentYearAgoWeighted FLOAT NULL
)
CREATE TABLE RankingTeamsParametrs (
	ID INT NOT NULL 
		CONSTRAINT PK_RankingTeamsParametrs PRIMARY KEY CLUSTERED,
	Name VARCHAR(255) NOT NULL
)

CREATE TABLE RankingTeamsParametrsValues (
	ID INT NOT NULL
		CONSTRAINT PK_RankingTeamsParametrsValues PRIMARY KEY CLUSTERED,
	ParametrValue FLOAT,
	RankingTeamsParametrsId INT NOT NULL
		CONSTRAINT FK_RankingTeamsParametrsValues_RankingTeamsParametrs FOREIGN KEY REFERENCES RankingTeamsParametrs(ID),
	RankingTeamsId INT NOT NULL
		CONSTRAINT FK_RankingTeamsParametrsValues_RankingTeams FOREIGN KEY REFERENCES RankingTeams(ID)
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