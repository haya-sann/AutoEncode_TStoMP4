Option Explicit

Dim fso, outputDirectory, InputFilename
Set fso = CreateObject("Scripting.FileSystemObject")

outputDirectory = "\\LS410DX3DA\SharedDisk1\SharedFiles\"

IF fso.FolderExists(outputDirectory) = False Then
       '���L�t�H���_�ɐڑ��ł��Ȃ��Ƃ��̏���
       Msgbox "���L�t�H���_�ɐڑ��ł��܂���B�v���O�������I�����܂�"
       WScript.Quit
end IF

InputFilename = "C:\Users\haya_\Documents\AutoEncode_TStoMP4\testProgram\testClip.txt"
' InputFilename = WScript.Arguments.item(0)
On Error Resume Next
fso.MoveFile InputFilename,outputDirectory 'MoveFile�ɂ͏㏑���֎~���[�h�����Ȃ��B�����t�@�C��������ƃG���[�ŏI�����邾��
If Err.Number <> 0 Then
       CreateObject("WScript.Shell").Popup  "�����ρBError Number:" + CStr(Err.Number), 5, "����"
       If Err.Number = 58 then
              MsgBox  "�t�@�C�������ɑ��݂��܂��B�G���[�ԍ���:" + CStr(Err.Number)
              call moveVideoFile("test.txt")
              MsgBox "�A��܂���" + Cstr(FileToMove)
       End If
On Error Goto 0
End If


Public Function moveVideoFile(FileToMove)
       Select Case Err.Number
              Case 58
              MsgBox "���AmoveVideoFile�֐���:" + Err.Number
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
