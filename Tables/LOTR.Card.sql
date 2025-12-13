CREATE TABLE [LOTR].[Card]
(
[CardID] [int] NOT NULL IDENTITY(1, 1),
[PackCD] [int] NULL,
[CardTypeCD] [int] NULL,
[SphereCD] [int] NULL,
[RingsDBCode] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CardName] [varchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CardText] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsUnique] [bit] NULL,
[Quantity] [int] NULL,
[DeckLimit] [int] NULL,
[Illustrator] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Octgnid] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HasErrata] [bit] NULL,
[LocationURL] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ImageSource] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RowVer] [timestamp] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [LOTR].[Card] ADD CONSTRAINT [PK__Card__55FECD8EFE467F81] PRIMARY KEY CLUSTERED ([CardID]) ON [PRIMARY]
GO
ALTER TABLE [LOTR].[Card] ADD CONSTRAINT [FK__Card__CardTypeCD__7F2BE32F] FOREIGN KEY ([CardTypeCD]) REFERENCES [Common].[code] ([CodeID])
GO
ALTER TABLE [LOTR].[Card] ADD CONSTRAINT [FK__Card__PackCD__00200768] FOREIGN KEY ([PackCD]) REFERENCES [Common].[code] ([CodeID])
GO
ALTER TABLE [LOTR].[Card] ADD CONSTRAINT [FK__Card__SphereCD__01142BA1] FOREIGN KEY ([SphereCD]) REFERENCES [Common].[code] ([CodeID])
GO
