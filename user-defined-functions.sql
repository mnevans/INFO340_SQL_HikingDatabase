-- 1
-- Returns the total number of user reviews on all trails in the database

CREATE FUNCTION dbo.ufnNumberOfReviews(@ReviewID int)
RETURNS int

AS 
BEGIN
DECLARE @ret int;
SELECT @ret = SUM(r.ReviewID)
FROM Happy_Trails.tblREVIEW r
	JOIN tblTRAIL_HIKER th
		ON r.TrailHikerID = th.TrailHikerID
	JOIN tblHIKER h
		ON th.HikerID = h.HikerID
WHERE r.ReviewID = @ReviewID

IF (@ret IS NULL)
SET @ret = 0;

RETURN @ret;
END;
GO

SELECT HikerFName, HikerLName, dbo.ufnNumberOfReviews(ReviewID) AS TotalReviews
FROM Trails.tblREVIEW

-- 2
-- Returns the number of experienced hikers in the database

CREATE FUNCTION dbo.ufnExperiencedHikers(@ExperienceID int)
RETURNS int

AS 
BEGIN
DECLARE @ret int;
SELECT @ret = COUNT(r.ReviewID)
FROM Happy_Trails.tblHIKER h
	JOIN tblHIKER_TYPE ht
		ON h.HikerTypeID = ht.HikerTypeID
	JOIN tblEXPERIENCE e
		ON ht.ExperienceID = e.ExperienceID
WHERE e.ExperienceName like '%experienced'
WHERE e.ExperienceD = @ExperienceID

IF (@ret IS NULL)
SET @ret = 0;

RETURN @ret;
END;
GO

SELECT HikerFName, HikerLName, dbo.ufnExperiencedHikers(ExperienceID) AS ExperiencedHikers
FROM Happy_Trails.tblHIKER

-- 3
-- Returns the number of registered trails per state

CREATE FUNCTION dbo.ufnAssociationsPerState(@AssociationID int)
RETURNS int

AS 
BEGIN
DECLARE @ret int;
SELECT @ret = COUNT(a.AssociationID)
FROM Happy_Trails.tblASSOCIATION a
	JOIN tblASSOCIATION_TRAIL at
		ON a.AssociationID = at.AssociationID
	JOIN tblTRAIL t
		ON at.TrailID = t.TrailID
	JOIN tblDESCRIPTION d
		ON t.TrailID = d.TrailID
WHERE a.AssociationState = d.TrailState
WHERE a.AssociationID = @AssociationID

IF (@ret IS NULL)
SET @ret = 0;

RETURN @ret;
END;
GO

SELECT AssociationName, dbo.ufnAssociationsPerState(AssociationID) AS NumberOfAssociations
FROM Happy_Trails.tblASSOCIATION

-- 4
-- Returns the number of registered attractions per each registered trail

CREATE FUNCTION dbo.ufnAttractionsPerTrail(@AssociationID int)
RETURNS int

AS 
BEGIN
DECLARE @ret int;
SELECT @ret = COUNT(a.AttractionID)
FROM Happy_Trails.tblATTRACTION a
	JOIN tblDESCRIPTION_ATTRACTION da
		ON a.AttractionID = da.AttractionID
	JOIN tblDESCRIPTION d
		ON da.DescriptionID = d.DescriptionID
	JOIN tblTRAIL t
		ON d.TrailID = t.TrailID
WHERE a.AttractionID = @AttractionID

IF (@ret IS NULL)
SET @ret = 0;

RETURN @ret;
END;
GO

SELECT TrailName, dbo.ufnAttractionsPerTrail(AttractionID) AS NumberOfAttractions
FROM Happy_Trails.tblTRAIL
