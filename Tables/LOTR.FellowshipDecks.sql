CREATE TABLE [LOTR].[FellowshipDecks]
(
[FellowshipDeckID] [int] NOT NULL IDENTITY(1, 1),
[DeckID] [int] NULL,
[RowVer] [timestamp] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [LOTR].[FellowshipDecks] ADD CONSTRAINT [PK__Fellowsh__38F248095859C631] PRIMARY KEY CLUSTERED ([FellowshipDeckID]) ON [PRIMARY]
GO
ALTER TABLE [LOTR].[FellowshipDecks] ADD CONSTRAINT [FK__Fellowshi__DeckI__0F624AF8] FOREIGN KEY ([DeckID]) REFERENCES [LOTR].[Deck] ([DeckID])
GO
