SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--============================================================================
--
--	lotr.upGetDeckListFromRingsDb
--
--  Get the decklist of a given deck number from rings db using the api
--
--
------------------------------------------------------------------------------
--
--============================================================================
-- 12/13/2025	J.Kirkland	Initial Revision
--============================================================================
CREATE   PROCEDURE [LOTR].[upGetDeckListFromRingsDb] (@RingsDBDeckID VARCHAR(10))
AS
BEGIN

    DECLARE @response VARCHAR(MAX);

    DECLARE @deckId INT;

    DECLARE
        @rp              NVARCHAR(MAX)
      , @rs              NVARCHAR(MAX)
      , @id              VARCHAR(10)
      , @deckName        VARCHAR(50)
      , @createdOn       VARCHAR(25)
      , @UpdatedOn       VARCHAR(25)
      , @DeckDescription VARCHAR(MAX)
      , @UserID          VARCHAR(10)
      , @Heroes          NVARCHAR(MAX)
      , @Slots           NVARCHAR(MAX)
      , @SideSlots       NVARCHAR(MAX)
      , @DeckVersion     VARCHAR(10)
      , @LastPack        VARCHAR(100)
      , @FreezeComments  VARCHAR(25)
      , @IsPublished     BIT
      , @NumVotes        INT
      , @NumFavorites    INT
      , @NumComments     INT
      , @StartingThreat  INT;

    EXEC LOTR.upGetDeckInfo
        @RingsDBDeckID = @RingsDBDeckID            -- varchar(10)
      , @rp = @rp OUTPUT                           -- nvarchar(max)
      , @rs = @rs OUTPUT                           -- nvarchar(max)
      , @id = @id OUTPUT                           -- varchar(10)
      , @deckName = @deckName OUTPUT               -- varchar(50)
      , @createdOn = @createdOn OUTPUT             -- varchar(25)
      , @UpdatedOn = @UpdatedOn OUTPUT             -- varchar(25)
      , @DeckDescription = @DeckDescription OUTPUT -- varchar(max)
      , @UserID = @UserID OUTPUT                   -- varchar(10)
      , @Heroes = @Heroes OUTPUT                   -- nvarchar(max)
      , @Slots = @Slots OUTPUT                     -- nvarchar(max)
      , @SideSlots = @SideSlots OUTPUT             -- nvarchar(max)
      , @DeckVersion = @DeckVersion OUTPUT         -- varchar(10)
      , @LastPack = @LastPack OUTPUT               -- varchar(100)
      , @FreezeComments = @FreezeComments OUTPUT   -- varchar(25)
      , @IsPublished = @IsPublished OUTPUT         -- bit
      , @NumVotes = @NumVotes OUTPUT               -- int
      , @NumFavorites = @NumFavorites OUTPUT       -- int
      , @NumComments = @NumComments OUTPUT         -- int
      , @StartingThreat = @StartingThreat OUTPUT;  -- int


    INSERT INTO
        LOTR.Deck (
        RingsDB_DeckID
      , DeckName
      , CreatedOn
      , UpdatedOn
      , DeckDescription
      , VersionNumber
      , StartingThreat
    )
    VALUES (TRY_CAST(@RingsDBDeckID AS INT), @deckName, TRY_CAST(LEFT(REPLACE(@createdOn, 'T', ' '), 19) AS DATETIME)
          , TRY_CAST(LEFT(REPLACE(@UpdatedOn, 'T', ' '), 19) AS DATETIME), @DeckDescription, @DeckVersion
          , @StartingThreat);

    SELECT @deckId = @@IDENTITY;


    INSERT INTO
        LOTR.DeckHeroes (
        DeckID
      , CardID
    )
    SELECT
        @deckId
      , b.CardID
      FROM
        LOTR.uftSplitRingsDBCardArray(@Heroes) a
          INNER JOIN LOTR.Card                 b
                  ON b.RingsDBCode = a.RingsCardID;

    INSERT INTO
        LOTR.DeckCards (
        DeckID
      , CardID
      , quantity
    )
    SELECT
        @deckId
      , b.CardID
      , a.quantity
      FROM
        LOTR.uftSplitRingsDBCardArray(@Slots) a
          INNER JOIN LOTR.Card                b
                  ON b.RingsDBCode = a.RingsCardID
          INNER JOIN Common.code              x
                  ON x.CodeID = b.CardTypeCD
     WHERE
        x.Code <> 'Hero';

    INSERT INTO
        LOTR.DeckSideboard (
        DeckID
      , CardID
    )
    SELECT
        @deckId
      , b.CardID
      FROM
        LOTR.uftSplitRingsDBCardArray(@SideSlots) a
          INNER JOIN LOTR.Card                    b
                  ON b.RingsDBCode = a.RingsCardID;

    --SELECT * FROM LOTR.Deck;
    --SELECT * FROM LOTR.DeckCards;
    --SELECT * FROM LOTR.DeckHeroes;
    --SELECT * FROM LOTR.DeckSideboard;

END;
GO
