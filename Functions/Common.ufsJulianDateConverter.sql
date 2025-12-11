SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		J. Kirkland
-- Create date: 2025-02-09
-- Description:	Convert Gregorian Date to Julian Date 
--				Formula for conversion
--See: https://en.wikipedia.org/wiki/Julian_day
-- =============================================
CREATE   FUNCTION [Common].[ufsJulianDateConverter] 
(
	-- Add the parameters for the function here
	@GregorianDate Datetime2
)
RETURNS DECIMAL(14,5)
AS
BEGIN
	--DECLARE @GregorianDate Datetime = GETUTCDATE()
	-- Declare the variables here
	
	DECLARE @Year INT
	DECLARE @Month INT
	DECLARE @Day INT
	DECLARE @Hour INT
	DECLARE @Minute INT
	DECLARE @Second INT
	DECLARE @JDN INT
	DECLARE @JD Decimal (14, 5)
	DECLARE @p1 int, @p2 int, @p3 int, @p4 int, @p5 int
	DECLARE @p6 Decimal (9, 5), @p7 Decimal (9, 5), @p8 Decimal (9, 5)

	-- Add the T-SQL statements to compute the return value here
	SET @Year =   DATEPART(YEAR, @GregorianDate)
	SET @Month =  DATEPART(MONTH, @GregorianDate)
	SET @Day =    DATEPART(DAY, @GregorianDate)
	SET @Hour =   DATEPART(HOUR, @GregorianDate)
	SET @Minute = DATEPART(MINUTE, @GregorianDate)
	SET @Second = DATEPART(SECOND, @GregorianDate)

	--Calculate Julian Day Number
	SELECT @p5 = FLOOR((@Month - 14) / 12)
	SELECT @p1 = FLOOR((1461 * (@Year + 4800 + @p5)) / 4)
	SELECT @p2 = FLOOR((367 * (@Month - 2 - 12 * @p5)) / 12)
	SELECT @p3 = FLOOR((3 * (FLOOR((@Year + 4900 + @p5) / 100))) / 4)
	SELECT @p4 = @Day - 32075
	SELECT @JDN = @p1 + @p2 - @p3 + @p4

	--Calculate Julian Date
	SELECT @p6 = (@Hour - 12.0) / 24.0
	SELECT @p7 = @Minute / 1440.0
	SELECT @p8 = @Second / 86400.0
	SELECT @JD = @JDN + @p6 + @p7 + @p8

	
	--Return the result of the function
	RETURN @JD

END
GO
