CREATE VIEW ENG.PartActHierarchy
AS
SELECT	--T1.PartActBinPath	,
		--T1.PartActBinRoot	,
		T3.PartActID	AS RootPartActID		,
		T1.PartActID		,
		T2.PartID			,
		T2.Part				,
		T2.PartType			,
		T4.ActID			,
		T4.Act				,
		T2.WorkCenterID		,
		T2.WorkCenter		,
		T1.PartActBinPath	,
		T1.PartActBinPath.ToString() AS PartActPath,
		T1.PartActBinPath.GetLevel() AS PartActLevel
FROM TRNS.PartActHierarchy	AS T1
JOIN ENG.PartAct			AS T2 ON T1.PartActID=T2.PartActID
JOIN ENG.PartAct			AS T3 ON T3.PartActBin=T1.PartActBinRoot
OUTER APPLY (
	SELECT p2.PartID,p2.Part,p2.Act,p2.ActID
	FROM TRNS.PartActHierarchy		AS p1
	JOIN ENG.PartAct				AS p2 ON p2.PartActID=p1.PartActID
	WHERE p1.PartActBinPath=t1.PartActBinPath.GetAncestor(1)
) as T4 
GO