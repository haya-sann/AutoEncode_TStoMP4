' BEGIN: �t�@�C�������擾���ĕ\������
dim targetServer
targetServer = "\\NAS702258\video\"
If WScript.Arguments.Count > 0 Then
    For Each arg In WScript.Arguments
        WScript.Echo arg
        
        ' BEGIN: �t�@�C������"�j���[�X"�܂���"��"���܂܂��ꍇ�A�T�[�o�[\\NAS702258\video\�j���[�X\�ɁA�����t�@�C�����Ɂh����h���܂܂�Ă���΃T�[�o�[�� \\NAS702258\video\����E�Γ_\�@�Ɉړ�����
        If InStr(arg, "�j���[�X") > 0 Or InStr(arg, "��") > 0 Then
            targetServer  = targetServer & "�j���[�X\"
            ElseIf InStr(arg, "����") > 0 Or InStr(arg, "�Γ_") > 0  Then
            targetServer  = targetServer & "����E�Γ_\"
            ElseIf InStr(arg, "�N���V�b�N") > 0  Then
            targetServer  = targetServer & "�N���V�b�N\"
            ElseIf InStr(arg, "�����") > 0 Or InStr(arg, "�o���G�e�B") > 0  Then
            targetServer  = targetServer & "�o���G�e�B\"
            ElseIf InStr(arg, "�N���[�Y�A�b�v����") > 0  Then
            targetServer  = targetServer & "�h�L�������^���[\�N���[�Y�A�b�v����\"
            ElseIf InStr(arg, "�J���u���A�{�a") > 0  Then
            targetServer  = targetServer & "�h�L�������^���[\�J���u���A�{�a\"
            ElseIf InStr(arg, "�K�C�A�̖閾��") > 0  Then
            targetServer  = targetServer & "�h�L�������^���[\�K�C�A�̖閾��\"
            ElseIf InStr(arg, "�u���^����") > 0  Then
            targetServer  = targetServer & "�h�L�������^���[\�u���^����\"
            ElseIf InStr(arg, "�f���̐��I") > 0  Then
            targetServer  = targetServer & "�h�L�������^���[\�f���̐��I\"
            ElseIf InStr(arg, "���C���h���C�t") > 0  Then
            targetServer  = targetServer & "�h�L�������^���[\WildLife\"
            ElseIf InStr(arg, "�a�a�b�@�d��������") > 0  Then
            targetServer  = targetServer & "�h�L�������^���[\�a�a�b�@�d��������\"
            ElseIf InStr(arg, "�m�g�j�X�y�V����") > 0  Then
            targetServer  = targetServer & "�h�L�������^���[\"
            ElseIf InStr(arg, "�v���l�b�g�A�[�X") > 0  Then
            targetServer  = targetServer & "�h�L�������^���[\Nature\"
            ElseIf InStr(arg, "�P�O�O�J��") > 0  Then
            targetServer  = targetServer & "�h�L�������^���[\100�J��\"
            ElseIf InStr(arg, "�N���V�b�N") > 0  Then
            targetServer  = targetServer & "Music\�N���V�b�N\"
            ElseIf InStr(arg, "����") > 0 Or InStr(arg, "�O����") > 0  Or InStr(arg, "����") > 0  Then
            targetServer  = targetServer & "�����E�O����\"
            ElseIf InStr(arg, "�~�X�e���[") > 0 Or InStr(arg, "�|�A��") > 0 Or InStr(arg, "�A�K�T�E�N���X�e�B�[") > 0  Then
            targetServer  = targetServer & "�~�X�e���[\"
         Else
            targetServer  = targetServer & "New\"
        End If
            Set fso = CreateObject("Scripting.FileSystemObject")
            Set f = fso.GetFile(arg)
            CreateObject("WScript.Shell").Popup f.Name + " moves to  " +  targetServer , 20, "����" 'message, second, title

            f.Move targetServer & f.Name
            'targetServer���N���A����
            targetServer = "\\NAS702258\video\" '���ɖ߂�

    Next
End If
' END: �t�@�C�������擾���ĕ\������
