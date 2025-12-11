CREATE TYPE [Common].[uttCode] AS TABLE
(
[Category] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CodeType] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Code] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CodeDescription] [varchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UpdatedBy] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
