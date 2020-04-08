DROP TABLE IF EXISTS [Coaches];
		
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


DROP TABLE IF EXISTS [CoachTrophies];
		
CREATE TABLE CoachTrophies (
  [ID] INTEGER NOT NULL IDENTITY,
  [Name] VARCHAR(200) NULL DEFAULT NULL,
  [CoachId] INTEGER NULL DEFAULT NULL,
  [LeagueId] INTEGER NULL DEFAULT NULL,
  [Date] DATE NULL DEFAULT NULL,
  [TeamId] INTEGER NULL DEFAULT NULL,
  PRIMARY KEY ([ID])
);


DROP TABLE IF EXISTS [Contracts];
		
CREATE TABLE Contracts (
  [ID] INTEGER NOT NULL IDENTITY,
  [TeamId] INTEGER NULL DEFAULT NULL,
  [StartDate] DATETIME2(0) NULL DEFAULT NULL,
  [EndDate] INTEGER NULL DEFAULT NULL,
  [CoachId] INTEGER NULL DEFAULT NULL,
  PRIMARY KEY ([ID])
);


DROP TABLE IF EXISTS [CoachStatistics];
		
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

DROP TABLE IF EXISTS [Stadiums];
		
CREATE TABLE Stadiums (
  [ID] INTEGER NOT NULL IDENTITY,
  [OpeningDate] DATE NULL DEFAULT NULL,
  [CityID] INTEGER NULL DEFAULT NULL,
  PRIMARY KEY ([ID])
);

DROP TABLE IF EXISTS [HomeTeams];
		
CREATE TABLE HomeTeams (
  [ID] INTEGER NOT NULL IDENTITY,
  [StadiumsID] INTEGER NULL DEFAULT NULL,
  [StartDate] DATE NULL DEFAULT NULL,
  [EndDate] DATE NULL DEFAULT NULL,
  PRIMARY KEY ([ID])
);


DROP TABLE IF EXISTS [StadiumAttributes];
		
CREATE TABLE StadiumAttributes (
  [ID] INTEGER NOT NULL IDENTITY,
  [TypeID] INTEGER NULL DEFAULT NULL,
  [Value] VARCHAR(max) NOT NULL DEFAULT 'NULL',
  [StartDate] DATETIME2(0) NULL DEFAULT NULL,
  [EndDate] DATETIME2(0) NULL DEFAULT NULL,
  [StadiumID] INTEGER NULL DEFAULT NULL,
  PRIMARY KEY ([ID])
);


DROP TABLE IF EXISTS [StadiumAttributeTypes];
		
CREATE TABLE StadiumAttributeTypes (
  [ID] INTEGER NOT NULL IDENTITY,
  [Name] VARCHAR(200) NULL DEFAULT NULL,
  [Description] VARCHAR(5000) NULL DEFAULT NULL,
  PRIMARY KEY ([ID])
);

DROP TABLE IF EXISTS [Cards];
		
CREATE TABLE Cards (
  [ID] INTEGER NOT NULL IDENTITY,
  [RefereeStatID] INTEGER NULL DEFAULT NULL,
  [PlayerID] INTEGER NULL DEFAULT NULL,
  [CardType] INTEGER NULL DEFAULT NULL,
  [Time] INTEGER NULL DEFAULT NULL,
  PRIMARY KEY ([ID])
);


DROP TABLE IF EXISTS [Referees];
		
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

DROP TABLE IF EXISTS [RefereeStatOfMatch];
		
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


-- Добавление тестовых данных 

 --INSERT INTO Coaches ([ID],[Name],[Sex],[CurrentTeamId],[CountryId],[DateOfBirth],[BirthCountryId],[PlayerId]) VALUES
 --('','','','','','','','');
 --INSERT INTO CoachTrophies ([ID],[Name],[CoachId],[LeagueId],[Date],[ClubId]) VALUES
 --('','','','','','');
 --INSERT INTO Contracts ([ID],[TeamId],[StartDate],[EndDate],[CoachId]) VALUES
 --('','','','','');
 --INSERT INTO CoachStatistics ([ID],[CoachId],[GamesCountTotal],[WinCountTotal],[LoseCountTotal],[CurrentTeamId],[DrawCountTotal],[TotalPoint]) VALUES
 --('','','','','','','','');
 --INSERT INTO Countries ([ID],[Name]) VALUES
 --('','');
 --INSERT INTO Cities ([ID],[Name],[CountryID]) VALUES
 --('','','');
 --INSERT INTO Stadiums ([ID],[OpeningDate],[CityID]) VALUES
 --('','','');
 --INSERT INTO HomeTeams ([ID],[StadiumsID],[StartDate],[EndDate]) VALUES
 --('','','','');
 --INSERT INTO StadiumAttributes ([ID],[TypeID],[Value],[StartDate],[EndDate],[StadiumID]) VALUES
 --('','','','','','');
 --INSERT INTO StadiumAttributeTypes ([ID],[Name],[Description]) VALUES
 --('','','');
 --INSERT INTO Cards ([ID],[RefereeStatID],[PlayerID],[CardType],[Time]) VALUES
 --('','','','','');
 --INSERT INTO Referees ([ID],[Name],[BirthCountryId],[BirthDate],[CareerDateFrom],[CareerDateTo],[Sex]) VALUES
 --('','','','','','','');
 --INSERT INTO RefereeStatOfMatch ([ID],[MatchId],[RefereeId],[FixedFouls]) VALUES
 --('','','','');