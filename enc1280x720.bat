ping localhost -n 20 >nul:
::  0��1280 x 720��16:9  ��crf 22��de-interlace��copy      ��Tssplit���s�����l�[�����{���ʏ�I��
::  1�� 720 x 480�� 4:3  ��crf 20���C���^���ێ���neroAacEnc��Tssplit���������l�[��������Shutdown
::  2�� 854 x 480��      ��crf 24��H265,de-int ��������MUX ��           ��_enc��t�^  ��
::  3�� 640 x 480��      ��crf 26��nv264,deint ��AudioOnly ��           ��_old���쐬  ��
::  4�� 960 x 540��      ��crf 28��nv265,deint ��          ��           ��            ��
::  5�� 854 x 480��      ��crf 30��            ��          ��           ��            ��
::  6�� 480 x 270��      ��      ��            ��          ��           ��            ��
::  7��1920 x1080��      ��      ��            ��          ��           ��            ��
:: ��1���ڂɂ�0������B���ۂ̃p�����[�^��2���ڂ���L��
::           012345678
set exeparam=000020000
set EDCB=1
call "C:\Users\haya_\Desktop\TV\encode.bat" "$FilePath$"
