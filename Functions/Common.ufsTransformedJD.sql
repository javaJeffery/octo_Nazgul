SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--====================================================================================================================
-- Procedure Name : ufsReducedJD
-- Original Author: J. Kirkland
-- Create Date    : 2025-02-12
-- Description    : Transforms the Julian date into one of the non integer forms described here
--                  https://en.wikipedia.org/wiki/Julian_day
-- Usage          : Declare @GregDate Datetime = GETDATE()
--                  Execute Common.ufsReducedJD(@GregDate)
-- Defaults to    : Current UTC datetime
----------------------------------------------------------------------------------------------------------------------
-- Update History
-- Author               Date        Description
----------------------------------------------------------------------------------------------------------------------
-- J.Kirkland           2025-02-12  Initial Revision.
--====================================================================================================================
CREATE   FUNCTION [Common].[ufsTransformedJD]
    (
        @GregorianDate     DATETIME2 = NULL
    ,   @TransformCodeType VARCHAR(64)
    )
    RETURNS DECIMAL(14, 5)
AS
BEGIN
    DECLARE @JulianDate DECIMAL(14, 5)
    DECLARE @Modifier DECIMAL(10, 1)
    DECLARE @Result DECIMAL(14, 5)
    DECLARE @GregDate DATETIME2 = ISNULL(@GregorianDate, GETUTCDATE())

    SELECT @Modifier = CAST(code AS DECIMAL(10, 1))
      FROM Common.Code
     WHERE SubCategory = @TransformCodeType
       AND Category = 'JulianDateTime'

    SELECT @Result = Common.ufsJulianDateConverter(@GregDate) - @Modifier

    RETURN @Result
END
GO
