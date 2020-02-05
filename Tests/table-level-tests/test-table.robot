*** Settings ***
Suite Setup       Connect To Database    pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
Suite Teardown    Disconnect From Database
Library           DatabaseLibrary
Library           OperatingSystem

*** Variables ***
${DBName}         Test_DB
${DBUser}         root
${DBPass}         root
${DBHost}         127.0.0.1
${DBPort}         3306

*** Variables ***


*** Test Cases ***
# Create customers table 
#   ${output}=  Execute SQL String  CREATE table customers(id int(11) NOT NULL AUTO_INCREMENT, first_name varchar(30) NOT NULL, last_name varchar(30) NOT NULL, PRIMARY KEY(id));
#   Should Be Equal As Strings  ${output}  None

Insert multiple records into customers table
  ${output}=  Execute SQL Script  Resources/TestData/Test_DB_insert_person.sql
  log to console  ${output}
  Should Be Equal As Strings  ${output}  None

Check Ryan record exists in customers table
  check if exists in database  SELECT id from Test_DB.customers WHERE first_name="Ryan";

Check Jio record does not exists in the customers table
  check if not exists in database   SELECT id from Test_DB.customers WHERE first_name="jio";

Check customers table exists in the Test_DB database
  table must exist  customers

Verify row count is zero
  row count is 0  SELECT * FROM Test_DB.customers WHERE first_name='Eunice';

Verify row count is equal to some value 
  row count is equal to x  SELECT * FROM Test_DB.customers WHERE first_name='Evan';  12

Verify row count is greater than some value
  row count is greater than x  SELECT * FROM Test_DB.customers WHERE first_name='Evan';  8

Verify row count is less than some value
  row count is less than x  SELECT * FROM Test_DB.customers WHERE first_name='Evan';   30

Update record in person table
  ${output}=  Execute SQL String  UPDATE Test_DB.customers SET first_name='Alex' WHERE last_name='Rang'
  should be equal as strings  ${output}  None

Retrieve Records from customers table
  @{all_customers}=      query      SELECT * FROM Test_DB.customers;
  log many    @{all_customers}

Delete Records from customers table
  ${output}=  Execute SQL String  DELETE FROM Test_DB.customers;
  Should be equal as strings  ${output}  None