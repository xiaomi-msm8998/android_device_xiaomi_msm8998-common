LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := android.hardware.vibrator@1.1-service.sagit
LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_INIT_RC := android.hardware.vibrator@1.1-service.sagit.rc

LOCAL_SRC_FILES := \
    service.cpp \
    Vibrator.cpp

LOCAL_SHARED_LIBRARIES := \
    libbase \
    libhardware \
    libhidlbase \
    libhidltransport \
    libhwbinder \
    libutils \
    android.hardware.vibrator@1.0 \
    android.hardware.vibrator@1.1

LOCAL_PROPRIETARY_MODULE := true

include $(BUILD_EXECUTABLE)

include $(call all-makefiles-under,$(LOCAL_PATH))
