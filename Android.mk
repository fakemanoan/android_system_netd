BUILD_NETD := false
ifneq ($(TARGET_SIMULATOR),true)
    BUILD_NETD := true
endif

ifeq ($(BUILD_NETD),true)

LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES:=                                      \
                  BandwidthController.cpp              \
                  CommandListener.cpp                  \
                  DnsProxyListener.cpp                 \
                  NatController.cpp                    \
                  NetdCommand.cpp                      \
                  NetlinkHandler.cpp                   \
                  NetlinkManager.cpp                   \
                  PanController.cpp                    \
                  PppController.cpp                    \
                  SoftapController.cpp                 \
                  TetherController.cpp                 \
                  ThrottleController.cpp               \
                  UsbController.cpp                    \
                  logwrapper.c                         \
                  main.cpp                             \



LOCAL_MODULE:= netd

LOCAL_C_INCLUDES := $(KERNEL_HEADERS) \
                    $(LOCAL_PATH)/../bluetooth/bluedroid/include \
                    $(LOCAL_PATH)/../bluetooth/bluez-clean-headers \
                    external/openssl/include \
                    external/stlport/stlport \
                    bionic

LOCAL_CFLAGS :=
ifdef WIFI_DRIVER_FW_STA_PATH
LOCAL_CFLAGS += -DWIFI_DRIVER_FW_STA_PATH=\"$(WIFI_DRIVER_FW_STA_PATH)\"
endif
ifdef WIFI_DRIVER_FW_AP_PATH
LOCAL_CFLAGS += -DWIFI_DRIVER_FW_AP_PATH=\"$(WIFI_DRIVER_FW_AP_PATH)\"
endif

LOCAL_SHARED_LIBRARIES := libstlport libsysutils libcutils libnetutils libcrypto

ifeq ($(BOARD_HAVE_BLUETOOTH),true)
  LOCAL_SHARED_LIBRARIES := $(LOCAL_SHARED_LIBRARIES) libbluedroid
  LOCAL_CFLAGS := $(LOCAL_CFLAGS) -DHAVE_BLUETOOTH
endif

include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_SRC_FILES:=          \
                  ndc.c \

LOCAL_MODULE:= ndc

LOCAL_C_INCLUDES := $(KERNEL_HEADERS)

LOCAL_CFLAGS := 

LOCAL_SHARED_LIBRARIES := libcutils

include $(BUILD_EXECUTABLE)

endif # ifeq ($(BUILD_NETD,true)
