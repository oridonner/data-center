
# change ownership of directory where the packages are sent to
sudo chown ori:ori home/mssql-builder/packages/

# create packages directory
sudo mkdir /var/www/html/packages

# create soft link to /home/mssql-builder/packages
sudo ln -s /home/mssql-builder/packages/ /home/mssql-builder/mssql

# create soft link to apache web server
sudo ln -s /home/mssql-builder/mssql /var/www/html/packages/


