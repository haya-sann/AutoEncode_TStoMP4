 rem  h264_qsv ���g���ăG���R�[�f�B���O
ECHO ���ݎ��s���̃t�@�C������%~nx0 >> F:\MP4Encoded1\result.txt 2>>&1
ECHO %DATE% %TIME%  >> F:\MP4Encoded1\result.txt 2>>&1
echo ========================================  >> F:\MP4Encoded1\result.txt 2>>&1
set FilePath = "E:\Media2-1\�T������܂ƃ}�c�R�N�ɂ��G����Ȃ�!�H�Y�ꋎ��ꂽ�|�\�j���[�X��O�꒲��.ts"
echo %FilePath%
echo %FilePath% >> F:\MP4Encoded1\result.txt 2>>&1
echo.   >> F:\MP4Encoded1\result.txt 2>>&1
set FileName = "�T������܂ƃ}�c�R�N�ɂ��G����Ȃ�!�H�Y�ꋎ��ꂽ�|�\�j���[�X��O�꒲��"
echo %FileName% >> F:\MP4Encoded1\result.txt 2>>&1
echo %FileName%
set encodedFile=F:\MP4Encoded1\$SDYYYY$$SDMM$$SDDD$$STHH$$STMM$%FileName%.mp4
echo ======================================== >> F:\MP4Encoded1\result.txt 2>>&1
ffmpeg -y -i %FilePath% -vcodec h264_qsv -q 23 -look_ahead 0 -acodec aac -loglevel error %encodedFile% >> F:\MP4Encoded1\result.txt 2>>&1
echo End encoding >> F:\MP4Encoded1\result.txt 2>>&1
if not ERRORLEVEL 1 (
    move %FilePath% E:\Media2-1\toBeTrash   >> F:\MP4Encoded1\result.txt 2>>&1
)
echo %FileName% | find "�j���[�X" >NUL
if not ERRORLEVEL 1 (
    move %encodedFile% \\LS410DX3DA\SharedDisk1\SharedFiles\�j���[�X\  >> F:\MP4Encoded1\result.txt 2>>&1
) else (
    echo %FileName% | find "�Γ_" >NUL
    if not ERRORLEVEL 1 (
        move %encodedFile% \\LS410DX3DA\SharedDisk1\SharedFiles\����E�Γ_\  >> F:\MP4Encoded1\result.txt 2>>&1
    )  else (
            echo %FileName% | find "�V�����񂢂�����Ⴂ" >NUL
            if not ERRORLEVEL 1 (
                move %encodedFile% \\LS410DX3DA\SharedDisk1\SharedFiles\�o���G�e�B\  >> F:\MP4Encoded1\result.txt 2>>&1
            ) else (
                echo %FileName% | find "�v���O���~���O" >NUL
                if not ERRORLEVEL 1 (
                    move %encodedFile% \\LS410DX3DA\SharedDisk1\SharedFiles\programing\  >> F:\MP4Encoded1\result.txt 2>>&1
                ) else (
                    move %encodedFile% \\LS410DX3DA\SharedDisk1\SharedFiles\New\  >> F:\MP4Encoded1\result.txt 2>>&1

                )
            )
    )
)
echo ======================================== >> F:\MP4Encoded1\result.txt 2>>&1

