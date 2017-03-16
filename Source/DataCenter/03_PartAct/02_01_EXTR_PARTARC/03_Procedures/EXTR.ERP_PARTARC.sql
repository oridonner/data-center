CREATE PROCEDURE EXTR.ERP_PARTARC
AS
BEGIN
DECLARE @PARTARC AS TABLE	(
								RowChange	VARCHAR(10),
								PART		INT	,
								ACT			INT	,
								SON			INT	,
								COEF		FLOAT
							);
TRUNCATE TABLE TRNS.PARTARC;
INSERT INTO @PARTARC	(
								RowChange,
								PART	,
								ACT		,
								SON		,
								COEF
						)
SELECT	T1.RowChange,
		T1.PART		,
		T1.ACT		,
		T1.SON		,
		T1.COEF
FROM
(
	MERGE EXTR.PARTARC_Target	WITH (HOLDLOCK)												AS Target	--TARGET
	USING 
		(																								--SOURCE
			SELECT	DISTINCT	T1.PART,																--SOURCE
								T1.ACT,																	--SOURCE
								T1.SON,																	--SOURCE
								T1.COEF																	--SOURCE
			FROM [$(PriorityServer)].[$(PriorityDatabase)].dbo.PARTARC	AS T1							--SOURCE
			WHERE T1.SONACT=-3																				--SOURCE
		)																					AS Source	--SOURCE
	ON	(
			Target.PART	= Source.PART	AND
			Target.ACT	= Source.ACT	AND
			Target.SON	= Source.SON	
		)
	WHEN NOT MATCHED BY Target THEN
		INSERT	(
					RowEffectiveDate,
					RowExpiryDate	,
					PART			,
					ACT				,		
					SON				,			
					COEF		
				)
		VALUES	(
					GETDATE()						,
					CAST ('99991231' AS DATETIME)	,
					Source.PART						,	
					Source.ACT						,	
					Source.SON						,		
					Source.COEF						
				)
	WHEN NOT MATCHED BY Source THEN
		UPDATE SET	Target.RowExpiryDate	= GETDATE()
	OUTPUT	$action										,
			COALESCE(INSERTED.PART	, DELETED.PART)		,		
			COALESCE(INSERTED.ACT	, DELETED.ACT)		,		
			COALESCE(INSERTED.SON	, DELETED.SON)		,
			COALESCE(INSERTED.COEF	, DELETED.COEF)		
)	AS T1	(
				RowChange	,
				PART		,
				ACT			,
				SON			,
				COEF	
			);

INSERT INTO TRNS.PARTARC	(
								RowChange	,
								PART		,
								ACT			,
								SON			,
								COEF	
							)
SELECT	T1.RowChange	,
		T1.PART			,
		T1.ACT			,
		T1.SON			,
		T1.COEF
FROM @PARTARC AS T1

END;
GO