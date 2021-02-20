# Espnet2のTTSデモより引用
# TODO: 修正
# cd tools && git clone https://github.com/r9y9/open_jtalk.git
# mkdir -p tools/open_jtalk/src/build && cd tools/open_jtalk/src/build && \
#    cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON \
#        -DHTS_ENGINE_LIB=../../../hts_engine_API/lib \
#        -DHTS_ENGINE_INCLUDE_DIR=../../../hts_engine_API/include .. && \
#    make install
# cp tools/open_jtalk/src/build/*.so* /usr/lib64-nvidia
# cd tools && git clone https://github.com/r9y9/pyopenjtalk.git
# cd tools/pyopenjtalk && pip install .
