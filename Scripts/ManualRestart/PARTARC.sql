use DataCenter;
go
truncate table EXTR.PART
truncate table EXTR.PARTARC

truncate table TRNS.PARTARC
truncate table TRNS.PartActAssembly
truncate table TRNS.PartActAdjacency

truncate table ENG.Parts
truncate table ENG.PartAct

exec EXTR.ERP_PART
select * from ENG.PartAct 
select * from TRNS.PROCACT
select * from TRNS.PartAct


exec EXTR.ERP_PARTARC
select * from EXTR.PARTARC
select * from TRNS.PARTARC
select * from ENG.PartAct where PartType='R'

