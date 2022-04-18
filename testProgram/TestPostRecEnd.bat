rem _EDCBX_DIRECT_
ffmpeg -y -hide_banner -nostats -fflags +discardcorrupt -i "E:\Media2-1\201901112205000102-A•¨‚Ì‰ÈŠw@‘æ14‰ñuŒ»‘ãĞ‰ï‚ÆA•¨‰ÈŠwv.ts"      -c:a aac -vf yadif=0:-1:1,hqdn3d=4.0,scale=1280:720,unsharp=3:3:0.5:3:3:0.5:0 -global_quality 27 -c:v h264_qsv -preset:v veryslow -g 300 -bf 16 -refs 9 -b_strategy 1 -look_ahead 1 -look_ahead_downsampling off -pix_fmt nv12 -bsf:v h264_metadata=colour_primaries=1:transfer_characteristics=1:matrix_coefficients=1 -map 0:p:%SID10%:0 -map 0:p:%SID10%:1 -movflags +faststart "F:\MP4Encoded1\test.mp4" > F:\MP4Encoded1\result.txt 2>&1
pause
