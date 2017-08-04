#include <stdio.h>
#include <stdlib.h>

#ifdef EXE
//////////////// start of print function used in exe ////////////////
#define info(...)                                                              \
  fprintf(stderr, "INFO %d:\t", __LINE__);                                     \
  fprintf(stderr, __VA_ARGS__);
#define error(...)                                                             \
  fprintf(stderr, "ERR %d: \t", __LINE__);                                     \
  fprintf(stderr, __VA_ARGS__);

#ifdef DEBUG
#define DINFO(...) info(__VA_ARGS__)
#define DERROR(...) error(__VA_ARGS__)
#else
#define DINFO(...) ((void)0)
#define DERROR(...) ((void)0)
#endif
//////////////// end of print function used in exe ////////////////
#else
//////////////// start of print function used in so ////////////////
#include <android/log.h>

#ifndef LOG_TAG
#define LOG_TAG "ndk_sample"
#endif

#define LOGI(...) __android_log_print(ANDROID_LOG_INFO, LOG_TAG, __VA_ARGS__)
#define LOGE(...) __android_log_print(ANDROID_LOG_ERROR, LOG_TAG, __VA_ARGS__)

#ifdef DEBUG
#define DINFO(...) LOGI(__VA_ARGS__)
#define DERROR(...) LOGE(__VA_ARGS__)
#else
#define DINFO(...) ((void)0)
#define DERROR(...) ((void)0)
#endif
//////////////// end of print function used in so ////////////////
#endif

#ifdef EXE
int main(int argc, char *argv[]) {
  DINFO("test\n");
  return 0;
}
#endif
