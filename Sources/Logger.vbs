Function Logger(ByVal Enable, ByVal NewLog, ByVal FilePath, ByVal Code, ByVal Scanner, ByVal Request, ByVal RequestNumber)

Dim file_path, file_name, file, fso, fo, newFile, delimiter, nextLine

'Initialization of Tags
Const MODE=8	'8 = Append
delimiter=vbTab
nextLine=vbCrLf
newFile = False
Set fso = CreateObject("Scripting.FilesystemObject")
file_path = FilePath '"C:\dnomaiD\"
file_name = "dbms.log"
file = file_path & file_name

'Start
If Not NewLog Or Not Enable Or Request <> RequestNumber Then	
	Logger = False
	Exit Function
End If

On Error Resume Next

'Create Folder
If fso.FolderExists(file_path)  Then
          ShowSystemAlarm "Path Exist"
    Else 
          fso.CreateFolder (file_path) 
          ShowSystemAlarm "Path Created"          
End If 
If Err.Number<> 0 Then
	ShowSystemAlarm "Error # " & CStr(Err.Number)& " "& Err.Description
	Err.Clear
	Logger = False	
	Exit Function
End If

'Create Text File
If fso.FileExists(file)  Then
          ShowSystemAlarm "File Exist"
          newFile = False 
    Else 
          fso.CreateTextFile (file) 
          ShowSystemAlarm "File Created"          
          newFile = True 
End If 
If Err.Number<> 0 Then
	ShowSystemAlarm "Error # " & CStr(Err.Number)& " "& Err.Description
	Err.Clear
	Logger = False	
	Exit Function
End If

'Create a file object
Set fo= fso.OpenTextFile(file,MODE,True)

'Check if any errors happend
If Err.Number<> 0 Then
	ShowSystemAlarm "Error # " & CStr(Err.Number)& " "& Err.Description
	Err.Clear
	Logger = False	
	Exit Function
End If

'Write Headline if File is new
If newFile Then
	fo.WriteLine("Date" & delimiter & delimiter & delimiter & "Code" & delimiter & delimiter & "Scanner" & nextLine)
End If

'Write data into file
fo.WriteLine(Now & delimiter & Code & delimiter & Scanner)

'Close the file
fo.Close

'Release the Object
Set fo = Nothing
Set fso = Nothing

'Return
Logger = False
ShowSystemAlarm "Successful!"

End Function