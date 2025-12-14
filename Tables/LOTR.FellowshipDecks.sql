CREATE TABLE [LOTR].[FellowshipDecks]
(
[FellowshipDeckID] [int] NOT NULL IDENTITY(1, 1),
[FellowshipID] [int] NULL,
[DeckID] [int] NULL,
[RowVer] [timestamp] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [LOTR].[FellowshipDecks] ADD CONSTRAINT [FK__Fellowshi__DeckI__2B0A656D] FOREIGN KEY ([DeckID]) REFERENCES [LOTR].[Deck] ([DeckID])
GO
ALTER TABLE [LOTR].[FellowshipDecks] ADD CONSTRAINT [FK__Fellowshi__Fello__2A164134] FOREIGN KEY ([FellowshipID]) REFERENCES [LOTR].[Fellowship] ([FellowshipID])
GO
