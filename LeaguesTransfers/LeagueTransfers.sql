USE FootbalTeams

DROP TABLE  IF EXISTS TournamentsMatches, MatchTypes, TeamInGroups, TournamentGroups
DROP TABLE IF EXISTS TournamentSeasons, Tournaments, Loans, Deals
DROP TABLE IF EXISTS LeagueMatches, TeamInLeagues, LeagueSeasons, Divisions
DROP TABLE IF EXISTS Leagues, FootballSystem, Seasons, Players, Countries, Matches
CREATE TABLE Matches (
    Id INT NOT NULL
        CONSTRAINT PK_Match PRIMARY KEY CLUSTERED,
    [Date] DATETIME2(7) NOT NULL
);

CREATE TABLE Countries (
    Id INT NOT NULL
        CONSTRAINT PK_Country PRIMARY KEY CLUSTERED,
    [Name] NVARCHAR(100) NOT NULL
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