CREATE TRIGGER TRNS.PARTARC_AfterInsertTrigger ON TRNS.PARTARC
--
AFTER INSERT
AS 
BEGIN
	--Insert into TRNS.PartActAssembly TRNS.PARTARC inserted rows - will fire the trigger to update ENG.PartAct
	INSERT INTO TRNS.PartActAssembly	(
											PartActID	,
											AssemblyPartID
										)
	SELECT	T2.PartActID	,
			T1.SON
	FROM TRNS.PARTARC	AS T1
	JOIN ENG.PartAct	AS T2 ON T2.PartID=T1.PART AND T2.ActID=T1.ACT
	WHERE T1.RowChange='INSERT';

	--Delete from TRNS.PartActAssembly TRNS.PARTARC deleted rows - will fire the trigger to update ENG.PartAct
	WITH cte 
	AS
	(
		SELECT	T1.PART		,
				T1.ACT		,
				T1.SON		,
				T2.PartActID
		FROM TRNS.PARTARC	AS T1
		JOIN ENG.PartAct	AS T2 ON  T2.PartID=T1.PART AND T2.ActID=T1.ACT
		WHERE T1.RowChange='UPDATE'
	)
	DELETE T3
	FROM cte 
	JOIN TRNS.PartActAssembly	AS T3 ON T3.PartActID=cte.PartActID AND T3.AssemblyPartID=cte.SON;

	--Merge assembly parts into PartAct
	EXEC LOAD.PARTARC_PartAct;
	
END;
GO