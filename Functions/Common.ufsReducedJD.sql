SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--====================================================================================================================
-- Procedure Name : ufsReducedJD
-- Original Author: J. Kirkland
-- Create Date    : 2025-02-12
-- Description    : Returns the reduced julian date as described here https://en.wikipedia.org/wiki/Julian_day
-- Usage          : Declare @GregDate Datetime = GETDATE()
--                  Execute Common.ufsReducedJD(@GregDate)
-- Defaults to    : Current UTC datetime
----------------------------------------------------------------------------------------------------------------------
-- Update History
-- Author               Date        Description
----------------------------------------------------------------------------------------------------------------------
-- J.Kirkland           2025-02-12  Initial Revision.
--====================================================================================================================
CREATE   FUNCTION [Common].[ufsReducedJD]
    (
        @GregorianDate DATETIME = NULL
    )
    RETURNS DECIMAL(14, 5)
AS
BEGIN
    RETURN Common.ufsJulianDateConverter(ISNULL(@GregorianDate, GETUTCDATE()) - 2400000)
END
GO
