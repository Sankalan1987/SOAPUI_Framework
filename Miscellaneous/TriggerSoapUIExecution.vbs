'##########################################################################
'Script Description : Script to trigger the execution of Alamo Web Automation framework for already queued log request
'Test Tool/Version : Quick Test Professional 11
'Test Tool Settings : N.A.
'Application Automated : Alamo Web
'Author : Trinanjan Majumdar 
'Date Created : 10/01/2013
'##########################################################################
Option Explicit
Dim strFilePath, objConn, intRecordCount, strCurrentTime, strExecutionFilePath
Dim strGlobalSettingsFilePath, strCommonTestDataFilePath, blnIsConnected, i

strExecutionFilePath = "Y:\Groups\Web_Next_Gen\AUTOMATION\PUBLIC\WNG_EMA_WEBSERVICE\TestCaseRunner.bat"	'Startup script for CRAFT framework
strGlobalSettingsFilePath = "Y:\Groups\Web_Next_Gen\AUTOMATION\PUBLIC\WNG_EMA_WEBSERVICE\GlobalSettings.xml"	'CRAFT framework configuration file, configure the suit to be executed
strCommonTestDataFilePath = "Y:\Groups\Web_Next_Gen\AUTOMATION\PUBLIC\WNG_EMA_WEBSERVICE\Common_Data.xls"	'Common testdata excel for CRAFT framework

Set objConn = CreateObject("ADODB.Connection")	'Create DB connection object
    objConn.connectionstring = "Driver={MySQL ODBC 5.2 UNICODE Driver};Server=" & GetConfig("DBServer") & ";Port:" & GetConfig("Port") & ";Database=" & GetConfig("Database") & ";User=" & GetConfig("User") & "; Password=" & GetConfig("Password") & ";Option=3;"

On Error Resume Next
blnIsConnected = False

LogMsg "debug", "---------------------------------- TriggerSOAExecution Script Start ---------------------------------------"
WScript.sleep(300)
For i = 1 To 15 'Max retry for 15 seconds
	objConn.Open         'Open DB connection
	''msgbox err.description
	If Err.Number <> 0 Then
		WScript.sleep(1000)
		Err.Clear
	Else
		blnIsConnected = True
		LogMsg "info", "Connection obtained to execution log."
		Exit For
	End If
Next
If blnIsConnected Then
    RequestProcessor objConn, strExecutionFilePath, strGlobalSettingsFilePath, strCommonTestDataFilePath
    objConn.Close
	Set objConn = Nothing
	LogMsg "info", "Connection to execution log released"
	
End If
LogMsg "debug", "---------------------------------- TriggerSOAPExecution Script End ---------------------------------------"


'##########################################################################
'Function Description : Function to get DB Settings
'Input Parameters : strKey
'Return Value : None
'Author : Venkatesh
'Date Created : 03/04/2014
'##########################################################################
Public Function GetConfig(strKey)
        Dim objXmlDoc
        Dim objAllnodes, objNode, objFirstNode, objValueNode, strQuery, strValue
        Set objXmlDoc = CreateObject("Microsoft.XMLDOM")
        objXmlDoc.Load "Y:\Groups\Web_Next_Gen\AUTOMATION\PUBLIC\AUTOMATIC_FRAMEWORK_EXECUTION\DBSettings.xml"
        strQuery = "//Environment/Variable"
        Set objAllnodes = objXmlDoc.SelectNodes(strQuery)
	    If objAllnodes.Length > 0 Then
            For Each objNode In objAllnodes
                Set objFirstNode = objNode.FirstChild
				If objFirstNode.Text = strKey Then
                    Set objValueNode = objFirstNode.NextSibling
                    strValue = objValueNode.Text
                    Exit For
                End If
            Next
        End If
        Set objXmlDoc = Nothing
        
        GetConfig = CStr(strValue)
End Function

'##########################################################################
'Function Description : Function to initiate Alamo automation framework execution if current system is free and there is one queued request
'Input Parameters : objConn - 			Excel DB connection object
'					strTestDataSheet - 	Sheet name in excel DB file Execution_Log.xls
'					strExecutionFilePath - Alamo automation framework start script path
'					strGlobalSettingsFilePath - Global settings path of CRAFT framework
'  					strCommonTestDataFilePath - Common testdata excel for CRAFT framework
'Return Value : None
'Author : Trinanjan MAjumdar
'Date Created : 10/01/2013
'##########################################################################
  Function RequestProcessor(ByVal objConn, ByVal strExecutionFilePath, ByVal strGlobalSettingsFilePath, ByVal strCommonTestDataFilePath)
	Dim strSql, objTestData, intRecordNumber, intQueuedJobNo, blnResult, objTestData1, strTestType, strMachineID, objNetwork, strEnvironmentType, strSuiteType,strDataConfiguration
	
	Set objTestData = CreateObject("ADODB.Recordset")	'Create recordset object
	objTestData.CursorLocation = 3
	
	Set objNetwork = CreateObject("Wscript.Network")	'Create network object
	strMachineID = objNetwork.ComputerName	'Get computer name
	Set objNetwork = Nothing
	
	
	'SQL to read task no which is currently running on local system
	strSql = "SELECT service_id FROM automationservice_log where Status = 'Initiated' and Machine_ID = '" & strMachineID & "'"
	objTestData.Open strSql, objConn
	intRecordNumber = objTestData.RecordCount
	objTestData.Close
	
	
    
	If 	intRecordNumber = 0 Then	'True when there is no request in log with status initiated
		strSql = "SELECT service_id FROM automationservice_log where Status = 'Running' and Machine_ID = '" & strMachineID & "'"
		objTestData.Open strSql, objConn
		intRecordNumber = objTestData.RecordCount
		objTestData.Close
         
		If intRecordNumber = 0 Then    'True when current system is not running any automation session
			'Locking the DB for update with Start Transaction
			objConn.execute "Start Transaction"
			strSql = "SELECT service_id, test_type FROM automationservice_log where Status = 'Queued' and Automation_Suite  IN ('EMA WEBSERVICE') for update" 'Select one queued request
			objTestData.Open strSql, objConn
			intRecordNumber = objTestData.RecordCount
			
			'msgbox intRecordNumber
			'msgbox err.description
			If intRecordNumber <> 0 Then
				'intQueuedJobNo = objTestData(0).Value
				intQueuedJobNo = Dispatcher(objTestData)
				'msgbox intQueuedJobNo
				strSql = "SELECT Automation_Suite FROM automationservice_log where service_id = " & intQueuedJobNo  	'Select task number
				Set objTestData1 = CreateObject("ADODB.Recordset")
				objTestData1.Open strSql, objConn
				strSuiteType = objTestData1(0).Value
				objTestData1.Close
				Set objTestData1 = Nothing
				    strSuiteType = Replace(strSuiteType, " ", "_")
				'strExecutionFilePath = Replace(strExecutionFilePath, "##SUITE_TYPE##", strSuiteType)
				'strGlobalSettingsFilePath = Replace(strGlobalSettingsFilePath, "##SUITE_TYPE##", strSuiteType)
				'strCommonTestDataFilePath = Replace(strCommonTestDataFilePath, "##SUITE_TYPE##", strSuiteType)	
				
				strSql = "SELECT Test_Type FROM automationservice_log where service_id = " & intQueuedJobNo 	'Select task number
				Set objTestData1 = CreateObject("ADODB.Recordset")
				objTestData1.Open strSql, objConn
				strTestType = objTestData1(0).Value
				objTestData1.Close
				Set objTestData1 = Nothing
				
				strSql = "SELECT Environment FROM automationservice_log where service_id = " & intQueuedJobNo 	'Select task number
				Set objTestData1 = CreateObject("ADODB.Recordset")
				objTestData1.Open strSql, objConn
				strEnvironmentType = objTestData1(0).Value
				objTestData1.Close
				Set objTestData1 = Nothing
				
				
				strSql = "SELECT ody_config FROM automationservice_log where service_id = " & intQueuedJobNo 	'Select task number
				Set objTestData1 = CreateObject("ADODB.Recordset")
				objTestData1.Open strSql, objConn
				strDataConfiguration = objTestData1(0).Value
				objTestData1.Close
				Set objTestData1 = Nothing
			

				LogMsg "info", "Picked request details - (" & intQueuedJobNo & "," & strSuiteType & "," & strTestType & "," & strEnvironmentType & ")"
				blnResult = ExecuteAutomationFrameworkAndUpdateLog(intQueuedJobNo, objConn, strExecutionFilePath, strGlobalSettingsFilePath, strCommonTestDataFilePath, strTestType, strEnvironmentType, strDataConfiguration,strMachineID)
				
				If Not blnResult Then
					LogMsg "error", "Error in framework execution."
				End If
			End If
			'Unlock the DB 
			objConn.execute "Commit"
			objTestData.Close
		Else
			LogMsg "info", "Number of running request on this machine - " & intRecordNumber
		End If
	Else
		LogMsg "info", "Number of initiated request - " & intRecordNumber
	End If

	Set objTestData = Nothing
End Function
'##########################################################################
'Function Description : Function to update execution log with running status and initiate framework run.
'Input Parameters : intQueuedJobNo - 	Current queued job number to start execution
'					objConn - 			Excel DB connection object
'					strTestDataSheet - 	Sheet name in excel DB file Execution_Log.xls
'					strExecutionFilePath - Alamo automation framework start script path
'					strGlobalSettingsFilePath - Global settings path of CRAFT framework
'					strCommonTestDataFilePath - Common testdata excel for CRAFT framework
'					strTestType - 		Test suit to be executed
'					strEnvironmentType - Environment type
'					strMachineID - 		Local machine ID
'Return Value : True/False
'Author : Trinanjan Majumdar
'Date Created : 10/01/2013
'##########################################################################
Function ExecuteAutomationFrameworkAndUpdateLog(ByVal intQueuedJobNo, ByVal objConn, ByVal strExecutionFilePath, ByVal strGlobalSettingsFilePath, ByVal strCommonTestDataFilePath, ByVal strTestType, ByVal strEnvironmentType, ByVal strDataConfiguration, ByVal strMachineID)
	Dim strQuery, strStart_Date, strCurrentDate, strCurrentTime, strEnd_Date, objShell, objCon, strConStr, strSheet
	
	ExecuteAutomationFrameworkAndUpdateLog = False
	''msgbox intQueuedJobNo
	'Get current date and time in yyyy-mm-dd hh:min:ss format
	strStart_Date = DatePart("yyyy", Now) &"-"& DatePart("m", Now) &"-"& DatePart("d", Now) &" "& DatePart("h", Now) &":"& DatePart("n", Now) &":"& DatePart("s", Now)
    'update polled task with running status
	'msgbox intQueuedJobNo
	strQuery = "UPDATE automationservice_log SET Status = 'Initiated' WHERE service_id = " & intQueuedJobNo
	objConn.Execute strQuery
	''msgbox err.description
	'update local machine_id for the polled task
	strQuery = "UPDATE automationservice_log SET Machine_ID = '" & strMachineID & "' WHERE service_id = " & intQueuedJobNo
	objConn.Execute strQuery
	''msgbox err.description
	'Update task start date for the polled task
	strQuery = "UPDATE automationservice_log SET Start_Date = '" & strStart_Date & "' WHERE service_id = " & intQueuedJobNo 
	objConn.Execute strQuery
	''msgbox err.description
	
	UpdateGlobalSettings strGlobalSettingsFilePath, "//Variable/Suite", strTestType
      

	UpdateGlobalSettings strGlobalSettingsFilePath, "//Variable/Environment", strEnvironmentType
	 If (strDataConfiguration <> "") Then
	     UpdateGlobalSettings strGlobalSettingsFilePath, "//Variable/DataConfiguration", strDataConfiguration
     End If
	 UpdateGlobalSettings strGlobalSettingsFilePath, "//Variable/ServiceID", intQueuedJobNo
	'If Len(strBrowserSize)<> 0 Then UpdateGlobalSettings strGlobalSettingsFilePath, "BrowserSize", strBrowserSize
	 ''msgbox "hii"
	 'msgbox strExecutionFilePath
	Set objShell = Wscript.CreateObject("WScript.Shell")	'Create shell object
	objShell.Run strExecutionFilePath	'Run CRAFT framework
		''msgbox "Hi"
	''msgbox Err.Description
	Set objShell = Nothing
	'strQuery = "UPDATE automationservice_log SET Status = 'Completed' WHERE service_id = " & intQueuedJobNo
	'objConn.Execute strQuery
	ExecuteAutomationFrameworkAndUpdateLog = True
End Function

'##########################################################################
'Function Description : Function to update "RunConfiguration" parameter value in Global Settings.xml inside CRAFT framework with test suit to execute
'Input Parameters : strGlobalSettingsFilePath - Global settings path of CRAFT framework
'					strEnvType - Environment variable to update
'					strEnvValue - 		New environment value
'Return Value : None
'Author : Trinanjan Majumdar
'Date Created : 10/01/2013
'##########################################################################
Function UpdateGlobalSettings(ByVal strGlobalSettingsFilePath, ByVal strEnvType, ByVal strEnvValue)
	Dim objXmlDoc, objAllNode, objNode, objParentNode, objAllChildNodes, objChildNode
	''msgbox strEnvType
	''msgbox strEnvValue
	Set objXmlDoc = CreateObject("Microsoft.XMLDOM")	'Create XML DOM object
	objXmlDoc.Async = "False"
	''msgbox strGlobalSettingsFilePath
	objXmlDoc.Load(strGlobalSettingsFilePath)
     ''msgbox Err.description
	Set objAllNode = objXmlDoc.selectSingleNode(strEnvType)	'Get all nodes under path Environment/Variable/Name
	objAllNode.Text = strEnvValue	'Update value field
	''msgbox Err.description
	  
	objXmlDoc.Save strGlobalSettingsFilePath	'Save the updated XML file
	''msgbox "Node Updated"
	Set objXmlDoc = Nothing
End Function

'##########################################################################
'Function Description : Function to get any parameter value in Global Settings.xml inside CRAFT framework with test suit to execute
'Input Parameters : strGlobalSettingsFilePath - Global settings path of CRAFT framework
'					strEnvType - Environment variable to update
'Return Value : None
'Author : Trinanjan Majumdar
'Date Created : 09/09/2013
'##########################################################################
Function GetGlobalSettingsParameter(ByVal strGlobalSettingsFilePath, ByVal strEnvType)
	Dim objXmlDoc, objAllNode, objNode, objParentNode, objAllChildNodes, objChildNode
	
	Set objXmlDoc = CreateObject("Microsoft.XMLDOM")	'Create XML DOM object
	objXmlDoc.Async = "False"
	objXmlDoc.Load(strGlobalSettingsFilePath)

	Set objAllNode = objXmlDoc.selectNodes("/Environment/Variable/Name")	'Get all nodes under path Environment/Variable/Name

	GetGlobalSettingsParameter = ""
	For Each objNode in objAllNode	'Examine all child noded one by one
	   If objNode.Text = strEnvType Then	'Check node text
			Set objParentNode = objNode.ParentNode	'If true then get the parent node of node RunConfiguration, to update the test type value
			Set objAllChildNodes = objParentNode.ChildNodes	
			Set objChildNode = objAllChildNodes.Item(1)	'Get value node
			GetGlobalSettingsParameter = objChildNode.Text	'Get value field
			Exit For
	   End If
	Next
	  
	Set objXmlDoc = Nothing
End Function

'##########################################################################
'Function Description : Function to log execution status in logger
'Input Parameters : strLogType -  Log type (debug/info/warn/error/fatal)
'                   strMessage -  Message string to insert in the log
'Return Value : None
'Author : Trinanjan Majumdar
'Date Created : 23/09/2013
'##########################################################################
Function LogMsg(ByVal strLogType, ByVal strMessage)
	Dim objShell, objNetwork, strMachineID
	
	If strLogType <> "" or Len(strLogType) = 0 Then
		strLogType = "debug"
	End If
	Set objNetwork = CreateObject("Wscript.Network")	'Create network object
	strMachineID = objNetwork.ComputerName	'Get computer name
	Set objNetwork = Nothing

	strMessage = """" & strMachineID & "--> " & strMessage & """"
	Set objShell = CreateObject("wscript.shell")
	objShell.Run "Y:\Groups\Web_Next_Gen\AUTOMATION\PUBLIC\AUTOMATIC_FRAMEWORK_EXECUTION\logger\logger " & strLogType & " " & strMessage
	Set objShell = Nothing
End Function


'##########################################################################
'Function Description : Function to select an execution job depending on priority of the job selection
'Input Parameters : objTestData -  SQL output for all queued job
'Return Value : None
'Author : Trinanjan Majumdar
'Date Created : 28/10/2013
'##########################################################################
Function Dispatcher(ByRef objTestData)
	Dim intRecordNumber, ic, intQueuedJobNo, strTestType
	intRecordNumber = objTestData.RecordCount
	Dispatcher = objTestData.Fields.Item("service_id")
	For ic = 1 to intRecordNumber
		intQueuedJobNo = objTestData.Fields.Item("service_id")	'Read task no
		strTestType = objTestData.Fields.Item("Test_Type")	'Read task no
		If Instr(LCase(strTestType),"sanity") Then
			Dispatcher = intQueuedJobNo
			Exit For
		End If		
		objTestData.MoveNext	'Move to next record
	Next
End Function