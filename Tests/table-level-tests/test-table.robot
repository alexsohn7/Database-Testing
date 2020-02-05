*** Settings ***
Resource          ./database-connection.robot
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
Insert a Record 
  Execute SQL String  INSERT INTO customers (first_name, last_name, is_married) VALUES ('asdf', 'hyun', 'yes');