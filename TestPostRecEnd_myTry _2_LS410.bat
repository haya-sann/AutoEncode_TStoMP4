 rem  h264_qsv ���g���ăG���R�[�f�B���O
echo ****************************************  >> F:\MP4Encoded1\result.txt 2>>&1
echo.   >> F:\MP4Encoded1\result.txt 2>>&1
ECHO %DATE% %TIME%  >> F:\MP4Encoded1\result.txt 2>>&1
ECHO ���ݎ��s���̃t�@�C������%~nx0 >> F:\MP4Encoded1\result.txt 2>>&1
echo ========================================  >> F:\MP4Encoded1\result.txt 2>>&1
echo $FilePath$ >> F:\MP4Encoded1\result.txt 2>>&1
echo.   >> F:\MP4Encoded1\result.txt 2>>&1
echo $FileName$ >> F:\MP4Encoded1\result.txt 2>>&1
set encodedFile=F:\MP4Encoded1\$SDYYYY$$SDMM$$SDDD$$STHH$$STMM$$TitleF$.mp4
echo ======================================== >> F:\MP4Encoded1\result.txt 2>>&1
ffmpeg -y -i "$FilePath$" -vcodec h264_qsv -q 23 -look_ahead 0 -acodec aac -loglevel error "%encodedFile%" >> F:\MP4Encoded1\result.txt 2>>&1
echo �G���R�[�f�B���O�I�� >> F:\MP4Encoded1\result.txt 2>>&1
echo ���t�@�C�� $FilePath$ ���폜��Ə����J�n >> F:\MP4Encoded1\result.txt 2>>&1
move "$FilePath$" E:\Media2-1\toBeTrash   >> F:\MP4Encoded1\result.txt 2>>&1
echo ����Ɉ��������A$FileName$��QNAP�T�[�o�[��Video�t�H���_�Ɉړ�  >> F:\MP4Encoded1\result.txt 2>>&1
echo $FileName$ | findstr "�j���[�X ��" >NUL
set ServerTarget="\\NAS702258\video\"
rem �ۑ���̃T�[�o�[�A�h���X�B�܂��A�ϐ��̓��e��esult.txt�ɏ����o���Ă��玟�ɐi�݂܂��B
echo Line-20 �ړ�������t�@�C���� %encodedFile% . Error Level �� %ERRORLEVEL% : >> F:\MP4Encoded1\result.txt


if not ERRORLEVEL 1 (
    rem not ERRORLEVEL 1 �̓G���[�͂Ȃ������A�܂茟���Ƀq�b�g�����Ƃ����Ӗ�
    echo Line-25 >> F:\MP4Encoded1\result.txt 2>>&1
    set ServerTarget="%ServerTarget%�j���[�X\"
    rem %ServerTarget%�j���[�X\ �͖��ʂȃX�y�[�X������Ȃ��悤�Ɂh�ň͂�
) else (
    echo $FileName$ | findstr "�Γ_ ����" >NUL
    echo Line-29 >> F:\MP4Encoded1\result.txt 2>>&1
    if not ERRORLEVEL 1 (
        set ServerTarget="%ServerTarget%����E�Γ_\"
        )  else (
            echo $FileName$ | findstr "���� �O���� �������� ���V�s" >NUL
            echo Line-34 >> F:\MP4Encoded1\result.txt 2>>&1
            if not ERRORLEVEL 1 (
                set ServerTarget="%ServerTarget%�����E�O����\"
                )  else (
                echo $FileName$ | findstr "�N���[�Y�A�b�v����" >NUL
                echo Line-34 >> F:\MP4Encoded1\result.txt 2>>&1
                if not ERRORLEVEL 1 (
                    set ServerTarget="%ServerTarget%�h�L�������^���[\�N���[�Y�A�b�v����\"
                )  else (
                echo $FileName$ | findstr "�d��������" >NUL
                echo Line-34 >> F:\MP4Encoded1\result.txt 2>>&1
                if not ERRORLEVEL 1 (
                    set ServerTarget="%ServerTarget%�h�L�������^���[\Nature\"
                )  else (
                echo $FileName$ | findstr "�h�L�������^���[" >NUL
                echo Line-34 >> F:\MP4Encoded1\result.txt 2>>&1
                if not ERRORLEVEL 1 (
                    set ServerTarget="%ServerTarget%�h�L�������^���[\"
                                    )  else (
                echo $FileName$ | findstr "�J���u���A�{�a" >NUL
                echo Line-34 >> F:\MP4Encoded1\result.txt 2>>&1
                if not ERRORLEVEL 1 (
                    set ServerTarget="%ServerTarget%�h�L�������^���[\�J���u���A�{�a\"
                    ) else (
                    echo $FileName$ | findstr "�f�� �V�l�} ���[�h�V���[ [�f]" >NUL
                    echo Line-39 >> F:\MP4Encoded1\result.txt 2>>&1
                    if not ERRORLEVEL 1 (
                        set ServerTarget="%ServerTarget%�f��\"
                        ) else (
                        echo $FileName$ | findstr "�V�����񂢂�����Ⴂ �����" >NUL
                        echo Line-46 >> F:\MP4Encoded1\result.txt 2>>&1
                        if not ERRORLEVEL 1 (
                            set ServerTarget="%ServerTarget%�o���G�e�B\"
                        ) else (
                            echo $FileName$ | findstr "�v���O���~���O" >NUL
                            echo Line-51 >> F:\MP4Encoded1\result.txt 2>>&1
                            if not ERRORLEVEL 1 (
                                echo Line-53 >> F:\MP4Encoded1\result.txt 2>>&1
                                set ServerTarget= "%ServerTarget%computer\"
                            ) else (
                                echo $FileName$ | findstr "�N���V�b�N" >NUL
                                echo Line-56 >> F:\MP4Encoded1\result.txt 2>>&1
                                if not ERRORLEVEL 1 (
                                    echo Line-61 >> F:\MP4Encoded1\result.txt 2>>&1
                                    set ServerTarget="%ServerTarget%Music\�N���V�b�N\"
                                ) else (
                                    echo Line-64 >> F:\MP4Encoded1\result.txt 2>>&1
                                    set ServerTarget="%ServerTarget%New\"
                                    )))))
                                    echo Line-67 �����`�F�b�N���鍀�ڂ͂���܂��� >> F:\MP4Encoded1\result.txt 2>>&1
    ))))))
move "%encodedFile%" "%ServerTarget%"  >> F:\MP4Encoded1\result.txt 2>>&1
echo Line-67, $FileName$��QNAP�T�[�o�[��%ServerTarget%�t�H���_�Ɉړ������B  >> F:\MP4Encoded1\result.txt 2>>&1
echo ======================================== >> F:\MP4Encoded1\result.txt 2>>&1
