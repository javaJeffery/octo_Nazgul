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
ALTER TABLE [Common].[code] ADD CONSTRAINT [PK__code__C6DE2C35126ECE20] PRIMARY KEY CLUSTERED ([CodeID]) ON [PRIMARY]
GO
