USE FootbalTeams
DROP TABLE IF EXISTS StatisticAttributes, PlayerStatistics, PlayerStatistics, MatchTeams, Matches, ClubCoaches, ClubPresidents, Clubs, Stadiums, SoccerEvents
DROP TABLE IF EXISTS Cities,  EventNames, Positions, StatisticIndicators, IndicatorAttributes, Players


CREATE TABLE Cities (
    ID INT PRIMARY KEY IDENTITY (1, 1),
    Name VARCHAR (50) NOT NULL,
    CountryID INT NOT NULL
		CONSTRAINT FK_Cities_Countries FOREIGN KEY REFERENCES Countries(ID)
);
GO

CREATE TABLE EventNames (                        
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

CREATE TABLE Players (                         
    ID INT PRIMARY KEY IDENTITY (1, 1),
    FirstName NVARCHAR (50) NOT NULL,
    LastName NVARCHAR (50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Height FLOAT NOT NULL,
    IsRightLeg BIT NOT NULL
);
 GO 

CREATE TABLE Stadiums (
    ID INT PRIMARY KEY IDENTITY (1, 1),
    Name VARCHAR (50) NOT NULL,
    Capacity INT NOT NULL,
    CityID INT NOT NULL
		CONSTRAINT FK_Stadiums_Cities FOREIGN KEY REFERENCES Cities(ID)
);
GO

CREATE TABLE Clubs (
    ID INT PRIMARY KEY IDENTITY (1, 1),
    Name VARCHAR (50) NOT NULL,
    CityID INT NOT NULL
		CONSTRAINT FK_Clubs_Cities FOREIGN KEY REFERENCES Cities(ID),
    DateOfFoundation DATE NOT NULL
);
GO

CREATE TABLE ClubPresidents (
    ID INT PRIMARY KEY IDENTITY (1, 1),
    Name VARCHAR (50) NOT NULL,
    ClubID INT NOT NULL 
		CONSTRAINT FK_ClubPresidents_Clubs FOREIGN KEY REFERENCES Clubs(ID),
    DateFrom DATE NOT NULL,
    DateTo DATE NULL
);
GO

CREATE TABLE ClubCoaches (
    ID INT PRIMARY KEY IDENTITY (1, 1),
    Name VARCHAR (50) NOT NULL,
    ClubID INT NOT NULL 
		CONSTRAINT FK_ClubCoaches_Clubs FOREIGN KEY REFERENCES Clubs(ID),
    DateFrom DATE NOT NULL,
    DateTo DATE NULL
);
GO

CREATE TABLE Positions (                        
    ID INT PRIMARY KEY IDENTITY (1, 1),
    Name VARCHAR (50) NOT NULL
);
GO

CREATE TABLE Matches (                         
    ID INT PRIMARY KEY IDENTITY (1, 1),
    SoccerEventID INT NOT NULL
		CONSTRAINT FK_Matches_SoccerEvents FOREIGN KEY REFERENCES SoccerEvents(ID),
    StadiumID INT NOT NULL
		CONSTRAINT FK_Matches_Stadiums FOREIGN KEY REFERENCES Stadiums(ID),
    [Date] DATETIME2(7) NOT NULL
);
 GO 

CREATE TABLE MatchTeams (
    MatchID INT PRIMARY KEY
		CONSTRAINT FK_MatchTeams_Matches FOREIGN KEY REFERENCES Matches(ID),
    ClubID INT NOT NULL
		CONSTRAINT FK_MatchTeams_Clubs FOREIGN KEY REFERENCES Clubs(ID),
    PlayerID INT NOT NULL
		CONSTRAINT FK_MatchTeams_Players FOREIGN KEY REFERENCES Players(ID), 
    PositionID INT NOT NULL
		CONSTRAINT FK_MatchTeams_Positions FOREIGN KEY REFERENCES Positions(ID),
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