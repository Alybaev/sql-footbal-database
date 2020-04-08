USE master
DECLARE @DatabaseName nvarchar(50)
SET @DatabaseName = N'FootbalTeams'

DECLARE @SQL varchar(max)

SELECT @SQL = COALESCE(@SQL,'') + 'Kill ' + Convert(varchar, SPId) + ';'
FROM MASTER..SysProcesses
WHERE DBId = DB_ID(@DatabaseName) AND SPId <> @@SPId


EXEC(@SQL)
GO
DROP DATABASE IF EXISTS  FootbalTeams
GO
CREATE DATABASE FootbalTeams
GO
USE FootbalTeams

CREATE TABLE EventNames (
    ID INT PRIMARY KEY IDENTITY (1, 1),
    Name VARCHAR (50) NOT NULL
);
GO

CREATE TABLE Nationality
(
    id INT NOT NULL IDENTITY PRIMARY KEY,
    name VARCHAR(50)
)
GO

CREATE TABLE Countries (
    Id INT NOT NULL
        CONSTRAINT PK_Country PRIMARY KEY CLUSTERED,
    [Name] NVARCHAR(100) NOT NULL
);
GO

CREATE TABLE Cities (
    ID INT PRIMARY KEY IDENTITY (1, 1),
    Name VARCHAR (50) NOT NULL,
    CountryID INT NOT NULL
		CONSTRAINT FK_Cities_Countries FOREIGN KEY REFERENCES Countries(ID)
);
GO

CREATE TABLE Religion
(
    id INT NOT NULL IDENTITY PRIMARY KEY,
    name VARCHAR(50)
)

CREATE TABLE Players (
    ID INT PRIMARY KEY IDENTITY (1, 1),
    FirstName NVARCHAR (50) NOT NULL,
    LastName NVARCHAR (50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender BIT,
	  NationalityId INT NOT NULL
      FOREIGN KEY (nationalityId) REFERENCES Nationality(Id),
    MaritalStatus BIT,
    HomeCity INT NOT NULL
      FOREIGN KEY (homeCity) REFERENCES Cities(Id),
	ReligionID INT NOT NULL
	   FOREIGN KEY (ReligionID) REFERENCES Religion(Id),
);
 GO

 CREATE TABLE EducationType
 (
     id INT NOT NULL IDENTITY PRIMARY KEY,
     name VARCHAR(50)
 )
 GO
CREATE TABLE Education
 (
     id INT NOT NULL IDENTITY PRIMARY KEY,
     name VARCHAR(100),
     typeId INT NOT NULL,
     startDate DATE NOT NULL,
     endDate DATE NOT NULL,
     playerId INT NOT NULL,
     FOREIGN KEY (playerId) REFERENCES Players(Id),
 	   FOREIGN KEY (typeId) REFERENCES EducationType(Id)
 )
GO

CREATE TABLE MentalStatus
(
    id INT NOT NULL IDENTITY PRIMARY KEY,
    playerId INT NOT NULL,
    measureDate DATE NOT NULL,
    aggression INT NOT NULL,
    anticipation INT NOT NULL,
    bravery INT NOT NULL,
    composure INT NOT NULL,
    concentration INT NOT NULL,
    decision INT NOT NULL,
    determination INT NOT NULL,
    flair INT NOT NULL,
    leadership INT NOT NULL,
    offTheBall INT NOT NULL,
    positioning INT NOT NULL,
    teamwork INT NOT NULL,
    vision INT NOT NULL,
    workRate INT NOT NULL,
    FOREIGN KEY (playerId) REFERENCES Players(Id)
)


CREATE TABLE PhysicalStatus
(
    id INT NOT NULL IDENTITY PRIMARY KEY,
    playerId INT NOT NULL,
    measureDate DATE NOT NULL,
    bmi FLOAT NOT NULL,
    height FLOAT NOT NULL,
    weight DECIMAL NOT NULL,
    acceleration INT NOT NULL,
    agility INT NOT NULL,
    balance INT NOT NULL,
    jumpingReach INT NOT NULL,
    naturalFitness INT NOT NULL,
    pace INT NOT NULL,
    stamine INT NOT NULL,
    strength INT NOT NULL,
    FOREIGN KEY (playerId) REFERENCES Players(Id)
)

CREATE TABLE TechnicalStatus
(
    id INT NOT NULL IDENTITY PRIMARY KEY,
    playerId INT NOT NULL,
    measureDate DATE NOT NULL,
    corner INT NOT NULL,
    crossing INT NOT NULL,
    dribbling INT NOT NULL,
    finishing INT NOT NULL,
    firstTouch INT NOT NULL,
    freeKickTaking INT NOT NULL,
    heading INT NOT NULL,
    longShots INT NOT NULL,
    longThrows INT NOT NULL,
    marking INT NOT NULL,
    passing INT NOT NULL,
    penaltyTaking INT NOT NULL,
    tacking INT NOT NULL,
    technique INT NOT NULL,
    FOREIGN KEY (playerId) REFERENCES Players(Id)
)

CREATE TABLE Positions (
    ID INT PRIMARY KEY IDENTITY (1, 1),
    Name VARCHAR (50) NOT NULL
);
GO


CREATE TABLE StatisticIndicators (
    ID INT PRIMARY KEY IDENTITY (1, 1),
    Name VARCHAR (50) NOT NULL
);
GO

CREATE TABLE IndicatorAttributes (
    ID INT PRIMARY KEY IDENTITY (1, 1),
    Name VARCHAR (50) NOT NULL
);
GO


CREATE TABLE SoccerEvents (
    ID INT PRIMARY KEY IDENTITY (1, 1),
    EventNameID INT NOT NULL
		CONSTRAINT FK_SoccerEvents_EventNames FOREIGN KEY REFERENCES EventNames(ID),
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    CountryID INT NOT NULL
		CONSTRAINT FK_SoccerEvents_Countries FOREIGN KEY REFERENCES Countries(ID)
);
GO

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
	CityID INT NULL
		CONSTRAINT FK_Teams_Cities FOREIGN KEY REFERENCES Cities(ID),
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
CREATE TABLE ClubPresidents (
    ID INT PRIMARY KEY IDENTITY (1, 1),
    Name VARCHAR (50) NOT NULL,
    ClubID INT NOT NULL
		CONSTRAINT FK_ClubPresidents_Clubs FOREIGN KEY REFERENCES Teams(ID),
    DateFrom DATE NOT NULL,
    DateTo DATE NULL
);
GO

CREATE TABLE ClubCoaches (
    ID INT PRIMARY KEY IDENTITY (1, 1),
    Name VARCHAR (50) NOT NULL,
    ClubID INT NOT NULL
		CONSTRAINT FK_ClubCoaches_Clubs FOREIGN KEY REFERENCES Teams(ID),
    DateFrom DATE NOT NULL,
    DateTo DATE NULL
);
GO
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
GO
CREATE TABLE TeamTactics
(
	ID INT NOT NULL IDENTITY(1,1)
		CONSTRAINT PK_TeamTactics PRIMARY KEY CLUSTERED,
	TeamID INT NOT NULL, --FK -> 'Team' table
	Name NVARCHAR(50),
	Description NVARCHAR(100),
	PositionImgURL NVARCHAR(MAX)
)
GO
CREATE TABLE TeamComposition
(
	ID INT NOT NULL IDENTITY(1,1)
		CONSTRAINT PK_TeamComposition PRIMARY KEY CLUSTERED,
	TacticID INT
		CONSTRAINT FK_TeamComposition_TeamTactics FOREIGN KEY REFERENCES TeamTactics(ID),
	MatchID INT,

	TeamID INT
		CONSTRAINT FK_TeamComposition_Teams FOREIGN KEY REFERENCES Teams(ID)		--Teams table to be merged
	--CoachID INT
	--	CONSTRAINT FK_TeamComposition_Coaches FOREIGN KEY REFERENCES Coaches(ID)	Coaches table  to be merged
)
GO
CREATE TABLE MatchStatuses
(
	ID INT NOT NULL IDENTITY (1,1)
		CONSTRAINT PK_MatchStatuses PRIMARY KEY CLUSTERED,
	Name NVARCHAR(50)
)
GO
CREATE TABLE Matches
(
	ID INT NOT NULL IDENTITY(1,1)
		CONSTRAINT PK_Matches PRIMARY KEY CLUSTERED,
	StadiumID INT NOT NULL,
	HomeTeamCompositionId INT NOT NULL
		CONSTRAINT FK_Matches_TeamComposition_Home FOREIGN KEY REFERENCES TeamComposition(ID),
	GuestTeamCompositionId INT NOT NULL
		CONSTRAINT FK_Matches_TeamComposition_Guest FOREIGN KEY REFERENCES TeamComposition(ID),
	Date DATETIME,
	TourID INT,
	ExtraTimes BIT NOT NULL,
	PenaltyRound BIT NOT NULL,
	MatchStatusID INT NOT NULL
		CONSTRAINT FK_Matches_MatchStatuses FOREIGN KEY REFERENCES MatchStatuses(ID)
)
	ALTER TABLE TeamComposition ADD CONSTRAINT FK_TeamComposition_Matches FOREIGN KEY (MatchID) REFERENCES Matches(ID);
GO

CREATE TABLE MatchTeams (
    MatchID INT PRIMARY KEY
		CONSTRAINT FK_MatchTeams_Matches FOREIGN KEY REFERENCES Matches(ID),
    ClubID INT NOT NULL
		CONSTRAINT FK_MatchTeams_Clubs FOREIGN KEY REFERENCES Teams(ID),
    PlayerID INT NOT NULL
		CONSTRAINT FK_MatchTeams_Players FOREIGN KEY REFERENCES Players(ID),
    PositionID INT NOT NULL
		CONSTRAINT FK_MatchTeams_Positions FOREIGN KEY REFERENCES Positions(ID),
);
 GO
--- ����� ---
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

GO
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
GO
CREATE TABLE PlayerStatistics (
    ID INT PRIMARY KEY IDENTITY (1, 1),
    PlayerID INT NOT NULL
		CONSTRAINT FK_PlayerStatistics_Players FOREIGN KEY REFERENCES Players(ID),
    MatchID INT NOT NULL
		CONSTRAINT FK_PlayerStatistics_Matches FOREIGN KEY REFERENCES Matches(ID),
    StatisticIndicatorID INT NOT NULL
		CONSTRAINT FK_PlayerStatistics_StatisticIndicators FOREIGN KEY REFERENCES StatisticIndicators(ID),
    IsHome BIT NOT NULL
);
GO
CREATE TABLE StatisticAttributes (
    PlayerStatisticID INT NOT NULL
		CONSTRAINT FK_StatisticAttributes_PlayerStatistics FOREIGN KEY REFERENCES PlayerStatistics(ID),
    IndicatorAttributeID INT NOT NULL
		CONSTRAINT FK_StatisticAttributes_IndicatorAttributes FOREIGN KEY REFERENCES IndicatorAttributes(ID),
    Value FLOAT NOT NULL
);

GO
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


CREATE TABLE Coaches (
  [ID] INTEGER NOT NULL IDENTITY,
  [Name] VARCHAR(200) NULL DEFAULT NULL,
  [Sex] INTEGER NULL DEFAULT NULL,
  [CurrentTeamId] INTEGER NULL DEFAULT NULL,
  [CountryId] INTEGER NULL DEFAULT NULL,
  [DateOfBirth] DATE NULL DEFAULT NULL,
  [BirthCountryId] INTEGER NULL DEFAULT NULL,
  [PlayerId] INTEGER NULL DEFAULT NULL,
  PRIMARY KEY ([ID])
);


CREATE TABLE CoachTrophies (
  [ID] INTEGER NOT NULL IDENTITY,
  [Name] VARCHAR(200) NULL DEFAULT NULL,
  [CoachId] INTEGER NULL DEFAULT NULL,
  [LeagueId] INTEGER NULL DEFAULT NULL,
  [Date] DATE NULL DEFAULT NULL,
  [TeamId] INTEGER NULL DEFAULT NULL,
  PRIMARY KEY ([ID])
);


CREATE TABLE Contracts (
  [ID] INTEGER NOT NULL IDENTITY,
  [TeamId] INTEGER NULL DEFAULT NULL,
  [StartDate] DATETIME2(0) NULL DEFAULT NULL,
  [EndDate] INTEGER NULL DEFAULT NULL,
  [CoachId] INTEGER NULL DEFAULT NULL,
  PRIMARY KEY ([ID])
);


CREATE TABLE CoachStatistics (
  [ID] INTEGER NOT NULL IDENTITY,
  [CoachId] INTEGER NULL DEFAULT NULL,
  [GamesCountTotal] INTEGER NULL DEFAULT NULL,
  [WinCountTotal] INTEGER NULL DEFAULT NULL,
  [LoseCountTotal] INTEGER NULL DEFAULT NULL,
  [CurrentTeamId] INTEGER NULL DEFAULT NULL,
  [DrawCountTotal] INTEGER NULL DEFAULT NULL,
  [TotalPoint] INTEGER NULL DEFAULT NULL,
  PRIMARY KEY ([ID])
);

CREATE TABLE Stadiums (
  [ID] INTEGER NOT NULL IDENTITY,
  [OpeningDate] DATE NULL DEFAULT NULL,
  [Capacity] INTEGER NULL DEFAULT NULL,
  [CityID] INTEGER NULL DEFAULT NULL,
  PRIMARY KEY ([ID])
);


CREATE TABLE HomeTeams (
  [ID] INTEGER NOT NULL IDENTITY,
  [StadiumsID] INTEGER NULL DEFAULT NULL,
  [StartDate] DATE NULL DEFAULT NULL,
  [EndDate] DATE NULL DEFAULT NULL,
  PRIMARY KEY ([ID])
);


CREATE TABLE StadiumAttributes (
  [ID] INTEGER NOT NULL IDENTITY,
  [TypeID] INTEGER NULL DEFAULT NULL,
  [Value] VARCHAR(max) NOT NULL DEFAULT 'NULL',
  [StartDate] DATETIME2(0) NULL DEFAULT NULL,
  [EndDate] DATETIME2(0) NULL DEFAULT NULL,
  [StadiumID] INTEGER NULL DEFAULT NULL,
  PRIMARY KEY ([ID])
);


CREATE TABLE StadiumAttributeTypes (
  [ID] INTEGER NOT NULL IDENTITY,
  [Name] VARCHAR(200) NULL DEFAULT NULL,
  [Description] VARCHAR(5000) NULL DEFAULT NULL,
  PRIMARY KEY ([ID])
);


CREATE TABLE Cards (
  [ID] INTEGER NOT NULL IDENTITY,
  [RefereeStatID] INTEGER NULL DEFAULT NULL,
  [PlayerID] INTEGER NULL DEFAULT NULL,
  [CardType] INTEGER NULL DEFAULT NULL,
  [Time] INTEGER NULL DEFAULT NULL,
  PRIMARY KEY ([ID])
);


CREATE TABLE Referees (
  [ID] INTEGER NOT NULL IDENTITY,
  [Name] VARCHAR(200) NOT NULL,
  [BirthCountryId] INTEGER NULL DEFAULT NULL,
  [BirthDate] DATE NULL DEFAULT NULL,
  [CareerDateFrom] DATETIME2(0) NULL DEFAULT NULL,
  [CareerDateTo] DATE NULL DEFAULT NULL,
  [Sex] binary NULL DEFAULT NULL,
  PRIMARY KEY ([ID])
);

CREATE TABLE RefereeStatOfMatch (
  [ID] INTEGER NOT NULL IDENTITY,
  [MatchId] INTEGER NULL DEFAULT NULL,
  [RefereeId] INTEGER NULL DEFAULT NULL,
  [FixedFouls] INTEGER NULL DEFAULT NULL,
  PRIMARY KEY ([ID])
);

ALTER TABLE [Coaches] ADD FOREIGN KEY (CountryId) REFERENCES Countries ([ID]);
ALTER TABLE [Coaches] ADD FOREIGN KEY (BirthCountryId) REFERENCES Countries ([ID]);
ALTER TABLE [CoachTrophies] ADD FOREIGN KEY (CoachId) REFERENCES Coaches ([ID]);
ALTER TABLE [Contracts] ADD FOREIGN KEY (CoachId) REFERENCES Coaches ([ID]);
ALTER TABLE [CoachStatistics] ADD FOREIGN KEY (CoachId) REFERENCES Coaches ([ID]);
ALTER TABLE [Cities] ADD FOREIGN KEY (CountryID) REFERENCES Countries ([ID]);
ALTER TABLE [Stadiums] ADD FOREIGN KEY (CityID) REFERENCES Cities ([ID]);
ALTER TABLE [HomeTeams] ADD FOREIGN KEY (StadiumsID) REFERENCES Stadiums ([ID]);
ALTER TABLE [StadiumAttributes] ADD FOREIGN KEY (TypeID) REFERENCES StadiumAttributeTypes ([ID]);
ALTER TABLE [StadiumAttributes] ADD FOREIGN KEY (StadiumID) REFERENCES Stadiums ([ID]);
ALTER TABLE [Cards] ADD FOREIGN KEY (RefereeStatID) REFERENCES RefereeStatOfMatch ([ID]);
ALTER TABLE [Referees] ADD FOREIGN KEY (BirthCountryId) REFERENCES Countries ([ID]);
ALTER TABLE [RefereeStatOfMatch] ADD FOREIGN KEY (RefereeId) REFERENCES Referees ([ID]);
ALTER TABLE [RefereeStatOfMatch] ADD FOREIGN KEY (MatchId) REFERENCES Matches([ID]);
ALTER TABLE [Cards] ADD FOREIGN KEY (PlayerID) REFERENCES Players ([ID]);
ALTER TABLE [Coaches] ADD FOREIGN KEY (CurrentTeamId) REFERENCES Teams ([ID]);
ALTER TABLE [CoachStatistics] ADD FOREIGN KEY (CurrentTeamId) REFERENCES Teams ([ID]);
ALTER TABLE [Coaches] ADD FOREIGN KEY (CurrentTeamId) REFERENCES Teams ([ID]);
ALTER TABLE [CoachTrophies] ADD FOREIGN KEY (TeamId) REFERENCES Teams ([ID]);
ALTER TABLE [CoachTrophies] ADD FOREIGN KEY (LeagueId) REFERENCES Leagues ([ID]);
ALTER TABLE [Contracts] ADD FOREIGN KEY (TeamId) REFERENCES Teams ([ID]);

CREATE TABLE MatchItemTypes
(
	ID INT NOT NULL IDENTITY(1,1)
		CONSTRAINT PK_MatchItemTypes PRIMARY KEY CLUSTERED,
	Name VARCHAR(250)
)



CREATE TABLE ActionTypes
(
	ID INT NOT NULL IDENTITY(1,1)
		CONSTRAINT PK_ActionTypes PRIMARY KEY CLUSTERED,
	Name NVARCHAR(100)
)

CREATE TABLE ActionItemsType
(
	ID INT NOT NULL IDENTITY(1,1)
		CONSTRAINT PK_ActionItemsType PRIMARY KEY CLUSTERED,
	Name NVARCHAR(50)
)

CREATE TABLE MatchEventTypes
(
	ID INT NOT NULL IDENTITY(1,1)
		CONSTRAINT PK_EventTypes  PRIMARY KEY CLUSTERED,
	Name NVARCHAR(50),
	isViolation BIT NOT NULL
)


CREATE TABLE MatchItemsAttributesType
(
	ID INT NOT NULL IDENTITY(1,1)
		CONSTRAINT PK_MatchItemsAttributesType PRIMARY KEY CLUSTERED,
	Name VARCHAR(100)
)

CREATE TABLE RefereeType
(
	ID INT NOT NULL IDENTITY(1,1)
		CONSTRAINT PK_RefereeType PRIMARY KEY CLUSTERED,
	Name NVARCHAR(250)
)


CREATE TABLE RefereeInMatch
(
	ID INT NOT NULL IDENTITY(1,1)
		CONSTRAINT PK_RefereeInMatch PRIMARY KEY CLUSTERED,
	RefereeID INT
			CONSTRAINT FK_RefereeInMatch_Referee FOREIGN KEY REFERENCES Referees(ID),
	MatchID INT
		CONSTRAINT FK_RefereeInMatch_Matches FOREIGN KEY REFERENCES Matches(ID),
	RefereeTypeID INT
		CONSTRAINT FK_RefereeInMatch_RefereeType FOREIGN KEY REFERENCES RefereeType(ID)
)

CREATE TABLE PlayersInMatch
(
	ID INT NOT NULL IDENTITY(1,1)
		CONSTRAINT PK_PlayersInMatch PRIMARY KEY CLUSTERED,
	PlayerID INT
			CONSTRAINT FK_PlayersInMatch_Players FOREIGN KEY REFERENCES Players(ID),
	PositionID INT
			CONSTRAINT FK_PlayersInMatch_Positions FOREIGN KEY REFERENCES Positions(ID),
	IsSubstitute BIT,
	TimeParticipated TIME NOT NULL,
	TeamCompositionID INT
		CONSTRAINT FK_PlayersInMatch_TeamComposition FOREIGN KEY REFERENCES TeamComposition(ID),
	MatchID INT
		CONSTRAINT FK_PlayersInMatch_Matches FOREIGN KEY REFERENCES Matches(ID)
)

CREATE TABLE MatchTimes
(
	ID INT NOT NULL IDENTITY(1,1),
	MatchID INT
		CONSTRAINT FK_MatchTimes_Matches FOREIGN KEY REFERENCES Matches(ID),
	Duration TIME NOT NULL,
		CONSTRAINT PK_TimeID_MatchID PRIMARY KEY CLUSTERED (ID, MatchID)
)

CREATE TABLE MatchItems
(
	ID INT NOT NULL IDENTITY(1,1)
		CONSTRAINT PK_MatchItems PRIMARY KEY CLUSTERED,
	TypeID INT NOT NULL
		CONSTRAINT FK_MatchItems_MatchItemTypes FOREIGN KEY REFERENCES MatchItemTypes(ID),
	Value INT,
	TeamCompositionID INT NOT NULL
		CONSTRAINT FK_MatchItems_TeamComposition FOREIGN KEY REFERENCES TeamComposition(ID),
	MatchTimeID INT NOT NULL,
	MatchID INT NOT NULL
		CONSTRAINT FK_MatchItems_Matches FOREIGN KEY REFERENCES Matches(ID),
		CONSTRAINT FK_MatchItems_MatchTime FOREIGN KEY (MatchTimeID, MatchID) REFERENCES MatchTimes (ID, MatchID)
)

CREATE TABLE MatchItemsAttributes
(
	MatchItemId INT NOT NULL
		CONSTRAINT FK_MatchItemsAttributes_MatchItems FOREIGN KEY REFERENCES MatchItems(ID),
	MatchItemsAttributesTypeID INT NOT NULL
		CONSTRAINT FK_MathcItemsAtributes_MatchItemsAttributesType FOREIGN KEY REFERENCES MatchItemsAttributesType(ID),
	Value NVARCHAR(MAX),
	CONSTRAINT PK_MatchItemId_MatchItemsAttributesTypeID PRIMARY KEY CLUSTERED (MatchItemId, MatchItemsAttributesTypeID)

)

CREATE TABLE MatchEvents
(
	ID INT NOT NULL IDENTITY(1,1)
		CONSTRAINT PK_MatchEvents PRIMARY KEY CLUSTERED,
	MatchEventTypeID INT
		CONSTRAINT FK_MatchEvents_MatchEventType FOREIGN KEY REFERENCES MatchEventTypes(ID),
	Time TIME,
	MatchTimeID INT,
	Description NVARCHAR(250),
	MatchID INT
		CONSTRAINT FK_MatchEvents_Matches FOREIGN KEY REFERENCES Matches(ID)
)

CREATE TABLE PersonMatchEvents
(
	ID INT NOT NULL
		CONSTRAINT PK_PersonMatchEvents PRIMARY KEY CLUSTERED,
	PlayersInMatchID INT
		CONSTRAINT FK_PersonMatchEvents_PlayersInMatch FOREIGN KEY REFERENCES PlayersInMatch(ID),
	MatchEventID INT
		CONSTRAINT FK_PersonMatchEvents_MatchEvents	FOREIGN KEY REFERENCES MatchEvents(ID),
	Time DATETIME,
	ActionTypeID INT
		CONSTRAINT FK_PersonMatchEvents_ActionType FOREIGN KEY REFERENCES ActionTypes(ID),
	CoachID INT
			CONSTRAINT FK_PersonMatchEvents_Coaches FOREIGN KEY REFERENCES Coaches(ID),-- Merge part
	RefereeInMatchID INT
		CONSTRAINT FK_PersonMatchEvents_RefereeInMatch FOREIGN KEY REFERENCES RefereeInMatch(ID),
		CONSTRAINT CHK_PlayersInMatchID_RefereeInMatchID_CoachID CHECK ((PlayersInMatchID IS NOT NULL AND RefereeInMatchID IS NULL AND CoachID IS NULL) OR
			   (PlayersInMatchID IS NULL AND RefereeInMatchID IS NOT NULL AND CoachID IS NULL) OR
			   (PlayersInMatchID IS NOT NULL AND RefereeInMatchID IS NULL AND CoachID IS NOT NULL))
)

CREATE TABLE ActionItems
(
	PersonMatchEventsId INT NOT NULL
		CONSTRAINT FK_ActionItems_PersonMatchEvents FOREIGN KEY REFERENCES PersonMatchEvents(ID),
	ActionItemsTypeId INT NOT NULL
		CONSTRAINT FK_ActionItems_ActionItemsType FOREIGN KEY REFERENCES ActionItemsType(ID),
		Value NVARCHAR(MAX),
		CONSTRAINT PK_ActionItems PRIMARY KEY CLUSTERED (PersonMatchEventsID, ActionItemsTypeId)
)
