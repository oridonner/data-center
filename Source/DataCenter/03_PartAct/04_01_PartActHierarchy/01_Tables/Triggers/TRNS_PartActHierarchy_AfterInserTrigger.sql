CREATE TRIGGER TRNS.TRNS_PartActHierarchy_AfterInserTrigger ON TRNS.PartActHierarchy
AFTER INSERT 
AS
BEGIN
	EXEC TRNS.ERP_PartActAssembly;
END;
GO