SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 --============================================================================
 --
 -- PROCEDURE NAME : Common.upCode
 -- HISTORY
 -----------------------------------------------------------------------------
 -- Date        AUTHOR       DESC
 -----------------------------------------------------------------------------
 -- 2025-DEC-11 J.Kirkland   Initial Revision
 --============================================================================
 CREATE   PROCEDURE [Common].[upiCode](
	-- Add the parameters for the stored procedure here
	@itt_Code Common.uttCode READONLY
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRAN

	 BEGIN TRY
    -- Insert statements for procedure here
		INSERT INTO [Common].[code]
			   ([Category]
			   ,[SubCategory]
			   ,[Code]
			   ,[CodeDesc]
               ,[UpdatedBy]
			   ,[UpdatedOn]
			   ,[IsDeleted])
		SELECT a.Category
			 , a.SubCategory
			 , a.Code
			 , a.CodeDesc
		     , ISNULL(a.UpdatedBy, 'Legolas')
			 , GETUTCDATE()
			 , 0
		  FROM @itt_Code a

		COMMIT TRAN
	 END TRY
	 BEGIN CATCH
		SELECT
			ERROR_NUMBER() AS ErrorNumber,
			ERROR_SEVERITY() AS ErrorSeverity,
			ERROR_STATE() AS ErrorState,
			ERROR_PROCEDURE() AS ErrorProcedure,
			ERROR_LINE() AS ErrorLine,
			ERROR_MESSAGE() AS ErrorMessage;

			ROLLBACK TRAN
	 END CATCH
	
END
GO
