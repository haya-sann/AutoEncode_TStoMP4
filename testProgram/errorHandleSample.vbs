Option Explicit
'�ȒP�Ȋ���Z�̌��ʂ����b�Z�[�W�{�b�N�X�ŕ\��
msgbox 2 / 1
'�G���[�������̓G���[�𖳎����Ď��̏����Ɉڂ�܂��B
On Error Resume Next
'�G���[���o�����߂ɂ킴�ƂO���Z�����܂��B
msgbox 2 / 0
'�G���[���������Ă��邩���`�F�b�N���܂��B
If Err.Number <> 0 Then
    msgbox "�G���[�����@�ԍ��F" & Err.Number & " " & "�G���[���e�F" & Err.Description
End If
'��L�Ŏw�肵���uOn Error Resume Next�v�͈ȉ��̍s�܂łƂ��܂��B
On Error Goto 0
'�G���[�������͍ēx�G���[�𖳎����Ď��̏����Ɉڂ�悤�ɂ��܂��B
On Error Resume Next
Err.Clear
'�ēx�G���[���o�����߂ɂ킴�ƕ�����̒l��CInt�֐��Ő��l�^�ɕϊ����܂��B
CInt("������")
'�G���[���������Ă��邩���`�F�b�N���܂��B
If Err.Number <> 0 Then
    msgbox "�܂��G���[���������܂����B"
    '�G���[���e�����b�Z�[�W�{�b�N�X�ŕ\�����܂��B
    msgbox "�G���[�ԍ��F" & Err.Number & " " & "�G���[���e�F" & Err.Description
End If
'�G���[�𖳎�����͈͈͂ȉ��̍s�܂łƂ��܂��B
On Error Goto 0
