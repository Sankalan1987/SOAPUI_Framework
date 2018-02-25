strFilePath=Wscript.Arguments(0)
Set app = CreateObject("Excel.Application")
On Error Resume Next
Set wb = app.Workbooks.Open(strFilePath)

if (Err.number=0) then 
      app.DisplayAlerts = False
	  wb.Save
	  wb.Close SaveChanges=True
	  end if