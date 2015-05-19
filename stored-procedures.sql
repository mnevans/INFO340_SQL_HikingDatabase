-- 1
-- Enter a new trail into the database

USE Happy_Trails
GO
CREATE PROCEDURE spNewAssociationTrail
	@AssociationName VARCHAR(50),
	@LevelName VARCHAR(50),
	@RegionName VARCHAR(50),
	@TrailName VARCHAR(100),
	@TrailLength INT,
	@TrailElevation INT,
	@TrailAddress VARCHAR(200),
	@TrailCity VARCHAR(50),
	@TrailState VARCHAR(25),
	@TrailZipCode VARCHAR(5)
	
AS
BEGIN
	DECLARE @LevelID INT = 
	(SELECT LevelID FROM tblLEVEL 
	WHERE LevelName LIKE @LevelName)

	DECLARE @RegionID INT = 
	(SELECT RegionID FROM tblREGION
	WHERE RegionName LIKE @RegionName)

	INSERT INTO tblTRAIL
	VALUES (@TrailName, @LevelID, @RegionID)

	DECLARE @TrailID INT = (SELECT @IDENTITY)

	DECLARE @AssociationID INT = 
	(SELECT AssociationID FROM tblASSOCIATION
	WHERE AssociationName LIKE @AssociationName)

	INSERT INTO tblASSOCIATION_TRAIL
	VALUES (@AssociationID, @TrailID)

	INSERT INTO tblDESCRIPTION
	VALUES (@TrailLength, @TrailElevation, @TrailAddress, 
	@TrailCity, @TrailState, @TrailZipCode, @TrailID)
END

-- 2
-- Enter a new trail attraction into the database

USE Happy_Trails
GO
CREATE PROCEDURE spNewTrailAttraction
	@TrailName VARCHAR(100),
	@AttractionName VARCHAR(50),
	@AttractionDescr VARCHAR(500),
	@AttractionTypeName VARCHAR(50)

AS
BEGIN
	DECLARE @AttractionTypeID INT = 
	(SELECT AttractionTypeID FROM tblATTRACTION_TYPE 
	WHERE AttractionTypeName LIKE @AttractionTypeName)

	INSERT INTO tblATTRACTION
	VALUES (@AttractionName, @AttractionDescr, @AttractionTypeID)

	DECLARE @AttractionID INT = (SELECT @IDENTITY)

	DECLARE @DescriptionID INT = 
	(SELECT DescriptionID FROM tblDESCRIPTION d
		JOIN tblTRAIL t
		ON d.TrailID = t.TrailID
	WHERE t.TrailName LIKE @TrailName)

	INSERT INTO tblDESCRIPTION_ATTRACTION
	VALUES (@DescriptionID, @AttractionID)
END

-- 3
-- Enter a new hiker into the database

USE Happy_Trails
GO
CREATE PROCEDURE spNewHiker
	@HikerFName VARCHAR (60),
	@HikerLName VARCHAR (60),
	@HikerAddress VARCHAR (100),
	@HikerCity VARCHAR (75),
	@HikerState VARCHAR (25),
	@HikerZip INT,
	@HikerDoB date

AS
BEGIN
	DECLARE @HikerTypeID INT = 
	(SELECT HikerTypeID FROM tblHIKER_TYPE
	WHERE HikerTypeName LIKE @HikerTypeName)

	INSERT INTO tblHIKER
	VALUES (@HikerFName, @HikerLName, @HikerAddress, @HikerCity, @HikerState, @HikerZip, @HikerDoB)

	DECLARE @HikerID INT = (SELECT @IDENTITY)

	DECLARE @TrailHikerID INT = 
	(SELECT TrailHikerID FROM tblTRAIL_HIKER th
		JOIN tblHIKER h
		ON th.HikerID = h.HikerID
	WHERE h.HikerFName LIKE @HikerFName
	AND h.HikerLName LIKE @HikerLName)

	INSERT INTO tblTRAIL_HIKER
	VALUES (@TrailID, @HikerID, @Date)
END

-- 4
-- Enter a new user review into the database

USE Happy_Trails
GO
CREATE PROCEDURE spNewTrailReview
	@HikerID INT,
	@TrailName VARCHAR(100),
	@Date DATE,
	@Comment VARCHAR(4000),
	@Rating INT

AS
BEGIN
	INSERT INTO tblCOMMENT
	VALUES (@Comment, @Date)

	DECLARE @CommentID INT = (SELECT @@IDENTITY)

	INSERT INTO tblRATING
	VALUES (@Rating)

	DECLARE @RatingID INT = (SELECT @@IDENTITY)

	DECLARE @TrailID INT = 
	(SELECT TrailID FROM tblTRAIL
	WHERE TrailName LIKE @TrailName)

	DECLARE @TrailHikerID INT = 
	(SELECT TrailHikerID FROM tblTRAIL_HIKER
	WHERE TrailID = @TrailID AND HikerID = @HikerID)

	INSERT INTO tblREVIEW
	VALUES (@CommentID, @RatingID, @TrailHikerID)
END
