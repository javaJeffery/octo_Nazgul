CREATE TABLE [Common].[Calendar]
(
[RataDieDate] [int] NOT NULL,
[GregorianDate] [date] NULL,
[LilianDate] [int] NULL,
[JulianDate] [decimal] (14, 5) NULL,
[JulianDayNumber] [int] NULL,
[YearDay] [int] NULL,
[YearWeek] [int] NULL,
[IsWeekDay] [bit] NULL,
[IsWeekEnd] [bit] NULL,
[YearFirstMonday] [date] NULL,
[YearLastFriday] [date] NULL,
[MonthFirstMonday] [date] NULL,
[MonthLastFriday] [date] NULL
) ON [PRIMARY]
GO
ALTER TABLE [Common].[Calendar] ADD CONSTRAINT [PK__Calendar__52A928460B9E1B2D] PRIMARY KEY CLUSTERED ([RataDieDate]) ON [PRIMARY]
GO
