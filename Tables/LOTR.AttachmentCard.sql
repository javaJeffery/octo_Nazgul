CREATE TABLE [LOTR].[AttachmentCard]
(
[AttachmentID] [int] NOT NULL IDENTITY(1, 1),
[CardId] [int] NULL,
[Cost] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [LOTR].[AttachmentCard] ADD CONSTRAINT [PK__Attachme__442C64DEDCBB96BD] PRIMARY KEY CLUSTERED ([AttachmentID]) ON [PRIMARY]
GO
ALTER TABLE [LOTR].[AttachmentCard] ADD CONSTRAINT [FK__Attachmen__CardI__6EF57B66] FOREIGN KEY ([CardId]) REFERENCES [LOTR].[Card] ([CardID])
GO
