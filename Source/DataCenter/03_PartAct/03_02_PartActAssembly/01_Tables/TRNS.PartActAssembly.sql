CREATE TABLE TRNS.PartActAssembly
(
	AssemblyID				INT IDENTITY (10000,1)	NOT NULL,
	PartActID				INT						NOT NULL,
	AssemblyPartID			INT						NOT NULL,
	AssemblyBinPath			HIERARCHYID				NULL	
	CONSTRAINT pk_PartActAssembly PRIMARY KEY CLUSTERED (AssemblyID)
);
GO