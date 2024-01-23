Option Explicit
'https://blog.systemjp.net/entry/20080414/p1
'https://www.relief.jp/docs/wsh-get-files-name-wscript-arguments.html
'�ɂ�������B
' �N���b�v�{�[�h�ɔ[�߂錏��
' https://www.ka-net.org/blog/?p=1563
' Evernote�ɋL�^�A�i�y���H�zffmpeg�ŃG���R�[�h����ۂ̃R�}���h�𐶐�����v���O�����j


if WScript.Arguments.Count = 0 then
  CreateObject("WScript.Shell").Popup "Drag and Drop TS File. Only One allowed", 5, "����"
	WScript.Quit
end if

dim fso
set fso = CreateObject("Scripting.FileSystemObject")

dim dropedInputFilename, outputFileName,  outputDirectory, targetServer, pt
dropedInputFilename = WScript.Arguments.item(0)
outputDirectory = "F:\MP4Encoded1\"
targetServer = "\\NAS702258\video\"
outputFileName =  fso.GetFileName(WScript.Arguments.item(0))
outputFileName =  outputDirectory & Left (outputFileName, InStrRev(outputFileName,".")) & "mp4" '�g���q��ts����mp4�@�ɍ����ւ�

pt = InputBox ("�h���b�O�A���h�h���b�v�����t���p�X�t�@�C����="  & dropedInputFilename & " ����R�}���h���� ","mp4���k�R�}���h�\��", "ffmpeg -y -i """ & dropedInputFilename & """ -vcodec h264_qsv -q 23 -look_ahead 0 -acodec aac -loglevel error """  & outputFileName & """" )
If IsEmpty(pt) = true Then
    CreateObject("WScript.Shell").Popup "�L�����Z������܂���", 5, "����"
  pt = "cmd /c"
Else
  If pt = "" Then
    CreateObject("WScript.Shell").Popup "���������͂���Ă��܂���", 5, "����"
	pt = "cmd /c" '����͉������Ȃ��R�}���h�̂���
  Else
    dim ws, outExec, StdOut, StdErr, szStr, errorLogfileNameToSave, confirmationMessage
    Set ws = WScript.CreateObject("WScript.Shell")

    Set outExec = ws.Exec (pt)
    Set StdOut = outExec.StdOut
    Set StdErr = outExec.StdErr

    szStr = "STDOUT" & vbCrLf
    Do While Not StdOut.AtEndOfStream
      szStr = szStr & StdOut.ReadLine() &vbCrLf
    Loop

    szStr = "STDERR" & vbCrLf
    Do While Not StdErr.AtEndOfStream
      szStr = szStr & StdErr.ReadLine() &vbCrLf
    Loop

    errorLogfileNameToSave =  outputDirectory & "errorLog.txt" 
    confirmationMessage = dropedInputFilename & "�̕ϊ�����" &vbCrLf &vbCrLf & "mp4�G���R�[�h�t�@�C���ۑ���F"  &  outputDirectory  &vbCrLf & "�G���[�L�^�́F" &errorLogfileNameToSave & "�ɕۑ����܂�"
    CreateObject("WScript.Shell").Popup confirmationMessage, 5, "����"
    ' �G���[���N���Ȃ���΁F����ts�t�@�C���͍폜���Ɉړ�
    fso.MoveFile dropedInputFilename,"E:\Media2-1\toBeTrash\"
    CreateObject("WScript.Shell").Popup dropedInputFilename + "���폜�Ώۂɂ��܂���", 5, "����"
    confirmationMessage = confirmationMessage &vbCrLf & dropedInputFilename & "���폜�Ώۂɂ��܂���"

    if InStr(outputFileName,"�j���[�X") > 0 or InStr(outputFileName,"�N�[�p�[360") > 0 then 
      targetServer  = targetServer & "�j���[�X\"
      ElseIf InStr(outputFileName,"�h�L�������^��") > 0 or InStr(outputFileName,"�f���̐��I") > 0  Then
      targetServer  = targetServer & "�h�L�������^���[\"
      ElseIf InStr(outputFileName,"�����") > 0 or InStr(outputFileName,"�o���G�e�B") > 0  Then
      targetServer  = targetServer & "�o���G�e�B\"
      ElseIf InStr(outputFileName,"����") > 0 or InStr(outputFileName,"�Γ_") > 0  Then
      targetServer  = targetServer & "����E�Γ_\"
      ElseIf InStr(outputFileName,"�f��") > 0 or InStr(outputFileName,"�V�l�}") > 0  Then
      targetServer  = targetServer & "�f��\"
      ElseIf InStr(outputFileName,"�}�[�v��") > 0 or InStr(outputFileName,"�|�A��") > 0 or InStr(outputFileName,"�~�X�e���[") > 0  Then
      targetServer  = targetServer & "�~�X�e���[\"
      ElseIf InStr(outputFileName,"���y") > 0 or InStr(outputFileName,"�~���[�W�b�N") > 0 or InStr(outputFileName,"Music") > 0  Then
      targetServer  = targetServer & "Music\"
      ElseIf InStr(outputFileName,"����") > 0 or InStr(outputFileName,"����") > 0 or InStr(outputFileName,"�䏊") > 0  Then
      targetServer  = targetServer & "�����E�O����\"
      Else
      targetServer  = targetServer & "New\"
    End If
    fso.MoveFile outputFileName,targetServer
    CreateObject("WScript.Shell").Popup outputFileName + "���T�[�o�[�Ɉړ����ĕۑ����܂���", 5, "����"
    confirmationMessage = confirmationMessage &vbCrLf & outputFileName & "���T�[�o�[" & targetServer &  "�Ɉړ����ĕۑ����܂���"

    Dim ts
    Set ts = fso.CreateTextFile(errorLogfileNameToSave, 2, True)

    ts.Write( confirmationMessage &vbCrLf & szStr)
    ts.Close()

    Set ts = Nothing
    Set fso = Nothing
    Set szStr = Nothing
    Set StdOut = Nothing
    Set StdErr = Nothing
    Set outputFileName = Nothing
    Set dropedInputFilename = Nothing
    
    Set errorLogfileNameToSave = Nothing
    Set confirmationMessage = Nothing
    
    Set ws = Nothing
    Set outExec = Nothing

  End If
End If

Set pt = Nothing
