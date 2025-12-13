CREATE TABLE [LOTR].[HeroCard]
(
[HeroID] [int] NOT NULL IDENTITY(1, 1),
[CardID] [int] NULL,
[Trait] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Threat] [int] NULL,
[Willpower] [int] NULL,
[Attack] [int] NULL,
[Defense] [int] NULL,
[Health] [int] NULL,
[RowVer] [timestamp] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [LOTR].[HeroCard] ADD CONSTRAINT [PK__HeroCard__33363243C1998377] PRIMARY KEY CLUSTERED ([HeroID]) ON [PRIMARY]
GO
ALTER TABLE [LOTR].[HeroCard] ADD CONSTRAINT [FK__HeroCard__CardID__03F0984C] FOREIGN KEY ([CardID]) REFERENCES [LOTR].[Card] ([CardID])
GO
