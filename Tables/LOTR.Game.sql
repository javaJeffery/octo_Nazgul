CREATE TABLE [LOTR].[Game]
(
[GameID] [int] NOT NULL IDENTITY(1, 1),
[FellowshipID] [int] NULL,
[GameDate] [datetime2] NULL,
[Scenario] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[GameStyleCD] [int] NULL,
[Rounds] [int] NULL,
[Threat] [int] NULL,
[Damage] [int] NULL,
[DeadHeroes] [int] NULL,
[VictoryPoints] [int] NULL,
[IsWin] [bit] NULL,
[Score] [int] NULL,
[Musings] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RowVer] [timestamp] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [LOTR].[Game] ADD CONSTRAINT [PK__Game__2AB897DD0EAC538E] PRIMARY KEY CLUSTERED ([GameID]) ON [PRIMARY]
GO
ALTER TABLE [LOTR].[Game] ADD CONSTRAINT [FK__Game__GameStyleC__1AD3FDA4] FOREIGN KEY ([GameStyleCD]) REFERENCES [Common].[code] ([CodeID])
GO
ALTER TABLE [LOTR].[Game] ADD CONSTRAINT [FK__Game__Fellowship__19DFD96B] FOREIGN KEY ([FellowshipID]) REFERENCES [LOTR].[Fellowship] ([FellowshipID])
GO
