CREATE PROCEDURE LOAD.PARTARC_PartAct
AS 
BEGIN
MERGE ENG.PartAct	AS Target
USING	(
			SELECT DISTINCT		T2.PartID	,
								T2.Part		,
								T2.PartType
			FROM TRNS.PARTARC	AS T1
			JOIN ENG.Parts		AS T2 ON T2.PartID=T1.SON
		)			AS Source 
ON	(
		Target.PartID=Source.PartID
	)
WHEN NOT MATCHED BY Target THEN
INSERT	(
			PartID	,
			Part	,
			PartType
		)
VALUES	(
			Source.PartID	,
			Source.Part		,
			Source.PartType
		)

WHEN NOT MATCHED BY Source AND Target.PartType='R' THEN
DELETE;
END;