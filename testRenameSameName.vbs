Option Explicit
'https://blog.systemjp.net/entry/20080414/p1
'https://www.relief.jp/docs/wsh-get-files-name-wscript-arguments.html
'�ɂ�������B


if WScript.Arguments.Count = 0 then
	MsgBox "�t�@�C����vbs��Drag&Drop���Ă��������B���������"
	WScript.Quit
end if

dim fso
set fso = CreateObject("Scripting.FileSystemObject")

dim dropedInputFilename, outputFileName, pt
dropedInputFilename = WScript.Arguments.item(0)
outputFileName = fso.GetBaseName(WScript.Arguments.item(0)) '�t�@�C�����̖{�̂𔲂�

pt = InputBox("�h���b�O�A���h�h���b�v�����t�@�C����="  & dropedInputFilename & " ����R�}���h���� ","mp4���k�R�}���h�\��", "ffmpeg -y -i """ & dropedInputFilename & """ -vcodec h264_qsv -q 23 -look_ahead 0 -acodec aac -loglevel error """ & dropedInputFilename & ".mp4""" )


