SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--============================================================================
--
--	LOTR.upGetDeckInfo
--
--  Get deck info from ringsdb
--
--
------------------------------------------------------------------------------
--
--============================================================================
-- 12/13/2025	J.Kirkland	Initial Revision
--============================================================================
CREATE   PROCEDURE [LOTR].[upGetDeckInfo] (
    @RingsDBDeckID VARCHAR(10)
  , @rp NVARCHAR(MAX) OUTPUT
  , @rs NVARCHAR(MAX) OUTPUT
  , @id VARCHAR(10) OUTPUT
  , @deckName VARCHAR(50) OUTPUT
  , @createdOn VARCHAR(25) OUTPUT
  , @UpdatedOn VARCHAR(25) OUTPUT
  , @DeckDescription VARCHAR(MAX) OUTPUT
  , @UserID VARCHAR(10) OUTPUT
  , @Heroes NVARCHAR(MAX) OUTPUT
  , @Slots NVARCHAR(MAX) OUTPUT
  , @SideSlots NVARCHAR(MAX) OUTPUT
  , @DeckVersion VARCHAR(10) OUTPUT
  , @LastPack VARCHAR(100) OUTPUT
  , @FreezeComments VARCHAR(25) OUTPUT
  , @IsPublished BIT OUTPUT
  , @NumVotes INT OUTPUT
  , @NumFavorites INT OUTPUT
  , @NumComments INT OUTPUT
  , @StartingThreat INT OUTPUT
)
AS
BEGIN

    DECLARE @URL VARCHAR(128) = 'https://ringsdb.com/api/public/decklist/';
    DECLARE @response VARCHAR(MAX);

    SET @URL += @RingsDBDeckID;

    EXECUTE LOTR.upsGetFromApi @url = @URL, @response = @response OUTPUT;

    SELECT
        @rp              = Response
      , @rs              = Result
      , @id              = ID
      , @deckName        = DeckName
      , @createdOn       = CreatedOn
      , @UpdatedOn       = UpdatedOn
      , @DeckDescription = DeckDescription
      , @UserID          = UserID
      , @Heroes          = Heroes
      , @Slots           = Slots
      , @SideSlots       = SideSlots
      , @DeckVersion     = DeckVersion
      , @LastPack        = LastPack
      , @FreezeComments  = FreezeComments
      , @IsPublished     = IsPublished
      , @NumVotes        = NumVotes
      , @NumFavorites    = NumFavorites
      , @NumComments     = NumComments
      , @StartingThreat  = StartingThreat
      FROM
        OPENJSON(@response)
        WITH (
            Response NVARCHAR(MAX) '$.response' AS JSON
          , Result NVARCHAR(MAX) '$.result' AS JSON
        )
          CROSS APPLY OPENJSON(Result)
                      WITH (
                          ID VARCHAR(10) '$.id'
                        , DeckName VARCHAR(50) '$.name'
                        , CreatedOn VARCHAR(25) '$.date_creation'
                        , UpdatedOn VARCHAR(25) '$.date_update'
                        , DeckDescription VARCHAR(MAX) '$.description_md'
                        , UserID VARCHAR(10) '$.user_id'
                        , Heroes NVARCHAR(MAX) '$.heroes' AS JSON
                        , Slots NVARCHAR(MAX) '$.slots' AS JSON
                        , SideSlots NVARCHAR(MAX) '$.sideslots' AS JSON
                        , DeckVersion VARCHAR(10) '$.version'
                        , LastPack VARCHAR(100) '$.last_pack'
                        , FreezeComments VARCHAR(25) '$.freeze_comments'
                        , IsPublished BIT '$.is_published'
                        , NumVotes INT '$.nb_votes'
                        , NumFavorites INT '$.nb_favorites'
                        , NumComments INT '$.nb_comments'
                        , StartingThreat INT '$.starting_threat'
                      );

END;
GO
