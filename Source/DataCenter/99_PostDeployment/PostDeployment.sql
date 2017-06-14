
--Post-Deployment Script Template							
/*
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/


/* Configurations */

:r .\01_Config\JobsEnable.sql

/* Job Policies */
:r .\02_Jobs\ETL.ExtractPolicy.sql
:r .\02_Jobs\ExtractionPolicies.sql
:r .\02_Jobs\ExtractionTables.sql

/* Jobs */



/* Data  */
--Calendar
:r .\03_Data\GEN.Calendar.sql

--For starting database from scratch: 
--:r .\03_Data\ADMN.StartDB.sql



/* Test  */
:r .\04_Test\TEST.RowCountAllTables.sql
