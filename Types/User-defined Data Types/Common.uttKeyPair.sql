CREATE TYPE [Common].[uttKeyPair] AS TABLE
(
[KeyName] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[KeyValue] [varchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
PRIMARY KEY CLUSTERED ([KeyName])
)
GO
