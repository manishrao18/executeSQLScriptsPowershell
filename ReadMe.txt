## Author: Manish.Patil
## Date: 09-10-2019
## Description: powershell script for database executing sql server sql scripts
## Purpose: Automation script using Windows Powershell for executing MS SQL Scripts [select statements] and generate CSV
##  output.

Requirements: 
1. Create folder structure and put files as follows:
	PowerShell  ----> RootFolder: Create this folder possibly on D drive of the Database server.
		|
		|====> Merged	----> SubFolder
		|
		|====> SQL Scripts 	----> The sql scripts that are required to be executed
		|
		|====> AutomationSQLScriptsExecution1.ps1 	----> powershell script that does the automation

2. In order to run the script smoothly please set following variables with appropriate values in powershell script "AutomationSQLScriptsExecution1.ps1".
	#Connect to SQL and run QUERY 
		$SQLServer = "SQLMYDBServer" 
		$SQLDBName = "MYSampleDB"
		$SQLUsername = "sa" 	====> This should be preferably SQL Authenticated user instead of windows user
		$SQLPassword = "SomEP@$$Word"

	# Folder and file details
		$WorkFolder = "D:\Powershell\"		====> as mentioned in #1. above
		$OutputFile = $WorkFolder + "Merged\ExecutionResult.csv"		====> as mentioned in #1. above

3. For sql scripts threw error during execution, powershell script will create empty csv file against it. The same will be merged in the ExecutionResult.csv file. The encountered error will be displayed in powershell console.

4. During every execution the powershell script creates individual .csv file against every .sql script and finally merges this into one single .csv file which is placed in "Merged" folder with name ExecutionResult.csv 

5. These individual .csv files can be used for further analysis or sharing purpose.

6. Note: Every run of the powershell script deletes exsisting .csv files from root and the "Merged" folder. 

7. AutomationSQLScriptsExecution2.ps1 is an alternative option just in case if the AutomationSQLScriptsExecution1.ps1 is not working.

8. for appropriate script execution sequence, number the sql script files as 01_XXXXXX.sql, 02_XXXXXX.sql