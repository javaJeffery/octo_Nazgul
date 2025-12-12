

DECLARE @work TABLE (category VARCHAR(50), subcat VARCHAR(50), code VARCHAR(25), codeDesc VARCHAR(512))
INSERT INTO @work (
    Category
  , SubCat
  , Code
  , CodeDesc
)
VALUES ('Card', 'CardType', 'Hero', 'Hero card')
      ,('Card', 'CardType', 'Ally', 'Ally card')
	  ,('Card', 'CardType', 'Attachment', 'Attachment card')
	  ,('Card', 'CardType', 'Event', 'Event card')
	  ,('Card', 'Pack',	'Core', 'Card belongs to the core set')
	  ,('Card', 'Pack', 'HFG', 'Card belongs the the Hunt for Gollum set')
	  ,('Card', 'Sphere', 'Spirit', 'Spirit Sphere')
	  ,('Card', 'Sphere', 'Leadership', 'Leadership Sphere')
	  ,('Card', 'Sphere', 'Tactics', 'Tactics Sphere')
	  ,('Card', 'Sphere', 'Lore', 'Lore Sphere')

INSERT INTO common.code (Category, SubCategory, Code, CodeDesc)
SELECT b.category, b.subcat, b.code, b.codeDesc
  FROM common.code a right JOIN @work b ON b.category = a.Category
									   AND b.subcat = a.SubCategory
									   AND b.code = a.Code
WHERE a.codeID IS NULL

SELECT * FROM common.code