SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--============================================================================
--
--	LOTR.upsGetFromApi
--
--  Perform a get api method call to retrieve data from the RingsDB website
--   www.ringsdb.com
--
------------------------------------------------------------------------------
-- Date			Author		Notes
--============================================================================
-- 12/12/2025	J.Kirkland	Initial Revision
--============================================================================

CREATE   PROCEDURE [LOTR].[upsGetFromApi] (
    @url VARCHAR(128) = 'https://ringsdb.com/api/public/cards/core'
  , @method VARCHAR(16) = 'GET'
  , @response VARCHAR(MAX) OUTPUT
)
AS
BEGIN
    DECLARE @retCode INT;

    EXECUTE @retCode = sp_invoke_external_rest_endpoint
        @url = @url
      , @method = @method
      , @credential = NULL
      , @response = @response OUTPUT;

    IF @retCode <> 0
    BEGIN
        RAISERROR('External REST endpoint call failed with status code %d.', 16, 1, @retCode);
    END;
END;
GO
