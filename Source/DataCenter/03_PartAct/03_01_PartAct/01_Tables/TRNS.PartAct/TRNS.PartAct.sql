CREATE TABLE TRNS.PartAct
(			
	 PartActID			INT IDENTITY (10000,1)	NOT NULL
	,PartActBin			AS (CONVERT([hierarchyid],('/'+CONVERT([varchar](10),[PartActID]))+'/')) PERSISTED 
	,PartID				INT						NOT NULL
	,Part				VARCHAR(22)	
	,PartType			VARCHAR(1)		
	,PartIsRoot			BIT	
	,PartIsActive		BIT	
	,ProcessID			INT						NOT NULL		
	,ActID				INT						NOT NULL
	,Act				VARCHAR(10)									
	,ActPos				INT											--POS column in Priority								
	,PrevActID			INT		
	,NextActID			INT				
	,ActIsLast			BIT 
	,ActDays			INT		
	,WorkCenterID		INT					
	,WorkCenter			VARCHAR(6)	
	,stdTimeEmployee	FLOAT 
	,stdTimeMachine		FLOAT
	CONSTRAINT pk_TRNS_PartAct PRIMARY KEY CLUSTERED (PartActID)
);
GO