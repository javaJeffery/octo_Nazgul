CREATE TABLE [LOTR].[HeroCard]
(
[HeroID] [int] NOT NULL IDENTITY(1, 1),
[CardID] [int] NULL,
[Threat] [int] NULL,
[Willpower] [int] NULL,
[Attack] [int] NULL,
[Defense] [int] NULL,
[Health] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [LOTR].[HeroCard] ADD CONSTRAINT [PK__HeroCard__33363243D1962E70] PRIMARY KEY CLUSTERED ([HeroID]) ON [PRIMARY]
GO
ALTER TABLE [LOTR].[HeroCard] ADD CONSTRAINT [FK__HeroCard__CardID__6C190EBB] FOREIGN KEY ([CardID]) REFERENCES [LOTR].[Card] ([CardID])
GO
