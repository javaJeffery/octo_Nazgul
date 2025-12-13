CREATE TABLE [LOTR].[Deck]
(
[DeckID] [int] NOT NULL IDENTITY(1, 1),
[RingsDB_DeckID] [int] NULL,
[DeckName] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedOn] [datetime] NULL,
[UpdatedOn] [datetime] NULL,
[DeckDescription] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VersionNumber] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StartingThreat] [int] NULL,
[RowVer] [timestamp] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [LOTR].[Deck] ADD CONSTRAINT [PK__Deck__76B5444CC3834E14] PRIMARY KEY CLUSTERED ([DeckID]) ON [PRIMARY]
GO
