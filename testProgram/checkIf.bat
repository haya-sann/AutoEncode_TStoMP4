
set someStrings="202205161125���傤�̗����q?�L?�i�[�X?�u�{�̃T�N�T�N�P���g��?�v[��].mp4"
echo %someStrings%
echo %someStrings% | findstr "�T�N�T�N �O����" >NUL
echo ErrorLevel�� %ERRORLEVEL% �ł� 
        if not ERRORLEVEL 1 (
        echo "�����G���A�Ɉړ�"
    ) else (
        echo �������܂���
)

