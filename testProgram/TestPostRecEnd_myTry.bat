rem _EDCBX_DIRECT_
ffmpeg -y -i "E:\Media2-1\201901112205000102-植物の科学　第14回「現代社会と植物科学」.ts" -vcodec h264_qsv -q 23 -look_ahead 0 -acodec aac -loglevel error "F:\MP4Encoded1\test.mp4"
rem ffmpeg -y -i "%FilePath%" -vcodec h264_qsv -q 23 -look_ahead 0 -acodec aac -loglevel error "F:\MP4Encoded1\%FileName%.mp4"
rem pause
