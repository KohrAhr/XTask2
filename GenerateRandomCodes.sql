----------

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

----------

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
DROP TABLE #RandomCodes;

DROP PROCEDURE #GenerateRandomCode;