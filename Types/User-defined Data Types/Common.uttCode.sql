CREATE TYPE [Common].[uttCode] AS TABLE
(
[Category] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SubCategory] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Code] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CodeDesc] [varchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UpdatedBy] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
