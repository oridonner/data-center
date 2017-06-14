# Deploy dacpac file to server
/opt/mssql-tools/bin/sqlcmd -S mssql-vnext-01 -d DataCenter -U sa -P vnext@2017 -Q "EXEC ADMN.StartDB"

# Restart database
/opt/mssql/bin/sqlpackage /pr:"/opt/mssql/deploy/DataCenter.publish.xml" /sf:"/opt/mssql/deploy/DataCenter.dacpac" /a:Publish /tu:"sa" /tp:"vnext@2017"

# Restart database
/opt/mssql-tools/bin/sqlcmd -S mssql-vnext-01 -d DataCenter -U sa -P vnext@2017 -Q "EXEC ADMN.StartDB"