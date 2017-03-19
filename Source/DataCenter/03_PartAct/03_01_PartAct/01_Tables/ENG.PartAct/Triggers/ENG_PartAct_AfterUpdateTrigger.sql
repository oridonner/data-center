/*
This trigger executes TRNS.ERP_PartActAdjacency that rebuilds TRNS.PartActAdjacency table from scratch.
*/
CREATE TRIGGER ENG.ENG_PartAct_AfterUpdateTrigger ON ENG.PartAct 
AFTER INSERT,UPDATE,DELETE
AS 
BEGIN
--Dont execute where deleted/inserted data is assembly parts 
IF EXISTS (SELECT 1 FROM inserted WHERE PartType='P') OR EXISTS (SELECT 1 FROM deleted WHERE PartType='P')
BEGIN
	EXEC TRNS.ERP_PartActAdjacency;
END

END;
GO

