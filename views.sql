-- 1
-- View the trail with the highest average rating in the database.

CREATE VIEW vwHighestRatedTrail
AS
SELECT TrailName, MAX(Rating) AS HighestRatedTrail
FROM tblTRAIL t
	JOIN tblTRAIL_HIKER th
		ON t.TrailID = th.TrailID
	JOIN tblREVIEW r
		ON th.TrailHikerID = r.TrailHikerID
	JOIN tblRATING ra
		ON r.RatingID = ra.RatingID
GROUP BY TrailName
GO

-- 2
-- View the number of hikers registered in the database in a selected region.

CREATE VIEW vwHikersPerRegion
AS
SELECT RegionName, COUNT(HikerID) AS HikersPerRegion
FROM tblTRAIL t
	JOIN tblTRAIL_HIKER th
		ON t.TrailID = th.TrailID
	JOIN tblHIKER h
		ON th.HikerID = h.HikerID
	JOIN tblREGION r
		ON t.RegionID = r.RegionID
GROUP BY RegionName DESC
GO

-- 3
-- View the trail with the longest distance in the hiker's respective state.

CREATE VIEW vwLongestTrail
AS
SELECT TrailName, MAX(Length) AS LongestTrail
FROM tblTRAIL t
	JOIN tblDESCRIPTION d
		ON t.TrailID = d.TrailID
	JOIN tblTRAIL_HIKER th
		ON t.TrailID = th.TrailID
	JOIN tblHIKER h
		ON th.HikerID = h.HikerID
WHERE h.HikerState = d.TrailState
GROUP BY TrailName 
GO

-- 4
-- View the trail with the highest elevation in the hiker's respective state.

CREATE VIEW vwHighestElevation
AS
SELECT TrailName, MAX(Elevation) AS HighestElevation
FROM tblTRAIL t
	JOIN tblDESCRIPTION d
		ON t.TrailID = d.TrailID
	JOIN tblTRAIL_HIKER th
		ON t.TrailID = th.TrailID
	JOIN tblHIKER h
		ON th.HikerID = h.HikerID
WHERE h.HikerState = d.TrailState
GROUP BY TrailName 
GO
