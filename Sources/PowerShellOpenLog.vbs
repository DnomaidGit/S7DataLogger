Sub PowerShellOpenLog(ByVal Enable, ByRef FilePath)
Dim fso, File_Path
Set fso = CreateObject("Wscript.Shell")
File_Path = FilePath 'C:\Users\Public\dnomaiD\

'Start
If Not Enable Then
	ShowSystemAlarm "Disable"	
	Exit Sub
End If

On Error Resume Next

fso.Run("powershell.exe -command Get-Content -Path " & File_Path & "dbms.log -wait;start-sleep 10")

If Err.Number<> 0 Then
	ShowSystemAlarm "Error # " & CStr(Err.Number)& " "& Err.Description
	Err.Clear
	Exit Sub
End If

'Release the Object
Set fso = Nothing
End Sub