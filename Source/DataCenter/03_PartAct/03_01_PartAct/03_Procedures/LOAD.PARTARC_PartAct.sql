CREATE PROCEDURE LOAD.PARTARC_PartAct
AS 
BEGIN
with cte as 
(
	select	T1.PartID			,
			T1.Part				,
			T1.PartType			,
			T1.DateTimeStamp	,
			T1.[Source]
	FROM ENG.PartAct	AS T1
	JOIN TRNS.PARTARC	AS T2 ON T1.PartID=T2.SON
	WHERE T1.PartType='R'
)
MERGE cte														AS Target
USING	(				
			SELECT DISTINCT		T2.PartID	,					--Source
								T2.Part		,					--Source
								T2.PartType						--Source
			FROM TRNS.PARTARC	AS T1
			JOIN ENG.Parts		AS T2 ON T2.PartID=T1.SON
		)														AS Source 
ON	(
		Target.PartID=Source.PartID
	)
WHEN NOT MATCHED BY Target THEN
INSERT	(
			PartID			,
			Part			,
			PartType		,
			DateTimeStamp	,
			[Source]		
		)
VALUES	(
			Source.PartID	,
			Source.Part		,
			Source.PartType	,
			GETDATE()		,
			'PARTARC'
		)

WHEN NOT MATCHED BY Source AND Target.PartType='R' THEN
DELETE;
END;