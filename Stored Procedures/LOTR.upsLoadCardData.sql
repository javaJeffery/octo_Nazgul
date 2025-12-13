SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--============================================================================
--
--	LOTR.upsLoadCardData
--
--  Load the card data into the tables
--
--
------------------------------------------------------------------------------
-- Date			Author		Notes
--============================================================================
-- 12/12/2025	J.Kirkland	Initial Revision
--============================================================================
CREATE   PROCEDURE [LOTR].[upsLoadCardData] (
    @set VARCHAR(16)
)
AS
BEGIN
    DECLARE @CardData LOTR.uttLOTR_Card_API_Response;
    DECLARE @URL VARCHAR(128) = 'https://ringsdb.com/api/public/cards/';
    DECLARE @response VARCHAR(MAX);

    SET @URL += @Set;

    EXECUTE LOTR.upsGetFromApi @url = @URL, @response = @response OUTPUT;

    INSERT INTO
        @CardData
    SELECT
        Response
      , Result
      , packCode
      , packName
      , typeCode
      , typeName
      , sphereCode
      , sphereName
      , position
      , code
      , cardName
      , traits
      , cardText
      , flavor
      , isUnique
      , cost
      , threat
      , willpower
      , attack
      , defense
      , health
      , quantity
      , deckLimit
      , illustrator
      , octgnid
      , hasErrata
      , locationURL
      , imageSource
      FROM
        OPENJSON(@response)
        WITH (
            Response NVARCHAR(MAX) '$.response' AS JSON
          , Result NVARCHAR(MAX) '$.result' AS JSON
        )
          CROSS APPLY OPENJSON(Result)
                      WITH (
                          packCode VARCHAR(25) '$.pack_code'
                        , packName VARCHAR(25) '$.pack_name'
                        , typeCode VARCHAR(10) '$.type_code'
                        , typeName VARCHAR(10) '$.type_name'
                        , sphereCode VARCHAR(16) '$.sphere_code'
                        , sphereName VARCHAR(16) '$.sphere_name'
                        , position INT '$.position'
                        , code VARCHAR(6) '$.code'
                        , cardName VARCHAR(32) '$.name'
                        , traits VARCHAR(128) '$.traits'
                        , cardText VARCHAR(512) '$.text'
                        , flavor VARCHAR(512) '$.flavor'
                        , isUnique BIT '$.is_unique'
                        , cost VARCHAR(5) '$.cost'
                        , threat INT '$.threat'
                        , willpower INT '$.willpower'
                        , attack INT '$.attack'
                        , defense INT '$.defense'
                        , health INT '$.health'
                        , quantity INT '$.quantity'
                        , deckLimit INT '$.deck_limit'
                        , illustrator VARCHAR(32) '$.illustrator'
                        , octgnid VARCHAR(40) '$.octgnid'
                        , hasErrata BIT '$.has_errata'
                        , locationURL VARCHAR(128) '$.url'
                        , imageSource VARCHAR(128) '$.imagesrc'
                      );
    BEGIN TRAN;
    INSERT INTO
        LOTR.Card (
        PackCD
      , CardTypeCD
      , SphereCD
      , RingsDBCode
      , CardName
      , CardText
      , IsUnique
      , Quantity
      , DeckLimit
      , Illustrator
      , Octgnid
      , HasErrata
      , LocationURL
      , ImageSource
    )
    SELECT
        x.CodeID
      , y.CodeID
      , z.CodeID
      , a.code
      , a.cardName
      , a.cardText
      , a.isUnique
      , a.quantity
      , a.deckLimit
      , a.illustrator
      , a.octgnid
      , a.hasErrata
      , a.locationURL
      , a.imageSource
      FROM
        @CardData                a
          INNER JOIN Common.code x
                  ON x.Code = a.packCode
          INNER JOIN Common.code y
                  ON y.Code = a.typeCode
          INNER JOIN Common.code z
                  ON z.Code = a.sphereCode;
    COMMIT TRAN;

    BEGIN TRAN;

    INSERT INTO
        LOTR.HeroCard (
        CardID
      , trait
      , Threat
      , Willpower
      , Attack
      , Defense
      , Health
    )
    SELECT
        b.CardID
      , a.traits
      , a.threat
      , a.willpower
      , a.attack
      , a.defense
      , a.health
      FROM
        @CardData              a
          INNER JOIN LOTR.Card b
                  ON a.code = b.RingsDBCode
     WHERE
        a.typeCode = 'Hero';
    COMMIT TRAN;

    BEGIN TRAN;

    INSERT INTO
        LOTR.AllyCard (
        CardID
      , Traits
      , Cost
      , Willpower
      , Attack
      , Defense
      , Health
    )
    SELECT
        b.CardID
      , a.traits
      , a.Cost
      , a.willpower
      , a.attack
      , a.defense
      , a.health
      FROM
        @CardData              a
          INNER JOIN LOTR.Card b
                  ON a.code = b.RingsDBCode
     WHERE
        a.typeCode = 'Ally';

    COMMIT TRAN;

    BEGIN TRAN;

    INSERT INTO
        LOTR.AttachmentCard (
        CardId
      , Trait
      , Cost
    )
    SELECT
        b.CardID
      , a.traits
      , a.Cost
      FROM
        @CardData              a
          INNER JOIN LOTR.Card b
                  ON a.code = b.RingsDBCode
     WHERE
        a.typeCode = 'Attachment';

    COMMIT TRAN;

    BEGIN TRAN;

    INSERT INTO
        LOTR.EventCard (
        CardId
      , Cost
    )
    SELECT
        b.CardID
      , a.Cost
      FROM
        @CardData              a
          INNER JOIN LOTR.Card b
                  ON a.code = b.RingsDBCode
     WHERE
        a.typeCode = 'Event';

    COMMIT TRAN;

END;
GO
