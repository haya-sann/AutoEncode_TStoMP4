
set someStrings="202205161125���傤�̗����q?�L?�i�[�X?�u�{�̃T�N�T�N�P���g��?�v[��].mp4"
echo %someStrings%
echo %someStrings% | findstr "�T�N�T�N �O����" >NUL
echo ErrorLevel�� %ERRORLEVEL% �ł� 
        if not ERRORLEVEL 1 (
        echo "�����G���A�Ɉړ�"
    ) else (
        echo �������܂���
)

set omestrings=%someStrings%
echo %omestrings% | findstr "�j���[�X" >NUL
if not ERRORLEVEL 1 (
    echo "��"
) else (
    echo %omestrings% | findstr "�C �R ��" >NUL
    if not ERRORLEVEL 1 (
        echo "���R"
    ) else (
        echo %omestrings% | findstr "�����" >NUL
        if not ERRORLEVEL 1 (
            echo "�o���G�e�B"
        ) else (
            echo %omestrings% | findstr "�|�A��" >NUL
            if not ERRORLEVEL 1 (
                echo "�~�X�e���["
            )
        )
    )
)

