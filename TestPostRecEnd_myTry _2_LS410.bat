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
echo $FileName$��QNAP�T�[�o�[��Video�t�H���_�Ɉړ�  >> F:\MP4Encoded1\result.txt 2>>&1
echo $FileName$ | findstr "�j���[�X ��" >NUL
set ServerTarget="\\NAS702258\video\" ::���ʂȃX�y�[�X������Ȃ��悤�Ɂh�ň͂�
rem �ۑ���̃T�[�o�[�A�h���X�B�܂��A�ϐ��̓��e��esult.txt�ɏ����o���Ă��玟�ɐi�݂܂��B
echo %encodedFile% >> F:\MP4Encoded1\result.txt
echo %ServerTarget%����\ >> F:\MP4Encoded1\result.txt
rem move "%encodedFile%" "%ServerTarget%�j���[�X\"  >> F:\MP4Encoded1\result.txt 2>>&1
echo "Line-23" >> F:\MP4Encoded1\result.txt 2>>&1
if not ERRORLEVEL 1 (
    echo "Line-25" >> F:\MP4Encoded1\result.txt 2>>&1
    move "%encodedFile%" "%ServerTarget%�j���[�X\"  >> F:\MP4Encoded1\result.txt 2>>&1
) else (
    echo $FileName$ | findstr "�Γ_ ����" >NUL
    echo "Line-29" >> F:\MP4Encoded1\result.txt 2>>&1
    if not ERRORLEVEL 1 (
        move "%encodedFile%" "%ServerTarget%����E�Γ_\"  >> F:\MP4Encoded1\result.txt 2>>&1
        )  else (
            echo $FileName$ | findstr "���� �O���� ��������" >NUL
            echo "Line-34" >> F:\MP4Encoded1\result.txt 2>>&1
            if not ERRORLEVEL 1 (
                move "%encodedFile%" "%ServerTarget%�����E�O����\"  >> F:\MP4Encoded1\result.txt 2>>&1
                ) else (
                echo $FileName$ | findstr "�f�� �V�l�} ���[�h�V���[ [�f]" >NUL
                echo "Line-39" >> F:\MP4Encoded1\result.txt 2>>&1
                if not ERRORLEVEL 1 (
                    move "%encodedFile%" "%ServerTarget%�f��\"  >> F:\MP4Encoded1\result.txt 2>>&1
                    ) else (
                    echo $FileName$ | findstr "�V�����񂢂�����Ⴂ �����" >NUL
                    echo "Line-44" >> F:\MP4Encoded1\result.txt 2>>&1
                    if not ERRORLEVEL 1 (
                        move "%encodedFile%" "%ServerTarget%�o���G�e�B\"  >> F:\MP4Encoded1\result.txt 2>>&1
                    ) else (
                        echo $FileName$ | findstr "�v���O���~���O" >NUL
                        echo "Line-49" >> F:\MP4Encoded1\result.txt 2>>&1
                        if not ERRORLEVEL 1 (
                            move "%encodedFile%" "%ServerTarget%programing\"  >> F:\MP4Encoded1\result.txt 2>>&1
                        ) else (
                            move "%encodedFile%" "%ServerTarget%New\"  >> F:\MP4Encoded1\result.txt 2>>&1

                )
            )
    )
)
echo ======================================== >> F:\MP4Encoded1\result.txt 2>>&1
