rem _EDCBX_DIRECT_
ffmpeg -y -i "E:\Media2-1\201901112205000102-�A���̉Ȋw�@��14��u����Љ�ƐA���Ȋw�v.ts" -vcodec h264_qsv -q 23 -look_ahead 0 -acodec aac -loglevel error "F:\MP4Encoded1\test.mp4"
rem ffmpeg -y -i "%FilePath%" -vcodec h264_qsv -q 23 -look_ahead 0 -acodec aac -loglevel error "F:\MP4Encoded1\%FileName%.mp4"
rem pause
