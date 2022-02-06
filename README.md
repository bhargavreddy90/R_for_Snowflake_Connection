# R_for_Snowflake_Connection
# This script helps to connect to snowflake, fetch data and write back the data to existing tables using append method considering the table already exist and has some data.
# This can be improved to create table and replace data and many more as required


# Note:
# First, download the ODBC driver from https://docs.snowflake.com/en/user-guide/odbc-download.html
# Install and Configure the driver
# Make sure the data read and cleaned for ingestion
# Make sure the column names are matching the snowflake table (ensure Case sensitive is maintained for column names/sequence and number of columns) if necessary
# Make sure the columns of data frame align with the right datatype equal to your snowflake table columns
# Take care of the columns when reading them to handle some quick fixes to minimize the transformations
# In this example, csv is considered as file type to read. The excel also can be read installing package readxl and using function read_excel
# Make sure the code is executed in the same network where your org snowflake is running to improve performance
# Below code might need some customization based on individual's requirements
