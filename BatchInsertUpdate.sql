-- Data proceed
BEGIN TRY
	-- INSERT data into Destination table and update Source table with row-level locking
	BEGIN TRANSACTION;
		DECLARE @CONST_MAGIC_NUMBER as int = 1000;

		DECLARE @InsertedData TABLE 
		(
			ID INT
		);

		INSERT INTO 
			DestinationTable (ID, TypeCode, TypeName)
		OUTPUT 
			Inserted.ID INTO @InsertedData (ID)
		SELECT
			ID + @CONST_MAGIC_NUMBER,
			TypeCode,
			TypeName + N' [Copy to Destination]'
		FROM 
			SourceTable
		WITH (UPDLOCK);

		-- Update SourceTable with the current date for the processed records
		UPDATE 
			SourceTable
		SET 
			ProcessedDateTime = GETDATE()
		WHERE 
			(ID IN 
				(SELECT ID - @CONST_MAGIC_NUMBER FROM @InsertedData)
			);

	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	IF (@@TRANCOUNT > 0)         
		ROLLBACK TRANSACTION

	DECLARE @error nvarchar(1024)
	SET @error = N'ERROR: ' + ERROR_MESSAGE() + N' -- BatchInsertUpdate.sql'
	RAISERROR (@error, 11, 1)
END CATCH

