CREATE DATABASE MatchStatistics
USE MatchStatistics
CREATE TABLE MatchItemTypes 
(
	ID INT NOT NULL IDENTITY(1,1)
		CONSTRAINT PK_MatchItemTypes PRIMARY KEY CLUSTERED,
	Name VARCHAR(250)
)

CREATE TABLE MatchStatuses 
(
	ID INT NOT NULL IDENTITY (1,1) 
		CONSTRAINT PK_MatchStatuses PRIMARY KEY CLUSTERED,
	Name NVARCHAR(50)
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

CREATE TABLE TeamTactics 
(
	ID INT NOT NULL IDENTITY(1,1)
		CONSTRAINT PK_TeamTactics PRIMARY KEY CLUSTERED,
	TeamID INT NOT NULL, --FK -> 'Team' table
	Name NVARCHAR(50),
	Description NVARCHAR(100),
	PositionImgURL NVARCHAR(MAX)
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

CREATE TABLE RefereeInMatch
(
	ID INT NOT NULL IDENTITY(1,1)
		CONSTRAINT PK_RefereeInMatch PRIMARY KEY CLUSTERED,
	--RefereeID INT
	--		CONSTRAINT FK_RefereeInMatch_Referee FOREIGN KEY REFERENCES Referees(ID)
	MatchID INT
		CONSTRAINT FK_RefereeInMatch_Matches FOREIGN KEY REFERENCES Matches(ID),
	RefereeTypeID INT 
		CONSTRAINT FK_RefereeInMatch_RefereeType FOREIGN KEY REFERENCES RefereeType(ID)
)

CREATE TABLE PlayersInMatch
(
	ID INT NOT NULL IDENTITY(1,1)
		CONSTRAINT PK_PlayersInMatch PRIMARY KEY CLUSTERED,
	--PlayerID INT
	--		CONSTRAINT FK_PlayersInMatch_Players FOREIGN KEY REFERENCES Players(ID),
	--PositionID INT
	--		CONSTRAINT FK_PlayersInMatch_Positions FOREIGN KEY REFERENCES Positions(ID),
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
	CoachID INT,
	--		CONSTRAINT FK_PersonMatchEvents_Coaches FOREIGN KEY REFERENCES Coaches(ID), Merge part
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
