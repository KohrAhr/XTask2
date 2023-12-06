----------

IF OBJECT_ID('tempdb..#GenerateRandomCode', 'P') IS NOT NULL
BEGIN
	-- Drop the temporary stored procedure
	DROP PROCEDURE #GenerateRandomCode;
END;
GO

CREATE PROCEDURE #GenerateRandomCode
	@aValidChars NVARCHAR(50),
	@aPassLength INT,
	@aRandomCode NVARCHAR(6) OUTPUT
AS
BEGIN
	SET @aRandomCode = '';

	WHILE LEN(@aRandomCode) < @aPassLength
	BEGIN
		DECLARE @RandomIndex INT = ROUND(RAND() * (LEN(@aValidChars) - 1) + 1, 0);
		SET @aRandomCode = @aRandomCode + SUBSTRING(@aValidChars, @RandomIndex, 1);
	END
END;
GO

-- MAIN BODY

BEGIN TRY

	DECLARE @CONST_TOTAL_PASSWORD_NEEDED as INT = 10;

	-- Create temp table
	CREATE TABLE #RandomCodes (Code NVARCHAR(6));

	DECLARE @ValidChars as NVARCHAR(34) = 'ABCDEFGHIJKLMNPQRSTUVWXYZ123456789';

	DECLARE @i as INT = 1;

	-- Create a temporary stored procedure


	WHILE @i <= @CONST_TOTAL_PASSWORD_NEEDED
	BEGIN
		DECLARE @RandomCode as NVARCHAR(6) = '';

		-- Execute the temporary stored procedure
		EXEC #GenerateRandomCode @ValidChars, 6, @RandomCode OUTPUT;

		INSERT INTO #RandomCodes (Code) VALUES (@RandomCode);
	
		SET @i = @i + 1;
	END

	-- Display result
	SELECT * FROM #RandomCodes;

	-- Drop temp table
	IF OBJECT_ID('tempdb..#RandomCodes', 'U') IS NOT NULL
	BEGIN
		-- Drop the temporary table
		DROP TABLE #RandomCodes;
	END

	-- Check if the temporary stored procedure exists
	IF OBJECT_ID('tempdb..#GenerateRandomCode', 'P') IS NOT NULL
	BEGIN
		-- Drop the temporary stored procedure
		DROP PROCEDURE #GenerateRandomCode;
	END


END TRY
BEGIN CATCH
    -- Handle the exception
    PRINT 'An error occurred: ' + ERROR_MESSAGE();
END CATCH