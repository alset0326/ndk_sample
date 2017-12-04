LOCAL_PATH := $(call my-dir)

####################################################################
# Used to auto satisfy macro
MY_DEBUG	:= true
MY_EXE		:= true

ifeq ($(MY_DEBUG),true)
	MY_CFLAGS += -D DEBUG
	ifneq ($(MY_EXE),true)
		MY_LDLIBS += -llog
	endif		
endif
ifeq ($(MY_EXE),true)
	MY_CFLAGS += -D EXE
endif

# MY_CFLAGS += -fno-stack-protector # for disable stack protector
MY_CFLAGS += -fvisibility=hidden # hide symbols without JNIEXPORT
MY_CFLAGS += -ffunction-sections -fdata-sections # remove unused function or data

MY_LDFLAGS += -Wl,--gc-sections # remove unused function or data while link
# MY_LDFLAGS += -static # static compile, not always work

# MY_LDLIBS += -L$(SYSROOT)/usr/lib # for additional linker flags

# MY_C_INCLUDES += $(LOCAL_PATH)/include

####################################################################

include $(CLEAR_VARS) # clear LOCAL_XXX except LOCAL_PATH
LOCAL_MODULE	:= ndk_sample
LOCAL_SRC_FILES := $(subst $(LOCAL_PATH)/,,$(wildcard $(LOCAL_PATH)/*.c))
LOCAL_CFLAGS += $(MY_CFLAGS)
LOCAL_LDFLAGS += $(MY_LDFLAGS)
LOCAL_LDLIBS +=  $(MY_LDLIBS)
LOCAL_C_INCLUDES += $(MY_C_INCLUDES)
# LOCAL_ARM_MODE := arm
# LOCAL_SHARED_LIBRARIES += libbinder libutils liblog libdl

ifeq ($(MY_EXE),true)
	include $(BUILD_EXECUTABLE)
else
	include $(BUILD_SHARED_LIBRARY)
endif
