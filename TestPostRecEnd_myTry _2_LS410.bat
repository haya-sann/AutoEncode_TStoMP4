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
echo $FileName$��LS410DX3DA��SharedFiles�Ɉړ�  >> F:\MP4Encoded1\result.txt 2>>&1
echo $FileName$ | findstr "�j���[�X ��" >NUL
if not ERRORLEVEL 1 (
    move "%encodedFile%" \\LS410DX3DA\SharedDisk1\SharedFiles\�j���[�X\  >> F:\MP4Encoded1\result.txt 2>>&1
) else (
    echo $FileName$ | findstr "�Γ_ ����" >NUL
    if not ERRORLEVEL 1 (
        move "%encodedFile%" \\LS410DX3DA\SharedDisk1\SharedFiles\����E�Γ_\  >> F:\MP4Encoded1\result.txt 2>>&1
        )  else (
            echo $FileName$ | findstr "���� �O���� ��������" >NUL
            if not ERRORLEVEL 1 (
                move "%encodedFile%" \\LS410DX3DA\SharedDisk1\SharedFiles\�����E�O����\  >> F:\MP4Encoded1\result.txt 2>>&1
                ) else (
                echo $FileName$ | findstr "�f�� �V�l�} ���[�h�V���[ [�f]" >NUL
                if not ERRORLEVEL 1 (
                    move "%encodedFile%" \\LS410DX3DA\SharedDisk1\SharedFiles\�f��\  >> F:\MP4Encoded1\result.txt 2>>&1
                    ) else (
                    echo $FileName$ | findstr "�V�����񂢂�����Ⴂ �����" >NUL
                    if not ERRORLEVEL 1 (
                        move "%encodedFile%" \\LS410DX3DA\SharedDisk1\SharedFiles\�o���G�e�B\  >> F:\MP4Encoded1\result.txt 2>>&1
                    ) else (
                        echo $FileName$ | findstr "�v���O���~���O" >NUL
                        if not ERRORLEVEL 1 (
                            move "%encodedFile%" \\LS410DX3DA\SharedDisk1\SharedFiles\programing\  >> F:\MP4Encoded1\result.txt 2>>&1
                        ) else (
                            move "%encodedFile%" \\LS410DX3DA\SharedDisk1\SharedFiles\New\  >> F:\MP4Encoded1\result.txt 2>>&1

                )
            )
    )
)
echo ======================================== >> F:\MP4Encoded1\result.txt 2>>&1
