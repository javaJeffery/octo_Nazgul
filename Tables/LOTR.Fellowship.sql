CREATE TABLE [LOTR].[Fellowship]
(
[FellowshipID] [int] NOT NULL IDENTITY(1, 1),
[FellowshipName] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RowVer] [timestamp] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [LOTR].[Fellowship] ADD CONSTRAINT [PK__Fellowsh__7AE368ECE7F2D918] PRIMARY KEY CLUSTERED ([FellowshipID]) ON [PRIMARY]
GO
