-- 1
-- Check that a registered trail has an elevation under 15,000' to ensure safe hiking

ALTER TABLE tblDESCRIPTION
ADD CONSTRAINT safeElevation 
CHECK (Elevation <= 15000)

-- 2
-- Check that a registered hiker is at least 4 years of age

CREATE FUNCTION CheckAge()
RETURNS int
AS 
BEGIN
   DECLARE @retval int
   SELECT @retval = GETDATE() - DateOfBirth FROM tblHIKER
   RETURN @retval
END;
GO
ALTER TABLE tblHIKER
ADD CONSTRAINT minimumAge 
CHECK (dbo.CheckAge() >= 4 );
GO

-- 3
-- Check that a review left is at least 10 characters to ensure it is valid

CREATE FUNCTION CheckComment()
RETURNS int
AS 
BEGIN
   DECLARE @retval int
   SELECT @retval = LEN(CommentBody) FROM tblCOMMENT
   RETURN @retval
END;
GO
ALTER TABLE tblCOMMENT
ADD CONSTRAINT validComment CHECK (dbo.CheckComment() >= 10);
GO

-- 4
-- Check that an entered zip code is 5 numbers and each character contains a number between 0-9

ALTER TABLE tblDESCRIPTION
ADD CONSTRAINT validZipCode
CHECK (TrailZipCode LIKE '[0-9][0-9][0-9][0-9][0-9]')
