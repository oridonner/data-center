REM Provision sql server 
Vagrant up

REM Build database schema (dacpac file)
msbuild ..\Source\DataCenter\DataCenter.sqlproj

REM Deploy dacpac file to server
SqlPackage.exe /pr:"..\Builds\DataCenter.publish.xml" /sf:"..\Builds\DataCenter.dacpac" /a:Publish /tu:"sa" /tp:"vnext@2017"

REM Restart database
REM sqlcmd -S mssql-vnext-01 -d DataCenter -U sa -P vnext@2017 -Q "EXEC ADMN.StartDB"

