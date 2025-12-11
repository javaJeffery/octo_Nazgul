SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		J.Kirkland
-- Create date: 2025-02-12
-- Description:	Numbers table
-- =============================================
CREATE FUNCTION [utl].[Numbers](@n int)
RETURNS @ResultSet table (SomeNumber int)
AS
BEGIN
	;WITH
	  L0   AS (SELECT 1 AS n UNION ALL SELECT 1),              -- 2 rows
	  L1   AS (SELECT 1 AS n FROM L0 AS a CROSS JOIN L0 AS b), -- 4 rows (2 x 2)
	  L2   AS (SELECT 1 AS n FROM L1 AS a CROSS JOIN L1 AS b), -- 16 rows (4 x 4)
	  L3   AS (SELECT 1 AS n FROM L2 AS a CROSS JOIN L2 AS b), -- 256 rows (16 x 16)
	  L4   AS (SELECT 1 AS n FROM L3 AS a CROSS JOIN L3 AS b), -- 65 536 rows (256 x 256)
	  L5   AS (SELECT 1 AS n FROM L4 AS a CROSS JOIN L4 AS b), -- 4 294 967 296 rows (65 536 x 65 536)
	  Nums AS (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n FROM L5)
	
	INSERT INTO @ResultSet(SomeNumber)
	SELECT top (@n) n
	  FROM nums

	RETURN
END
GO
