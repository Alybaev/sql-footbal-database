
USE FootbalTeams
DROP TABLE IF EXISTS RankingTeamsParametrsValues,RankingTeamsParametrs
DROP TABLE IF EXISTS TeamLeagueStatisticsParametrValues, TeamLeagueStatisticsParametrs
DROP TABLE IF EXISTS TeamLeagueStatistics, TimePeriods
DROP TABLE IF EXISTS RankingTeams, Standings
DROP TABLE IF EXISTS TournamentsMatches, LeagueMatches, TeamsMatches,  Matches,  RankingSystems
DROP TABLE IF EXISTS TeamInLeagues, Loans, Deals,TeamInGroups
DROP TABLE IF EXISTS Teams, TeamGenders, AgeCategories, TeamTypes
DROP TABLE IF EXISTS MatchTypes,  TournamentGroups
DROP TABLE IF EXISTS TournamentSeasons, Tournaments
DROP TABLE IF EXISTS LeagueSeasons, Divisions
DROP TABLE IF EXISTS Leagues, FootballSystem, Seasons, Players, Countries


CREATE TABLE Countries (
    Id INT NOT NULL
        CONSTRAINT PK_Country PRIMARY KEY CLUSTERED,
    [Name] NVARCHAR(100) NOT NULL
);
 
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
	CountryId INT NOT NULL
		CONSTRAINT FK_Teams_Countries FOREIGN KEY REFERENCES Countries(ID),
	EstablishmentDate DATE NOT NULL	
)

CREATE TABLE TeamLeagueStatisticsParametrs
(
	ID INT NOT NULL
		CONSTRAINT PK_TeamLeagueStatisticsParametrs PRIMARY KEY CLUSTERED,
	Name VARCHAR(255) NOT NULL
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

CREATE TABLE Matches (
    Id INT NOT NULL
        CONSTRAINT PK_Match PRIMARY KEY CLUSTERED,
    [Date] DATETIME2(7) NOT NULL
);


CREATE TABLE Players (
	Id INT NOT NULL
		CONSTRAINT PK_Player PRIMARY KEY CLUSTERED,
	[Name] NVARCHAR(100) NOT NULL
);

--- Общее ---
CREATE TABLE Seasons (
    Id INT NOT NULL 
        CONSTRAINT PK_Season PRIMARY KEY CLUSTERED,
    Season INT NOT NULL,
    [Date] DATE NOT NULL
);

CREATE TABLE FootballSystem (
    Id INT NOT NULL
        CONSTRAINT PK_FootballSystem PRIMARY KEY CLUSTERED,
    [Name] NVARCHAR(100) NOT NULL,
    CountryId INT NOT NULL
        CONSTRAINT FK_FootballSystem_Country FOREIGN KEY REFERENCES Countries(Id)
);

CREATE TABLE Leagues (
    Id INT NOT NULL
        CONSTRAINT PK_League PRIMARY KEY CLUSTERED,
    FootballSystemId INT NOT NULL
        CONSTRAINT FK_League_FootballSystem FOREIGN KEY REFERENCES FootballSystem(Id),
    [Name] NVARCHAR(50) NOT NULL
);
CREATE TABLE TeamLeagueStatistics (
	ID INT NOT NULL 
		CONSTRAINT PK_TeamLeagueStatistics PRIMARY KEY CLUSTERED,
	LeagueID INT NOT NULL
		CONSTRAINT FK_TeamsLeaguesStatistics_Leagues FOREIGN KEY REFERENCES Leagues(ID),
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

CREATE TABLE Standings ( 
	ID INT NOT NULL   CONSTRAINT PK_Standings PRIMARY KEY CLUSTERED, 
	LeagueId INT NOT NULL
		CONSTRAINT FK_Standings_Leagues FOREIGN KEY REFERENCES Leagues(ID), 
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
CREATE TABLE Divisions (
    Id INT NOT NULL
        CONSTRAINT PK_Division PRIMARY KEY CLUSTERED,
    LeagueId INT NOT NULL
        CONSTRAINT FK_Division_League FOREIGN KEY REFERENCES Leagues(Id),
    [Name] NVARCHAR(50) NOT NULL
);


CREATE TABLE LeagueSeasons (
    Id INT NOT NULL
        CONSTRAINT PK_LeagueSeasons PRIMARY KEY CLUSTERED,
    SeasonId  INT NOT NULL
        CONSTRAINT FK_LeagueSeasons_Season FOREIGN KEY REFERENCES Seasons(Id),
    LeagueId INT NOT NULL
        CONSTRAINT FK_LeagueSeasons_League FOREIGN KEY REFERENCES Leagues(Id)
);

CREATE TABLE TeamInLeagues (
    Id INT NOT NULL
        CONSTRAINT PK_TeamInLeague PRIMARY KEY CLUSTERED,
    TeamId INT NOT NULL
        CONSTRAINT FK_TeamInLeague_Team FOREIGN KEY REFERENCES Teams(Id)
);

CREATE TABLE LeagueMatches (
    Id INT NOT NULL
        CONSTRAINT PK_LeagueMatch PRIMARY KEY CLUSTERED,
    HomeTeamId INT NOT NULL
        CONSTRAINT FK_LeagueMatch_HomeTeam FOREIGN KEY REFERENCES TeamInLeagues(Id),
    VisitorTeamId INT NOT NULL
        CONSTRAINT FK_LeagueMatch_VisitorTeam FOREIGN KEY REFERENCES TeamInLeagues(Id),
    MatchId INT NOT NULL
        CONSTRAINT FK_LeagueMatch_Match FOREIGN KEY REFERENCES Matches(Id),
);

CREATE TABLE Deals (
    Id INT NOT NULL
        CONSTRAINT PK_Deal PRIMARY KEY CLUSTERED,
    Price DECIMAL(12,2),
    PlayerId INT NOT NULL
        CONSTRAINT FK_Deal_Player FOREIGN KEY REFERENCES Players(Id),
    SeasonId INT NOT NULL
        CONSTRAINT FK_Deal_Season FOREIGN KEY REFERENCES Seasons(Id),
    NewTeamId INT NOT NULL
        CONSTRAINT FK_Deal_NewTeam FOREIGN KEY REFERENCES Teams(Id),
    OldTeamId INT NOT NULL
        CONSTRAINT FK_Deal_OldTeam FOREIGN KEY REFERENCES Teams(Id),
    [Date] DATE NOT NULL
);

CREATE TABLE Loans (
    Id INT NOT NULL
        CONSTRAINT PK_Loan PRIMARY KEY CLUSTERED, 
    DealId INT NOT NULL
        CONSTRAINT FK_Loan_Deal FOREIGN KEY REFERENCES Deals(Id),
    EndDate DATE NOT NULL
);


CREATE TABLE Tournaments (
    Id INT NOT NULL
        CONSTRAINT PK_Tournament PRIMARY KEY CLUSTERED,
    [Name] NVARCHAR(50) NOT NULL
);

CREATE TABLE TournamentSeasons (
    Id INT NOT NULL
        CONSTRAINT PK_TournamentSeasons PRIMARY KEY CLUSTERED,
    TournamentId INT NOT NULL
        CONSTRAINT FK_TournamentSeasons_Tournament FOREIGN KEY REFERENCES Tournaments(Id),
    SeasonId INT NOT NULL
        CONSTRAINT FK_TournamentSeasons_Season FOREIGN KEY REFERENCES Seasons(Id)
)

CREATE TABLE TournamentGroups (
    Id INT NOT NULL
        CONSTRAINT PK_TournamentGroups PRIMARY KEY CLUSTERED,
    TournamentBySeasonId INT NOT NULL
        CONSTRAINT FK_TournamentGroups_TournamentSeasons FOREIGN KEY REFERENCES TournamentSeasons(Id),
    GroupId CHAR(1) NOT NULL
);

CREATE TABLE TeamInGroups (
    Id INT NOT NULL
        CONSTRAINT PK_TeamInGroup PRIMARY KEY CLUSTERED,
    TournamentGroupId INT NOT NULL
        CONSTRAINT FK_TeamInGroup_TournamentGroups FOREIGN KEY REFERENCES TournamentGroups(Id),
    TeamId INT NOT NULL
        CONSTRAINT FK_TeamInGroup_Team FOREIGN KEY REFERENCES Teams(Id)
);

CREATE TABLE MatchTypes (
    Id INT NOT NULL
        CONSTRAINT PK_MatchType PRIMARY KEY CLUSTERED,
    [Name] NVARCHAR(20) NOT NULL
);

CREATE TABLE TournamentsMatches (
    Id INT NOT NULL
        CONSTRAINT PK_TournamentMatch PRIMARY KEY CLUSTERED,
    HomeTeamId INT NOT NULL
        CONSTRAINT FK_TournamentMatch_HomeTeam FOREIGN KEY REFERENCES TeamInGroups(Id),
    VisitorTeamId INT NOT NULL
        CONSTRAINT FK_TournamentMatch_VisitorTeam FOREIGN KEY REFERENCES TeamInGroups(Id),
    MatchId INT NOT NULL
        CONSTRAINT FK_TournamentMatch_Match FOREIGN KEY REFERENCES Matches(Id),
    MatchTypes INT NOT NULL
        CONSTRAINT FK_TournamentMatch_MatchType FOREIGN KEY REFERENCES MatchTypes(Id)
);