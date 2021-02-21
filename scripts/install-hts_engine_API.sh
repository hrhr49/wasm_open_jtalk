#!/usr/bin/env bash
set -eu

HERE=$(cd $(dirname $0); pwd)

TOOL_DIR="$HERE/../tools"
EMSDK_DIR="$TOOL_DIR/emsdk"
HTS_ENGINE_API_DIR="$TOOL_DIR/hts_engine_API"

mkdir -p "$TOOL_DIR"

if [ ! -d "$HTS_ENGINE_API_DIR" ]; then
    git clone https://github.com/r9y9/hts_engine_API.git "$HTS_ENGINE_API_DIR"
fi

# fgetposのところでビルドエラーになるのを回避
cat << EOS | patch "$HTS_ENGINE_API_DIR/src/lib/HTS_misc.c"
@@ -243,13 +243,14 @@ size_t HTS_ftell(HTS_File * fp)
    if (fp == NULL) {
       return 0;
    } else if (fp->type == HTS_FILE) {
-      fpos_t pos;
-      fgetpos((FILE *) fp->pointer, &pos);
-#if defined(_WIN32) || defined(__CYGWIN__) || defined(__APPLE__) || defined(__ANDROID__)
-      return (size_t) pos;
-#else
-      return (size_t) pos.__pos;
-#endif                          /* _WIN32 || __CYGWIN__ || __APPLE__ || __ANDROID__ */
+       return ftell(fp->pointer);
+//      fpos_t pos;
+//      fgetpos((FILE *) fp->pointer, &pos);
+//#if defined(_WIN32) || defined(__CYGWIN__) || defined(__APPLE__) || defined(__ANDROID__)
+//      return (size_t) pos;
+//#else
+//      return (size_t) pos.__pos;
+//#endif                          /* _WIN32 || __CYGWIN__ || __APPLE__ || __ANDROID__ */
    } else if (fp->type == HTS_DATA) {
       HTS_Data *d = (HTS_Data *) fp->pointer;
       return d->index;
EOS

BUILD_DIR="$HTS_ENGINE_API_DIR/src/build"

mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

# emsdkのコマンドにPATHを通す
source "$EMSDK_DIR/emsdk_env.sh"

emcmake cmake -DCMAKE_INSTALL_PREFIX=../.. ..
emmake make -j
emmake make install
