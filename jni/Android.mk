LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS) # clear LOCAL_XXX except LOCAL_PATH

# Build options
LOCAL_MODULE	:= ndk_sample
# LOCAL_MODULE_FILENAME := sample # rename output file
# LOCAL_PCH := pch.h # precompiled headers
LOCAL_SRC_FILES := $(subst $(LOCAL_PATH)/,,$(wildcard $(LOCAL_PATH)/*.c))

# Misc CFLAGS options
# LOCAL_CFLAGS += -fno-stack-protector # for disable stack protector
LOCAL_CFLAGS += -fvisibility=hidden # hide symbols without JNIEXPORT
LOCAL_CFLAGS += -ffunction-sections -fdata-sections # remove unused function or data
# LOCAL_CFLAGS += -mstackrealign # keep 4-byte stack alignment with modern codes OR keep 16-byte stack alignment for SSE compatibility
# LOCAL_CFLAGS += -fno-asynchronous-unwind-tables # emit frame informations which would decrease size

# Misc LDFLAGS options
LOCAL_LDFLAGS += -Wl,--gc-sections # remove unused function or data while link
# LOCAL_LDFLAGS += -static # static compile, not always work

# Misc LDLIBS options
# LOCAL_LDLIBS += -L$(SYSROOT)/usr/lib # for additional linker flags

# AddressSanitizer support flags
# LOCAL_CFLAGS += -fsanitize=address -fno-omit-frame-pointer # AddressSanitizer support
# LOCAL_LDFLAGS += -fsanitize=address # AddressSanitizer support

# OLLVM support flags
# LOCAL_CFLAGS += -mllvm -fla -mllvm -sub -mllvm -bcf # OLLVM support

# Native activity flags
# LOCAL_LDLIBS+= -landroid -lEGL -lGLESv1_CM # Native activity support
# LOCAL_STATIC_LIBRARIES:= android_native_app_glue # Native activity support

# Other flags
# LOCAL_ARM_MODE := arm # compile mode support
# LOCAL_SHARED_LIBRARIES += libbinder libutils liblog libdl
# LOCAL_C_INCLUDES += $(LOCAL_PATH)/include # additional header support


# Used to auto satisfy macro
MY_DEBUG	:= true
MY_EXE		:= true

ifeq ($(MY_DEBUG),true)
	LOCAL_CFLAGS += -D DEBUG
	ifneq ($(MY_EXE),true)
		LOCAL_LDLIBS += -llog
	endif		
endif
ifeq ($(MY_EXE),true)
	LOCAL_CFLAGS += -D EXE
endif


ifeq ($(MY_EXE),true)
	include $(BUILD_EXECUTABLE)
else
	include $(BUILD_SHARED_LIBRARY)
endif
