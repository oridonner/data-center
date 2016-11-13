CREATE TRIGGER TRNS.TRNS_PartActAssembly_AfterInserTrigger ON TRNS.PartActAssembly
AFTER INSERT 
AS
BEGIN
	EXEC TRNS.ERP_AssemblyHierarchy;
END;
GO