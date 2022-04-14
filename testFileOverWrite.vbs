Option Explicit


if WScript.Arguments.Count = 0 then
	MsgBox "Drag and Drop TS File. Only One allowed"
'	MsgBox ("�t�@�C����vbs��Drag&Drop���Ă��������B���������")
	WScript.Quit
end if

dim fso
set fso = CreateObject("Scripting.FileSystemObject")

dim dropedInputFilename, outputFileName,  outputDirectory, pt
dropedInputFilename = WScript.Arguments.item(0)
outputDirectory = "F:\MP4Encoded1\"

outputFileName =  fso.GetFileName(WScript.Arguments.item(0))
outputFileName =  outputDirectory & Left (outputFileName, InStrRev(outputFileName,".")) & "mp4" '�g���q��ts����mp4�@�ɍ����ւ�

pt = InputBox ("�h���b�O�A���h�h���b�v�����t���p�X�t�@�C����="  & dropedInputFilename & " ����R�}���h���� ","mp4���k�R�}���h�\��", "ffmpeg -y -i """ & dropedInputFilename & """ -vcodec h264_qsv -q 23 -look_ahead 0 -acodec aac -loglevel error """  & outputFileName & """" )

If IsEmpty(pt) = true Then
  MsgBox "�L�����Z������܂���"
  pt = "cmd /c"
Else
  If pt = "" Then
    MsgBox "���������͂���Ă��܂���"
	pt = "cmd /c" '����͉������Ȃ��R�}���h�̂���
  Else
    dim ws, outExec, StdOut, StdErr, szStr, fileNameToSave, confirmationMessage
    Set ws = WScript.CreateObject("WScript.Shell")

    Set outExec = ws.Exec (pt)
    Set StdOut = outExec.StdOut
    Set StdErr = outExec.StdErr

    szStr = "STDOUT" & vbCrLf
    Do While Not StdOut.AtEndOfStream
      szStr = szStr & StdOut.ReadLine() &vbCrLf
    Loop
    WScript.Echo szStr

    szStr = "STDERR" & vbCrLf
    Do While Not StdErr.AtEndOfStream
      szStr = szStr & StdErr.ReadLine() &vbCrLf
    Loop
    WScript.Echo szStr

    fileNameToSave =  outputDirectory & "errorLog.txt" 
    confirmationMessage = dropedInputFilename & "�̕ϊ�����" &vbCrLf &vbCrLf & "mp4�G���R�[�h�t�@�C���ۑ���F"  &  outputDirectory  &vbCrLf & "�G���[�L�^�́F" &fileNameToSave & "�ɕۑ����܂�"
    MsgBox (confirmationMessage)
    if InStr(outputFileName,"�j���[�X") > 0 or InStr(outputFileName,"�N�[�p�[360") > 0 then 
      fso.MoveFile outputFileName,"\\LS410DX3DA\SharedDisk1\SharedFiles\�j���[�X\"
      ElseIf InStr(outputFileName,"�����") > 0 or InStr(outputFileName,"�o���G�e�B") > 0  Then
      fso.MoveFile outputFileName,"\\LS410DX3DA\SharedDisk1\SharedFiles\�o���G�e�B\"
      ElseIf InStr(outputFileName,"����") > 0 or InStr(outputFileName,"�Γ_") > 0  Then
      fso.MoveFile outputFileName,"\\LS410DX3DA\SharedDisk1\SharedFiles\����E�Γ_\"
      ElseIf InStr(outputFileName,"�f��") > 0 or InStr(outputFileName,"�V�l�}") > 0  Then
      fso.MoveFile outputFileName,"\\LS410DX3DA\SharedDisk1\SharedFiles\�f��\"
      Else
      fso.MoveFile outputFileName,"\\LS410DX3DA\SharedDisk1\SharedFiles\New\"
    End If
    Dim ts
    Set ts = fso.CreateTextFile(fileNameToSave, 2, True)

    ts.Write( confirmationMessage &vbCrLf & szStr)
    ts.Close()

    Set ts = Nothing
    Set fso = Nothing
    Set szStr = Nothing
    Set StdOut = Nothing
    Set StdErr = Nothing
    Set outputFileName = Nothing
    Set dropedInputFilename = Nothing
    
    Set fileNameToSave = Nothing
    Set confirmationMessage = Nothing
    
    Set ws = Nothing
    Set outExec = Nothing

  End If
End If

Set pt = Nothing