DECLARE @CONST_TOTAL_PASSWORD_NEEDED as INT = 10;

-- Create temp table
CREATE TABLE #RandomCodes (Code NVARCHAR(6));

DECLARE @ValidChars as NVARCHAR(34) = 'ABCDEFGHIJKLMNPQRSTUVWXYZ123456789';

DECLARE @i as INT = 1;

WHILE @i <= @CONST_TOTAL_PASSWORD_NEEDED
BEGIN
	DECLARE @RandomCode as NVARCHAR(6) = '';

	WHILE LEN(@RandomCode) < 6
	BEGIN
		DECLARE @RandomIndex INT = ROUND(RAND() * (LEN(@ValidChars) - 1) + 1, 0);
		SET @RandomCode = @RandomCode + SUBSTRING(@ValidChars, @RandomIndex, 1);
	END

	INSERT INTO #RandomCodes (Code) VALUES (@RandomCode);

	SET @i = @i + 1;
END

-- Display result
SELECT * FROM #RandomCodes;

-- Drop temp table
DROP TABLE #RandomCodes;