@echo off

rem �ϐ��uhensu�v�ɕ�����u��肿���ۂ�v����
set hensu=��肿���ۂ�
set resultFile=resultTest.txt 

rem �ϐ��uhensu�v�̒��g���m�F
echo �ϐ��uhensu�v�ɂ́u%hensu%�v���������܂����B
echo ����ς�%hensu%     �͂��������Ȃ��B
echo %DATE% %TIME%�@�ɐH�ׂ�%hensu%�͊i�ʂ�

set FileName=���̃j���[�X�@�����̓V�C
echo ======================================== >> F:\MP4Encoded1\%resultFile% 2>>&1
echo %FileName%�@�@�G���R�[�f�B���O��
echo End encoding
echo %FileName%  | find "�j���[�X" >NUL
echo ErrorLevel�́@%ERRORLEVEL%�@�ł� 
if not ERRORLEVEL 1 echo �j���[�X�ł���
echo echo %FileName%  | find "�j���[�X" 
echo ======================================== 
set FileName=���̃j���[�@�����̓V�C
echo %FileName%�@�@�G���R�[�f�B���O��
echo End encode %FileName% >> F:\MP4Encoded1\%resultFile% 2>>&1
echo %FileName%  | find "�j���[�X" >NUL
echo ErrorLevel�́@%ERRORLEVEL%�@�ł� 
if not ERRORLEVEL 1 echo �u%FileName%�v���ړ����܂���

echo ======================================== >> F:\MP4Encoded1\%resultFile% 2>>&1
pause

