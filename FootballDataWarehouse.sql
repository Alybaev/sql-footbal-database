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
    ID INT NOT NULL IDENTITY (1, 1)
		CONSTRAINT PK_EventNames PRIMARY KEY CLUSTERED,
    Name NVARCHAR (50) NOT NULL
);
GO

CREATE TABLE Nationalities
(
    ID INT IDENTITY (1, 1)
		CONSTRAINT PK_Nationalities PRIMARY KEY CLUSTERED ,
    Name NVARCHAR(50) NOT NULL
)
GO

CREATE TABLE Countries (
    ID INT IDENTITY (1, 1)
        CONSTRAINT PK_Countries PRIMARY KEY CLUSTERED,
    Name NVARCHAR(100) NOT NULL
);
GO

CREATE TABLE Cities (
    ID INT IDENTITY (1, 1)
        CONSTRAINT PK_Cities PRIMARY KEY CLUSTERED,
    Name NVARCHAR (50) NOT NULL,
    CountryID INT
		CONSTRAINT FK_Cities_Countries FOREIGN KEY REFERENCES Countries(ID)
);

GO

CREATE TABLE Religions
(
    ID INT IDENTITY (1, 1)
        CONSTRAINT PK_Religions PRIMARY KEY CLUSTERED,
    Name VARCHAR(50)
)

CREATE TABLE Players (
    ID INT IDENTITY (1, 1)
        CONSTRAINT PK_Players PRIMARY KEY CLUSTERED,
    FirstName NVARCHAR (50) NOT NULL,
    LastName NVARCHAR (50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender BIT NOT NULL,
	NationalityId INT
      CONSTRAINT FK_Players_Nationalities FOREIGN KEY REFERENCES Nationalities(ID),
    MaritalStatus BIT,
    HomeCityID INT
      CONSTRAINT FK_Players_Cities FOREIGN KEY REFERENCES Cities(ID),
	ReligionID INT
	  CONSTRAINT FK_Players_Religions FOREIGN KEY REFERENCES Religions(ID),
);
 GO

 CREATE TABLE EducationTypes
 (
     ID INT IDENTITY (1, 1) 
		CONSTRAINT PK_EducationTypes PRIMARY KEY CLUSTERED,
     Name VARCHAR(50)
 );

 GO
CREATE TABLE Education
 (
     ID INT IDENTITY (1, 1) 
		CONSTRAINT PK_Education PRIMARY KEY CLUSTERED,
     Name VARCHAR(100) NOT NULL,
     TypeId INT NOT NULL
		CONSTRAINT FK_Education_EducationType FOREIGN KEY REFERENCES EducationTypes(Id),
     StartDate DATE NOT NULL,
     EndDate DATE NOT NULL,
     PlayerId INT NOT NULL
		CONSTRAINT FK_Education_Players FOREIGN KEY REFERENCES Players(Id)	   
 );
GO

CREATE TABLE MentalStatuses
(
    ID INT IDENTITY (1, 1) 
		CONSTRAINT PK_MentalStatuses PRIMARY KEY CLUSTERED,
    PlayerId INT NOT NULL
		CONSTRAINT FK_MentalStatuses_Players FOREIGN KEY REFERENCES Players(Id),
    MeasureDate DATE NOT NULL,
    Aggression INT NOT NULL,
    Anticipation INT NOT NULL,
    Bravery INT NOT NULL,
    Composure INT NOT NULL,
    Concentration INT NOT NULL,
    Decision INT NOT NULL,
    Determination INT NOT NULL,
    Flair INT NOT NULL,
    Leadership INT NOT NULL,
    OffTheBall INT NOT NULL,
    Positioning INT NOT NULL,
    Teamwork INT NOT NULL,
    Vision INT NOT NULL,
    WorkRate INT NOT NULL,
);
GO

CREATE TABLE PhysicalStatuses
(
    ID INT IDENTITY (1, 1) 
		CONSTRAINT PK_PhysicalStatuses PRIMARY KEY CLUSTERED,
    PlayerId INT NOT NULL
		CONSTRAINT FK_PhysicalStatuses_Players FOREIGN KEY REFERENCES Players(Id),
    MeasureDate DATE NOT NULL,
    BMI FLOAT NOT NULL, --Body Mass Index
    Height FLOAT NOT NULL,
    Weight DECIMAL NOT NULL,
    Acceleration INT NOT NULL,
    Agility INT NOT NULL,
    Balance INT NOT NULL,
    JumpingReach INT NOT NULL,
    NaturalFitness INT NOT NULL,
    Pace INT NOT NULL,
    Stamine INT NOT NULL,
    Strength INT NOT NULL,
);
GO

CREATE TABLE TechnicalStatuses
(
    ID INT IDENTITY (1, 1) 
		CONSTRAINT PK_TechnicalStatuses PRIMARY KEY CLUSTERED,
    PlayerId INT NOT NULL
		CONSTRAINT FK_TechnicalStatusess_Players FOREIGN KEY REFERENCES Players(Id),
    MeasureDate DATE NOT NULL,
    Corner INT NOT NULL,
    Crossing INT NOT NULL,
    Dribbling INT NOT NULL,
    Finishing INT NOT NULL,
    FirstTouch INT NOT NULL,
    FreeKickTaking INT NOT NULL,
    Heading INT NOT NULL,
    LongShots INT NOT NULL,
    LongThrows INT NOT NULL,
    Marking INT NOT NULL,
    Passing INT NOT NULL,
    PenaltyTaking INT NOT NULL,
    Tacking INT NOT NULL,
    Technique INT NOT NULL,
)

CREATE TABLE Positions (
    ID INT IDENTITY (1, 1) 
		CONSTRAINT PK_Positions PRIMARY KEY CLUSTERED,
    Name NVARCHAR (50) NOT NULL
);
GO


CREATE TABLE StatisticIndicators (
    ID INT IDENTITY (1, 1) 
		CONSTRAINT PK_StatisticIndicators PRIMARY KEY CLUSTERED,
    Name NVARCHAR (50) NOT NULL
);
GO

CREATE TABLE IndicatorAttributes (
    ID INT IDENTITY (1, 1) 
		CONSTRAINT PK_IndicatorAttributes PRIMARY KEY CLUSTERED,
    Name NVARCHAR (50) NOT NULL
);
GO


CREATE TABLE SoccerEvents (
    ID INT IDENTITY (1, 1) 
		CONSTRAINT PK_SoccerEvents PRIMARY KEY CLUSTERED,
    EventNameID INT NOT NULL
		CONSTRAINT FK_SoccerEvents_EventNames FOREIGN KEY REFERENCES EventNames(ID),
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    CountryID INT NOT NULL
		CONSTRAINT FK_SoccerEvents_Countries FOREIGN KEY REFERENCES Countries(ID)
);
GO

CREATE TABLE TimePeriods (
	ID INT IDENTITY (1, 1)
		CONSTRAINT PK_TimePeriods PRIMARY KEY CLUSTERED,
);
GO

CREATE TABLE AgeCategories (
	ID INT IDENTITY (1, 1)
		CONSTRAINT PK_AgeCategories PRIMARY KEY CLUSTERED,
	Name NVARCHAR(255) NOT NULL
);
GO
CREATE TABLE TeamTypes (
	ID INT IDENTITY (1, 1)
		CONSTRAINT PK_TeamTypes PRIMARY KEY CLUSTERED,
	Name NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE Teams (
	ID INT IDENTITY (1, 1)
		CONSTRAINT PK_Teams PRIMARY KEY CLUSTERED,
	CityID INT NULL
		CONSTRAINT FK_Teams_Cities FOREIGN KEY REFERENCES Cities(ID),
	TeamGender BIT NOT NULL,
	AgeCategoryId INT NOT NULL
		CONSTRAINT FK_Teams_AgeCategories FOREIGN KEY REFERENCES AgeCategories(ID),
	TeamTypeId INT NOT NULL
		CONSTRAINT FK_Teams_TeamTypes FOREIGN KEY REFERENCES TeamTypes(ID),
	Name NVARCHAR(1000) NOT NULL,
	CountryId INT NOT NULL
		CONSTRAINT FK_Teams_Countries FOREIGN KEY REFERENCES Countries(ID),
	EstablishmentDate DATE NOT NULL
);
GO

CREATE TABLE ClubPresidents (
    ID INT IDENTITY (1, 1)
		CONSTRAINT PK_ClubPresidents PRIMARY KEY CLUSTERED,
    Name NVARCHAR (50) NOT NULL,
    ClubID INT NOT NULL
		CONSTRAINT FK_ClubPresidents_Clubs FOREIGN KEY REFERENCES Teams(ID),
    DateFrom DATE NOT NULL,
    DateTo DATE NULL
);
GO

CREATE TABLE ClubCoaches (
    ID INT IDENTITY (1, 1)
		CONSTRAINT PK_ClubCoaches PRIMARY KEY CLUSTERED,
    Name NVARCHAR (50) NOT NULL,
    ClubID INT NOT NULL
		CONSTRAINT FK_ClubCoaches_Clubs FOREIGN KEY REFERENCES Teams(ID),
    DateFrom DATE NOT NULL,
    DateTo DATE NULL
);
GO
CREATE TABLE TeamLeagueStatisticsParametrs
(
	ID INT IDENTITY (1, 1)
		CONSTRAINT PK_TeamLeagueStatisticsParametrs PRIMARY KEY CLUSTERED,
	Name NVARCHAR(255) NOT NULL
);
GO




CREATE TABLE RankingSystems (
	ID INT IDENTITY (1, 1)
		CONSTRAINT PK_RankingSystems PRIMARY KEY CLUSTERED,
	Name NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE Seasons (
    ID INT NOT NULL
        CONSTRAINT PK_Seasons PRIMARY KEY CLUSTERED,
    Season INT NOT NULL,
    Date DATE NOT NULL
);
GO

CREATE TABLE RankingTeams (
	ID INT IDENTITY (1, 1)
		CONSTRAINT PK_RankingTeams PRIMARY KEY CLUSTERED,
	SeasonID INT NULL
		CONSTRAINT FK_RankingTeams_Seasons FOREIGN KEY REFERENCES Seasons(ID),
	TeamID INT NOT NULL
		CONSTRAINT FK_RankingTeams_Teams FOREIGN KEY REFERENCES Teams(ID),
	TeamRank INT NOT NULL,
	RankDate DATE NULL,
	RatingSystemId INT NULL
		CONSTRAINT FK_RankingTeams_RankingSystem FOREIGN KEY REFERENCES RankingSystems(ID),
	Confederation NVARCHAR(255) NULL,
	TotalPoints FLOAT NULL,
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
	ID INT IDENTITY (1, 1)
		CONSTRAINT PK_RankingTeamsParametrs PRIMARY KEY CLUSTERED,
	Name NVARCHAR(255) NOT NULL
)

CREATE TABLE RankingTeamsParametrsValues (
	ID INT IDENTITY (1, 1)
		CONSTRAINT PK_RankingTeamsParametrsValues PRIMARY KEY CLUSTERED,
	ParametrValue FLOAT,
	RankingTeamsParametrsId INT NOT NULL
		CONSTRAINT FK_RankingTeamsParametrsValues_RankingTeamsParametrs FOREIGN KEY REFERENCES RankingTeamsParametrs(ID),
	RankingTeamsId INT NOT NULL
		CONSTRAINT FK_RankingTeamsParametrsValues_RankingTeams FOREIGN KEY REFERENCES RankingTeams(ID)
);
GO

CREATE TABLE Coaches (
  ID INT NOT NULL IDENTITY(1,1)
          CONSTRAINT PK_Coaches PRIMARY KEY CLUSTERED,
  Name NVARCHAR(200) NOT NULL,
  Sex BIT NOT NULL,
  BirthCountryId INT NOT NULL
          CONSTRAINT FK_Coaches_Countries FOREIGN KEY REFERENCES Countries(ID),
  DateOfBirth DATE NOT NULL,
  CurrentTeamId INT NULL
          CONSTRAINT FK_Coaches_Teams FOREIGN KEY REFERENCES Teams(ID),
  PlayerId INT NULL
          CONSTRAINT FK_Coaches_Players FOREIGN KEY REFERENCES Players(ID)
);
GO

CREATE TABLE TeamTactics
(
	ID INT IDENTITY(1,1)
		CONSTRAINT PK_TeamTactics PRIMARY KEY CLUSTERED,
	Teams INT NOT NULL
		CONSTRAINT FK_TeamTactics_Teams FOREIGN KEY REFERENCES Teams(ID),
	Name NVARCHAR(50),
	Description NVARCHAR(100),
	PositionImgURL NVARCHAR(MAX)
)

CREATE TABLE TeamCompositions
(
	ID INT IDENTITY(1,1)
		CONSTRAINT PK_TeamCompositions PRIMARY KEY CLUSTERED,
	TacticID INT
		CONSTRAINT FK_TeamCompositions_TeamTactics FOREIGN KEY REFERENCES TeamTactics(ID),
	MatchID INT,
	TeamID INT
		CONSTRAINT FK_TeamCompositions_Teams FOREIGN KEY REFERENCES Teams(ID),
	CoachID INT
		CONSTRAINT FK_TeamCompositions_Coaches FOREIGN KEY REFERENCES Coaches(ID)
);
GO

CREATE TABLE MatchStatuses
(
	ID INT IDENTITY (1,1)
		CONSTRAINT PK_MatchStatuses PRIMARY KEY CLUSTERED,
	Name NVARCHAR(50)
);
GO

CREATE TABLE Matches
(
	ID INT IDENTITY(1,1)
		CONSTRAINT PK_Matches PRIMARY KEY CLUSTERED,
	StadiumID INT NOT NULL,
	HomeTeamCompositionId INT NOT NULL
		CONSTRAINT FK_Matches_TeamCompositions_Home FOREIGN KEY REFERENCES TeamCompositions(ID),
	GuestTeamCompositionId INT NOT NULL
		CONSTRAINT FK_Matches_TeamCompositions_Guest FOREIGN KEY REFERENCES TeamCompositions(ID),
	Date DATETIME,
	TourID INT,
	ExtraTimes BIT NOT NULL,
	PenaltyRound BIT NOT NULL,
	MatchStatusID INT NOT NULL
		CONSTRAINT FK_Matches_MatchStatuses FOREIGN KEY REFERENCES MatchStatuses(ID)
);
GO

ALTER TABLE TeamCompositions ADD CONSTRAINT FK_TeamComposition_Matches FOREIGN KEY (MatchID) REFERENCES Matches(ID);

GO

CREATE TABLE Stadiums (
  ID INT IDENTITY(1,1)
          CONSTRAINT PK_Stadiums PRIMARY KEY CLUSTERED,
  OpeningDate DATE NOT NULL,
  Capacity INT NOT NULL,
  CityID INT NULL
          CONSTRAINT FK_Stadiums_Cities FOREIGN KEY REFERENCES Cities(ID)
);
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


CREATE TABLE FootballSystems (
    Id INT IDENTITY(1,1)
        CONSTRAINT PK_FootballSystems PRIMARY KEY CLUSTERED,
    Name NVARCHAR(100) NOT NULL,
    CountryId INT NOT NULL
        CONSTRAINT FK_FootballSystem_Country FOREIGN KEY REFERENCES Countries(Id)
);

GO
CREATE TABLE Leagues (
    Id INT IDENTITY(1,1)
        CONSTRAINT PK_Leagues PRIMARY KEY CLUSTERED,
    FootballSystemId INT NOT NULL
        CONSTRAINT FK_Leagues_FootballSystems FOREIGN KEY REFERENCES FootballSystems(Id),
    Name NVARCHAR(50) NOT NULL
);
GO

CREATE TABLE TeamLeagueStatistics (
	ID INT IDENTITY(1,1)
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
);
GO
CREATE TABLE TeamLeagueStatisticsParametrValues
(
	ID INT IDENTITY(1,1)
		CONSTRAINT PK_TeamLeagueStatisticsParametrValues PRIMARY KEY CLUSTERED,
	ParametrValue FLOAT NOT NULL,
	TeamsLeaguesParametrsId INT
		CONSTRAINT FK_TeamsLeaguesStatisticsParametrsValues_TeamsLeaguesParametrs FOREIGN KEY REFERENCES TeamLeagueStatisticsParametrs(ID),
	TeamLeagueStatisticsId INT
		CONSTRAINT FK_TeamsLeaguesStatisticsParametrsValues_TTeamLeagueStatisticsId FOREIGN KEY REFERENCES TeamLeagueStatistics(ID)
)

CREATE TABLE Standings (
	ID INT IDENTITY(1,1)  
		CONSTRAINT PK_Standings PRIMARY KEY CLUSTERED,
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
    Id INT IDENTITY(1,1)
        CONSTRAINT PK_Division PRIMARY KEY CLUSTERED,
    LeagueId INT NOT NULL
        CONSTRAINT FK_Division_League FOREIGN KEY REFERENCES Leagues(Id),
    Name NVARCHAR(50) NOT NULL
);


CREATE TABLE LeagueSeasons (
    Id INT IDENTITY(1,1)
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
    ID INT IDENTITY (1, 1)
		CONSTRAINT PK_PlayerStatistics PRIMARY KEY CLUSTERED,
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
    Value FLOAT NOT NULL,
	CONSTRAINT PK_PlayerStatisticID_IndicatorAttributeID PRIMARY KEY CLUSTERED (PlayerStatisticID, IndicatorAttributeID)
);

GO
CREATE TABLE LeagueMatches (
    Id INT IDENTITY (1, 1)
        CONSTRAINT PK_LeagueMatches PRIMARY KEY CLUSTERED,
    HomeTeamId INT NOT NULL
        CONSTRAINT FK_LeagueMatch_HomeTeam FOREIGN KEY REFERENCES TeamInLeagues(Id),
    VisitorTeamId INT NOT NULL
        CONSTRAINT FK_LeagueMatch_VisitorTeam FOREIGN KEY REFERENCES TeamInLeagues(Id),
    MatchId INT NOT NULL
        CONSTRAINT FK_LeagueMatch_Match FOREIGN KEY REFERENCES Matches(Id),
);
GO

CREATE TABLE Deals (
    Id INT IDENTITY (1, 1)
        CONSTRAINT PK_Deals PRIMARY KEY CLUSTERED,
    Price DECIMAL(12,2),
    PlayerId INT NOT NULL
        CONSTRAINT FK_Deals_Player FOREIGN KEY REFERENCES Players(Id),
    SeasonId INT NOT NULL
        CONSTRAINT FK_Deals_Season FOREIGN KEY REFERENCES Seasons(Id),
    NewTeamId INT NOT NULL
        CONSTRAINT FK_Deals_NewTeam FOREIGN KEY REFERENCES Teams(Id),
    OldTeamId INT NOT NULL
        CONSTRAINT FK_Deals_OldTeam FOREIGN KEY REFERENCES Teams(Id),
    Date DATE NOT NULL
);


CREATE TABLE Loans (
    Id INT IDENTITY(1, 1)
        CONSTRAINT PK_Loans PRIMARY KEY CLUSTERED,
    DealId INT NOT NULL
        CONSTRAINT FK_Loan_Deals FOREIGN KEY REFERENCES Deals(Id),
    EndDate DATE NOT NULL
);
GO

 

CREATE TABLE Tournaments (
    Id INT IDENTITY(1, 1)
        CONSTRAINT PK_Tournaments PRIMARY KEY CLUSTERED,
    Name NVARCHAR(50) NOT NULL
);
GO

 

CREATE TABLE TournamentSeasons (
    Id INT IDENTITY(1, 1)
        CONSTRAINT PK_TournamentSeasons PRIMARY KEY CLUSTERED,
    TournamentId INT NOT NULL
        CONSTRAINT FK_TournamentSeasons_Tournaments FOREIGN KEY REFERENCES Tournaments(Id),
    SeasonId INT NOT NULL
        CONSTRAINT FK_TournamentSeasons_Seasons FOREIGN KEY REFERENCES Seasons(Id)
);
GO

 

CREATE TABLE TournamentGroups (
    Id INT IDENTITY(1, 1)
        CONSTRAINT PK_TournamentGroups PRIMARY KEY CLUSTERED,
    TournamentBySeasonId INT NOT NULL
        CONSTRAINT FK_TournamentGroups_TournamentSeasons FOREIGN KEY REFERENCES TournamentSeasons(Id),
    GroupLetter CHAR(1) NOT NULL
);
GO

 

CREATE TABLE TeamInGroups (
    Id INT IDENTITY(1, 1)
        CONSTRAINT PK_TeamInGroups PRIMARY KEY CLUSTERED,
    TournamentGroupId INT NOT NULL
        CONSTRAINT FK_TeamInGroups_TournamentGroups FOREIGN KEY REFERENCES TournamentGroups(Id),
    TeamId INT NOT NULL
        CONSTRAINT FK_TeamInGroups_Teams FOREIGN KEY REFERENCES Teams(Id)
);
GO

 

CREATE TABLE MatchTypes (
    Id INT IDENTITY(1, 1)
        CONSTRAINT PK_MatchTypes PRIMARY KEY CLUSTERED,
    Name NVARCHAR(50) NOT NULL
);
GO


CREATE TABLE TournamentsMatches (
    Id INT NOT NULL
        CONSTRAINT PK_TournamentMatches PRIMARY KEY CLUSTERED,
    HomeTeamId INT NOT NULL
        CONSTRAINT FK_TournamentMatches_HomeTeam FOREIGN KEY REFERENCES TeamInGroups(Id),
    VisitorTeamId INT NOT NULL
        CONSTRAINT FK_TournamentMatches_VisitorTeam FOREIGN KEY REFERENCES TeamInGroups(Id),
    MatchId INT NOT NULL
        CONSTRAINT FK_TournamentMatches_Matches FOREIGN KEY REFERENCES Matches(Id),
    MatchTypes INT NOT NULL
        CONSTRAINT FK_TournamentMatcesh_MatchType FOREIGN KEY REFERENCES MatchTypes(Id)
);

GO

CREATE TABLE CoachTrophies (
  ID INT NOT NULL IDENTITY(1,1)
          CONSTRAINT PK_CoachTrophies PRIMARY KEY CLUSTERED,
  Name NVARCHAR(200) NOT NULL,
  CoachId INT NOT NULL
          CONSTRAINT FK_CoachTrophies_Coaches FOREIGN KEY REFERENCES Coaches(ID),
  LeagueId INT NULL
          CONSTRAINT FK_CoachTrophies_Leagues FOREIGN KEY REFERENCES Leagues(Id),
  Date DATE NOT NULL,
  TeamId INT NOT NULL
          CONSTRAINT FK_CoachTrophies_Teams FOREIGN KEY REFERENCES Teams(ID)
);
GO


CREATE TABLE Contracts (
  ID INT IDENTITY(1,1)
          CONSTRAINT PK_Contracts PRIMARY KEY CLUSTERED,
  TeamId INT NOT NULL
          CONSTRAINT FK_Contracts_Teams FOREIGN KEY REFERENCES Teams(ID),
  StartDate DATETIME NULL,
  EndDate DATETIME NULL,
  CoachId INT NOT NULL
          CONSTRAINT FK_Contracts_Coaches FOREIGN KEY REFERENCES Coaches(ID)
);
GO

 

CREATE TABLE CoachsTeamStatistics (
  ID INT IDENTITY(1,1)
          CONSTRAINT PK_CoachsTeamStatistics PRIMARY KEY CLUSTERED,
  CoachId INT NOT NULL
          CONSTRAINT FK_CoachsTeamStatistics_Coaches FOREIGN KEY REFERENCES Coaches(ID),
  TeamId INT NOT NULL
          CONSTRAINT FK_CoachsTeamStatistics_Teams FOREIGN KEY REFERENCES Teams(ID),
  GamesCountTotal INT NULL,
  WinCountTotal INT NULL,
  LoseCountTotal INT NULL,
  DrawCountTotal INT NULL,
  TotalPoint INT NULL
);
GO

CREATE TABLE HomeTeams (
  ID INT NOT NULL IDENTITY(1,1)
          CONSTRAINT PK_HomeTeams PRIMARY KEY CLUSTERED,
  StadiumID INT NOT NULL
          CONSTRAINT FK_HomeTeams_Stadiums FOREIGN KEY REFERENCES Stadiums(ID),
  StartDate DATE NULL,
  EndDate DATE NULL
);
GO

 

CREATE TABLE StadiumAttributeTypes (
  ID INT NOT NULL IDENTITY(1,1)
          CONSTRAINT PK_StadiumAttributeTypes PRIMARY KEY CLUSTERED,
  Name NVARCHAR(200) NULL,
  Description NVARCHAR(MAX) NULL
);
GO

 

CREATE TABLE StadiumAttributes (
  ID INT NOT NULL IDENTITY(1,1)
          CONSTRAINT PK_StadiumAttributes PRIMARY KEY CLUSTERED,
  TypeID INT NULL
          CONSTRAINT FK_StadiumAttributes_StadiumAttributeTypes FOREIGN KEY REFERENCES StadiumAttributeTypes(ID),
  Value VARCHAR(MAX) NOT NULL,
  StartDate DATETIME NULL,
  EndDate DATETIME NULL,
  StadiumID INT NOT NULL
          CONSTRAINT FK_StadiumAttributes_Stadiums FOREIGN KEY REFERENCES Stadiums(ID)
);
GO
 

CREATE TABLE Referees (
  ID INT NOT NULL IDENTITY(1,1)
          CONSTRAINT PK_Referees PRIMARY KEY CLUSTERED,
  Name NVARCHAR(200) NOT NULL,
  BirthCountryId INT NOT NULL
          CONSTRAINT FK_Referees_Countries FOREIGN KEY REFERENCES Countries(ID),
  BirthDate DATE NOT NULL,
  CareerDateFrom DATE NULL,
  CareerDateTo DATE NULL,
  Sex BIT NOT NULL
);
GO

 

CREATE TABLE RefereeStatOfMatch (
  ID INT IDENTITY(1,1)
          CONSTRAINT PK_RefereeStatOfMatch PRIMARY KEY CLUSTERED,
  MatchId INT NOT NULL
          CONSTRAINT FK_RefereeStatOfMatch_Matches FOREIGN KEY REFERENCES Matches(ID),
  RefereeId INT NOT NULL
          CONSTRAINT FK_RefereeStatOfMatch_Referees FOREIGN KEY REFERENCES Referees(ID),
  FixedFouls INT NULL DEFAULT NULL
);
GO

CREATE TABLE Cards (
  ID INT IDENTITY(1,1)
          CONSTRAINT PK_Cards PRIMARY KEY CLUSTERED,
  RefereeStatID INT NOT NULL
          CONSTRAINT FK_Cards_RefereeStatOfMatch FOREIGN KEY REFERENCES RefereeStatOfMatch(ID),
  PlayerID INT NULL
          CONSTRAINT FK_Cards_Players FOREIGN KEY REFERENCES Players(ID),
  CardType VARCHAR(10) NOT NULL,
  Time INT NULL
);
GO


CREATE TABLE MatchItemTypes
(
	ID INT IDENTITY(1,1)
		CONSTRAINT PK_MatchItemTypes PRIMARY KEY CLUSTERED,
	Name VARCHAR(250)
);
GO



CREATE TABLE ActionTypes
(
	ID INT IDENTITY(1,1)
		CONSTRAINT PK_ActionTypes PRIMARY KEY CLUSTERED,
	Name NVARCHAR(100)
);
GO

CREATE TABLE ActionItemsTypes
(
	ID INT IDENTITY(1,1)
		CONSTRAINT PK_ActionItemsTypes PRIMARY KEY CLUSTERED,
	Name NVARCHAR(50)
);
GO

CREATE TABLE MatchEventTypes
(
	ID INT IDENTITY(1,1)
		CONSTRAINT PK_EventTypes  PRIMARY KEY CLUSTERED,
	Name NVARCHAR(50),
	isViolation BIT NOT NULL
);
GO


CREATE TABLE MatchItemsAttributesTypes
(
	ID INT IDENTITY(1,1)
		CONSTRAINT PK_MatchItemsAttributesTypes PRIMARY KEY CLUSTERED,
	Name VARCHAR(100)
);
GO

CREATE TABLE RefereeTypes
(
	ID INT IDENTITY(1,1)
		CONSTRAINT PK_RefereeTypes PRIMARY KEY CLUSTERED,
	Name NVARCHAR(250)
);
GO


CREATE TABLE RefereeInMatches
(
	ID INT IDENTITY(1,1)
		CONSTRAINT PK_RefereeInMatches PRIMARY KEY CLUSTERED,
	RefereeID INT
			CONSTRAINT FK_RefereeInMatches_Referee FOREIGN KEY REFERENCES Referees(ID),
	MatchID INT
		CONSTRAINT FK_RefereeInMatches_Matches FOREIGN KEY REFERENCES Matches(ID),
	RefereeTypeID INT
		CONSTRAINT FK_RefereeInMatches_RefereeTypes FOREIGN KEY REFERENCES RefereeTypes(ID)
);
GO

CREATE TABLE PlayersInMatches
(
	ID INT IDENTITY(1,1)
		CONSTRAINT PK_PlayersInMatches PRIMARY KEY CLUSTERED,
	PlayerID INT
			CONSTRAINT FK_PlayersInMatches_Players FOREIGN KEY REFERENCES Players(ID),
	PositionID INT
			CONSTRAINT FK_PlayersInMatches_Positions FOREIGN KEY REFERENCES Positions(ID),
	IsSubstitute BIT,
	TimeParticipated TIME NOT NULL,
	TeamCompositionID INT
		CONSTRAINT FK_PlayersInMatches_TeamComposition FOREIGN KEY REFERENCES TeamCompositions(ID),
	MatchID INT
		CONSTRAINT FK_PlayersInMatches_Matches FOREIGN KEY REFERENCES Matches(ID)
);
GO

CREATE TABLE MatchTimes
(
	ID INT IDENTITY(1,1),
	MatchID INT
		CONSTRAINT FK_MatchTimes_Matches FOREIGN KEY REFERENCES Matches(ID),
	Duration TIME NOT NULL,
		CONSTRAINT PK_TimeID_MatchID PRIMARY KEY CLUSTERED (ID, MatchID)
);
GO

CREATE TABLE MatchItems
(
	ID INT IDENTITY(1,1)
		CONSTRAINT PK_MatchItems PRIMARY KEY CLUSTERED,
	TypeID INT NOT NULL
		CONSTRAINT FK_MatchItems_MatchItemTypes FOREIGN KEY REFERENCES MatchItemTypes(ID),
	Value INT,
	TeamCompositionID INT NOT NULL
		CONSTRAINT FK_MatchItems_TeamCompositions FOREIGN KEY REFERENCES TeamCompositions(ID),
	MatchTimeID INT NOT NULL,
	MatchID INT NOT NULL
		CONSTRAINT FK_MatchItems_Matches FOREIGN KEY REFERENCES Matches(ID),
		CONSTRAINT FK_MatchItems_MatchTime FOREIGN KEY (MatchTimeID, MatchID) REFERENCES MatchTimes (ID, MatchID)
);
GO

CREATE TABLE MatchItemsAttributes
(
	MatchItemId INT NOT NULL
		CONSTRAINT FK_MatchItemsAttributes_MatchItems FOREIGN KEY REFERENCES MatchItems(ID),
	MatchItemsAttributesTypeID INT NOT NULL
		CONSTRAINT FK_MathcItemsAtributes_MatchItemsAttributesTypes FOREIGN KEY REFERENCES MatchItemsAttributesTypes(ID),
	Value NVARCHAR(MAX),
	CONSTRAINT PK_MatchItemId_MatchItemsAttributesTypeID PRIMARY KEY CLUSTERED (MatchItemId, MatchItemsAttributesTypeID)

);
GO

CREATE TABLE MatchEvents
(
	ID INT IDENTITY(1,1)
		CONSTRAINT PK_MatchEvents PRIMARY KEY CLUSTERED,
	MatchEventTypeID INT
		CONSTRAINT FK_MatchEvents_MatchEventType FOREIGN KEY REFERENCES MatchEventTypes(ID),
	Time TIME,
	MatchTimeID INT,
	Description NVARCHAR(250),
	MatchID INT
		CONSTRAINT FK_MatchEvents_Matches FOREIGN KEY REFERENCES Matches(ID)
);
GO

CREATE TABLE PersonMatchEvents
(
	ID INT IDENTITY(1,1)
		CONSTRAINT PK_PersonMatchEvents PRIMARY KEY CLUSTERED,
	PlayersInMatchID INT
		CONSTRAINT FK_PersonMatchEvents_PlayersInMatches FOREIGN KEY REFERENCES PlayersInMatches(ID),
	MatchEventID INT
		CONSTRAINT FK_PersonMatchEvents_MatchEvents	FOREIGN KEY REFERENCES MatchEvents(ID),
	Time DATETIME,
	ActionTypeID INT
		CONSTRAINT FK_PersonMatchEvents_ActionType FOREIGN KEY REFERENCES ActionTypes(ID),
	CoachID INT
			CONSTRAINT FK_PersonMatchEvents_Coaches FOREIGN KEY REFERENCES Coaches(ID),-- Merge part
	RefereeInMatchID INT
		CONSTRAINT FK_PersonMatchEvents_RefereeInMatches FOREIGN KEY REFERENCES RefereeInMatches(ID),
		CONSTRAINT CHK_PlayersInMatchID_RefereeInMatchID_CoachID CHECK ((PlayersInMatchID IS NOT NULL AND RefereeInMatchID IS NULL AND CoachID IS NULL) OR
			   (PlayersInMatchID IS NULL AND RefereeInMatchID IS NOT NULL AND CoachID IS NULL) OR
			   (PlayersInMatchID IS NOT NULL AND RefereeInMatchID IS NULL AND CoachID IS NOT NULL))
);
GO

CREATE TABLE ActionItems
(
	PersonMatchEventsId INT NOT NULL
		CONSTRAINT FK_ActionItems_PersonMatchEvents FOREIGN KEY REFERENCES PersonMatchEvents(ID),
	ActionItemsTypeId INT NOT NULL
		CONSTRAINT FK_ActionItems_ActionItemsType FOREIGN KEY REFERENCES ActionItemsTypes(ID),
	Value NVARCHAR(MAX),
		CONSTRAINT PK_ActionItems PRIMARY KEY CLUSTERED (PersonMatchEventsID, ActionItemsTypeId)
);
GO
