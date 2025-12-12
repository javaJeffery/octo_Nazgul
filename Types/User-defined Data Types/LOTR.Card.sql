CREATE TYPE [LOTR].[Card] AS TABLE
(
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
[ImageSource] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
