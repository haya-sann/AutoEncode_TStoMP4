Option Explicit

Dim fso, outputDirectory, InputFilename
Set fso = CreateObject("Scripting.FileSystemObject")

outputDirectory = "\\LS410DX3DA\SharedDisk1\SharedFiles\"

IF fso.FolderExists(outputDirectory) = False Then
       '共有フォルダに接続できないときの処理
       Msgbox "共有フォルダに接続できません。プログラムを終了します"
       WScript.Quit
end IF

InputFilename = "C:\Users\haya_\Documents\AutoEncode_TStoMP4\testProgram\testClip.txt"
' InputFilename = WScript.Arguments.item(0)
On Error Resume Next
fso.MoveFile InputFilename,outputDirectory 'MoveFileには上書き禁止モードしかない。同名ファイルがあるとエラーで終了するだけ
If Err.Number <> 0 Then
       CreateObject("WScript.Shell").Popup  "何か変。Error Number:" + CStr(Err.Number), 5, "注意"
       If Err.Number = 58 then
              MsgBox  "ファイルが既に存在します。エラー番号は:" + CStr(Err.Number)
              call moveVideoFile("test.txt")
              MsgBox "帰りました" + Cstr(FileToMove)
       End If
On Error Goto 0
End If


Public Function moveVideoFile(FileToMove)
       Select Case Err.Number
              Case 58
              MsgBox "今、moveVideoFile関数内:" + Err.Number
              kPoint = InStrRev(FileToMove, ".")
              extention = Right(FileToMove, Len(FileToMove) - kPoint + 1)
              FileToMove = Left(FileToMove, Len(FileToMove) - Len(extention))
              hpoint = InStrRev(FileToMove, "-")
              If hpoint > 0 Then
                     subName = Right(FileToMove, Len(FileToMove) - hpoint + 1)
                     If IsNumeric(subName) Then
                     subName = Val(subName) - 1
                     FileToMove = Left(FileToMove, hpoint - 1) & subName & extention
                     Else
                     FileToMove = FileToMove & "-1" & extention
                     End If
              Else
              FileToMove = FileToMove & "-1" & extention
              End If
              MsgBox "in the Function"
              Case Else
                     Err.Raise Err.Number, , Err.Description
       End Select
End Function
