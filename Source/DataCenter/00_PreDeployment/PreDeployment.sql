/*
 Pre-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be executed before the build script.	
 Use SQLCMD syntax to include a file in the pre-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the pre-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
if exists (select * from sys.servers where name='Priority')
	exec sp_dropserver 'Priority', 'droplogins'; 

EXEC master.dbo.sp_addlinkedserver
@server = N'Priority',
@srvproduct=N'',
@provider=N'SQLNCLI',
@datasrc=N'Priority'
GO

EXEC master.dbo.sp_addlinkedsrvlogin
@rmtsrvname=N'Priority',
@useself=N'False',
@locallogin=NULL,
@rmtuser=N'oridoner',
@rmtpassword='oridoner'
GO





