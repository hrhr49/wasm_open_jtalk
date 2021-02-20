node js/open_jtalk.js \
-x etc/naist-jdic \
-m etc/mei_normal.htsvoice \
-r 1.0 \
-ow tmp.wav \
etc/sample.txt

# cp -r etc/naist-jdic js/
# cp -r etc/mei_normal.htsvoice js/
# cd js
# echo "おはよう" \
#     | node open_jtalk.js \
#     -x naist-jdic \
#     -m mei_normal.htsvoice \
#     -r 1.0 \
#     -ow tmp.wav
