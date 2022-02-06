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



#Installing the required packages
install.packages(c("DBI", "dplyr","dbplyr","odbc","readr"))

#Initializing the packages
library(DBI)
library(dplyr)
library(dbplyr)
library(odbc)
library(readr)


Main_Data <- as.data.frame(
                            read_csv("C:/Users/username/Downloads/file_name.csv", 
                            col_types = cols(
                                                HS_SOURCE2 = col_character(), 
                                                RCRD_UPDT_DTTM = col_character(), 
                                                RCRD_INSRT_USR = col_character()
                                            )
                                    )
                          )


# Building the connection variable
myconn <- DBI::dbConnect(
                          odbc::odbc(), 
                          Driver = "SnowflakeDSIIDriver",            #Snowflake driver to establish connection
                          Server = "ac12345.snowflakexyz.com",       #Enter the snowflake server details   
                          uid="xyz",                                 #Enter your User Name
                          pwd='abc'                                  #Enter your Password
                          )



# To get the sample data from the required table 
# mydata <- DBI::dbGetQuery(
#                           myconn,
#                           "SELECT * FROM DB_NAME.Schema_Name.Table_Name LIMIT 10"
#                           )



# Push the data into snowflake table using append method
table_id <- Id(database="DB_Name", schema="Schema_Name", table="Table_Name")

DBI::dbAppendTable(
                    conn = myconn,
                    name = table_id,
                    value = Main_Data,        # The data.frame that holds the data read using read_csv
                    row.names = NULL)


# Closing the connection to release the resources and session
DBI::dbDisconnect(myconn)

