CREATE TABLE [LOTR].[AllyCard]
(
[AllyID] [int] NOT NULL IDENTITY(1, 1),
[CardID] [int] NULL,
[Traits] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Cost] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Willpower] [int] NULL,
[Attack] [int] NULL,
[Defense] [int] NULL,
[Health] [int] NULL,
[RowVer] [timestamp] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [LOTR].[AllyCard] ADD CONSTRAINT [PK__AllyCard__50F84B4FC1E64DCB] PRIMARY KEY CLUSTERED ([AllyID]) ON [PRIMARY]
GO
ALTER TABLE [LOTR].[AllyCard] ADD CONSTRAINT [FK__AllyCard__CardID__7A672E12] FOREIGN KEY ([CardID]) REFERENCES [LOTR].[Card] ([CardID])
GO
