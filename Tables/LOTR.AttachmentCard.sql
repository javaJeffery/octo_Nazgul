CREATE TABLE [LOTR].[AttachmentCard]
(
[AttachmentID] [int] NOT NULL IDENTITY(1, 1),
[CardId] [int] NULL,
[Trait] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Cost] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RowVer] [timestamp] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [LOTR].[AttachmentCard] ADD CONSTRAINT [PK__Attachme__442C64DE3A2FE132] PRIMARY KEY CLUSTERED ([AttachmentID]) ON [PRIMARY]
GO
ALTER TABLE [LOTR].[AttachmentCard] ADD CONSTRAINT [FK__Attachmen__CardI__7D439ABD] FOREIGN KEY ([CardId]) REFERENCES [LOTR].[Card] ([CardID])
GO
