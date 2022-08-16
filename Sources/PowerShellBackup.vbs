Sub PowerShellBackup(ByVal Enable, ByVal FilePath)
Dim fso, File_Path, DaTi
Set fso = CreateObject("Wscript.Shell")
File_Path = FilePath 'C:\Users\Public\dnomaiD\
DaTi = Year(Now) & Month(Now) & Day(Now) & Hour(Now) & Minute(Now) & Second(Now)

'Start
If Not Enable Then
	ShowSystemAlarm "Disable"	
	Exit Sub
End If

On Error Resume Next

fso.Run("powershell.exe -command Rename-Item -Path " & File_Path & "dbms.log " & DaTi & "backup.log;start-sleep 1")

If Err.Number<> 0 Then
	ShowSystemAlarm "Error # " & CStr(Err.Number)& " "& Err.Description
	Err.Clear
	Exit Sub
End If

'Release the Object
Set fso = Nothing
End Sub