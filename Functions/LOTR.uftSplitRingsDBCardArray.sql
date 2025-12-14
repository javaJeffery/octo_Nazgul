SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		J.Kirkland
-- Create date: 2025-12-13
-- Description:	parse RingsDB card array
-- =============================================
CREATE   FUNCTION [LOTR].[uftSplitRingsDBCardArray]
(	
	-- Add the parameters for the function here
	@CardJsonArray NVARCHAR(MAX)
)
RETURNS TABLE 
AS
RETURN 
(
		SELECT PTable.CardInfo, REPLACE(PTable.[1], '"', '') AS RingsCardID, PTable.[2] AS quantity
		  FROM (
				SELECT TRIM(TRANSLATE(b.value, '{}', '  ')) CardInfo
				  FROM STRING_SPLIT(@CardJsonArray, ',') b
				) x CROSS APPLY STRING_SPLIT(x.CardInfo, ':', 1) y
		  PIVOT (MAX(value) FOR ordinal IN ([1],[2])
		  ) AS PTable
)
GO
