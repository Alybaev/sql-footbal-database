
USE FootbalTeams
DROP TABLE IF EXISTS Standings, TeamsMatches,TeamsLeagues, Teams,  RankingTeams,RankingSystems
CREATE TABLE Teams (
	ID INT NOT NULL
		CONSTRAINT PK_Teams PRIMARY KEY CLUSTERED,
	TeamAgeId INT NOT NULL, --�������,����������
	TeamType INT NOT NULL,   -- ������������, ����
	TeamGender INT NOT NULL, -- �������, �������
	Name VARCHAR(1000) NOT NULL,
	CountryId INT NOT NULL, --FOREIGN
	EstablishmentDate DATE NOT NULL
)
CREATE TABLE TeamsMatches (
	ID INT NOT NULL
		CONSTRAINT PK_TeamsMatches PRIMARY KEY CLUSTERED,
	TeamID INT NOT NULL
		CONSTRAINT FK_Teams_Matches FOREIGN KEY REFERENCES Teams(ID),
	MatchID INT NOT NULL, --FOREIGN
	SomeStatistics INT NOT NULL

)
CREATE TABLE TeamsLeagues (
	ID INT NOT NULL
		CONSTRAINT PK_TeamsLeagues PRIMARY KEY CLUSTERED,
	TeamID INT NOT NULL
		CONSTRAINT FK_Teams_Leagues FOREIGN KEY REFERENCES Teams(ID),
	LeagueID INT NOT NULL, --FOREIGN
	SomeStatistics INT NOT NULL

)
CREATE TABLE RankingSystems (
	ID INT NOT NULL
		CONSTRAINT PK_RankingSystem PRIMARY KEY CLUSTERED,
)
CREATE TABLE RankingTeams (
	ID INT NOT NULL
		CONSTRAINT PK_RankingTeams PRIMARY KEY CLUSTERED,
	SeasonID INT NULL, --FOREIGN KEY
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