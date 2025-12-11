CREATE TABLE [LOTR].[Card]
(
[CardID] [int] NOT NULL IDENTITY(1, 1),
[PackCD] [int] NULL,
[CardTypeCD] [int] NULL,
[SphereCD] [int] NULL,
[RingsDBCode] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CardName] [varchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CardText] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [LOTR].[Card] ADD CONSTRAINT [PK__Card__55FECD8E2E9F0026] PRIMARY KEY CLUSTERED ([CardID]) ON [PRIMARY]
GO
ALTER TABLE [LOTR].[Card] ADD CONSTRAINT [FK__Card__CardTypeCD__5DCAEF64] FOREIGN KEY ([CardTypeCD]) REFERENCES [Common].[code] ([CodeID])
GO
ALTER TABLE [LOTR].[Card] ADD CONSTRAINT [FK__Card__PackCD__5CD6CB2B] FOREIGN KEY ([PackCD]) REFERENCES [Common].[code] ([CodeID])
GO
ALTER TABLE [LOTR].[Card] ADD CONSTRAINT [FK__Card__SphereCD__5EBF139D] FOREIGN KEY ([SphereCD]) REFERENCES [Common].[code] ([CodeID])
GO
