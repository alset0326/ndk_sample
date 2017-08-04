LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE	:= ndk_sample
LOCAL_SRC_FILES := $(subst $(LOCAL_PATH)/,,$(wildcard $(LOCAL_PATH)/*.c))
# LOCAL_CFLAGS += -fno-stack-protector # for disable stack protector
LOCAL_CFLAGS += -fvisibility=hidden # hide symbols without JNIEXPORT
# LOCAL_ARM_MODE := arm
# LOCAL_SHARED_LIBRARIES += libbinder libutils liblog libdl
# LOCAL_C_INCLUDES += $(LOCAL_PATH)/include
# LOCAL_LDLIBS += -L$(SYSROOT)/usr/lib -llog # for additional linker flags
# LOCAL_LDFLAGS += -static # not always work

# Used to auto satisfy macro
DEBUG	:= true
EXE		:= true

ifeq ($(DEBUG),true)
	LOCAL_CFLAGS += -D DEBUG
	ifneq ($(EXE),true)
		LOCAL_LDLIBS += -llog
	endif		
endif

ifeq ($(EXE),true)
	LOCAL_CFLAGS += -D EXE
	include $(BUILD_EXECUTABLE)
else
	include $(BUILD_SHARED_LIBRARY)
endif
