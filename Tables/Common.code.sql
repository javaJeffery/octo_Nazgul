CREATE TABLE [Common].[code]
(
[CodeID] [int] NOT NULL IDENTITY(1, 1),
[Category] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SubCategory] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Code] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CodeDesc] [varchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UpdatedBy] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UpdatedOn] [datetime2] NULL,
[IsDeleted] [bit] NULL,
[Ver] [timestamp] NOT NULL
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		J. Kirkland
-- Create date: 2025-02-11
-- Description:	Delete Trigger for Common.code
-- =============================================
CREATE   TRIGGER [Common].[trdCode] 
   ON  [Common].[code] 
   INSTEAD OF DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	IF EXISTS(SELECT c.CodeID 
	            FROM Common.Code c INNER JOIN Deleted d on c.codeID = d.CodeID
			   WHERE c.IsDeleted = 1)
	BEGIN
		DELETE c
		  FROM Common.code c inner join deleted d on c.codeID = d.CodeID
	END ELSE BEGIN
    -- Insert statements for trigger here
	UPDATE cd
	   SET IsDeleted  = 1
	  FROM Common.Code cd inner join DELETED d on cd.codeID = d.codeID
	END
END
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		J. Kirkland
-- Create date: 2025-02-11
-- Description:	Insert trigger for code
-- =============================================
CREATE   TRIGGER [Common].[triCode] 
   ON  [Common].[code] 
   INSTEAD OF INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	INSERT INTO Common.Code (Category
							,SubCategory
							,Code
							,CodeDesc
							,UpdatedBy
							,UpdatedOn
							,IsDeleted)
	SELECT i.Category
		 , i.SubCategory
		 , i.Code
		 , i.CodeDesc
		 , ISNULL(i.UpdatedBy, 'Gandolf')
		 , GETUTCDATE()
		 , 0
	  FROM inserted i
END
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--====================================================================================================================
-- Procedure Name : truCode
-- Original Author: J.Kirkland
-- Create Date    : 2025-12-11
-- Description    : Update trigger on code table
-- Usage          : N/A
----------------------------------------------------------------------------------------------------------------------
-- Update History
-- Author               Date        Description
----------------------------------------------------------------------------------------------------------------------
-- J.Kirkland           2025-12-11  Initial Revision.
--====================================================================================================================
CREATE   TRIGGER [Common].[truCode]
    ON [Common].[code]
    INSTEAD OF UPDATE
    AS
BEGIN
    UPDATE c
       SET c.Category        = u.Category
         , c.code            = u.Code
		 , c.SubCategory	 = u.SubCategory
         , c.CodeDesc		 = u.CodeDesc
         , c.UpdatedBy       = ISNULL(u.UpdatedBy, 'Ufthak')
         , c.UpdatedOn       = GETUTCDATE()
		 , c.IsDeleted		 = u.IsDeleted
      FROM Common.Code c
               INNER JOIN inserted u ON c.CodeID = u.CodeID

END
GO
ALTER TABLE [Common].[code] ADD CONSTRAINT [PK__code__C6DE2C35126ECE20] PRIMARY KEY CLUSTERED ([CodeID]) ON [PRIMARY]
GO
