#
# Copyright (C) 2018 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Audio
PRODUCT_PROPERTY_OVERRIDES += \
    aaudio.hw_burst_min_usec=2000 \
    aaudio.mmap_exclusive_policy=2 \
    aaudio.mmap_policy=2 \
    audio.offload.min.duration.secs=15 \
    audio.offload.video=true \
    ro.config.media_vol_steps=25 \
    ro.config.vc_call_vol_steps=11

# Bluetooth
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.qcom.bluetooth.a2dp_offload_cap=sbc-aptx-aptxhd-aac-ldac \
    persist.vendor.qcom.bluetooth.enable.splita2dp=true \
    vendor.qcom.bluetooth.soc=cherokee

# Camera
PRODUCT_PROPERTY_OVERRIDES += \
    persist.camera.stats.test=5 \
    persist.camera.xm.green.b=0.96 \
    persist.camera.xm.green.r=0.97 \
    persist.vendor.camera.HAL3.enabled=1 \
    persist.vendor.camera.set.afd=4 \
    vidc.enc.dcvs.extra-buff-count=2

# CNE
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.cne.feature=1

# Display
PRODUCT_PROPERTY_OVERRIDES += \
    debug.sf.enable_gl_backpressure=1 \
    debug.sf.enable_hwc_vds=1 \
    debug.sf.hw=1 \
    debug.sf.latch_unsignaled=1 \
    ro.opengles.version=196610 \
    vendor.display.disable_partial_split=1 \
    vendor.display.disable_rotator_downscale=1 \
    vendor.display.disable_skip_validate=1 \
    vendor.display.enable_default_color_mode=1 \
    vendor.display.perf_hint_window=50 \
    vendor.gralloc.enable_fb_ubwc=1

# DPM
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.dpm.feature=1 \
    persist.vendor.dpm.nsrm.bkg.evt=3955

# FRP
PRODUCT_PROPERTY_OVERRIDES += \
    ro.frp.pst=/dev/block/platform/soc/1da4000.ufshc/by-name/frp

# IMS
PRODUCT_PROPERTY_OVERRIDES += \
    persist.dbg.volte_avail_ovr=1 \
    persist.dbg.vt_avail_ovr=1 \
    persist.vendor.qti.telephony.vt_cam_interface=1

# Media
PRODUCT_PROPERTY_OVERRIDES += \
    debug.stagefright.omx_default_rank.sw-audio=1 \
    debug.stagefright.omx_default_rank=0

# Perf
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.extension_library=libqti-perfd-client.so \
    ro.vendor.qti.core_ctl_max_cpu=4 \
    ro.vendor.qti.core_ctl_min_cpu=0 \
    ro.vendor.qti.sys.fw.bg_apps_limit=60

# Radio
PRODUCT_PROPERTY_OVERRIDES += \
    persist.radio.multisim.config=dsds \
    persist.vendor.data.mode=concurrent \
    persist.vendor.radio.apm_sim_not_pwdn=1 \
    persist.vendor.radio.custom_ecc=1 \
    persist.vendor.radio.force_on_dc=true \
    persist.vendor.radio.rat_on=combine \
    persist.vendor.radio.redir_party_num=1 \
    persist.vendor.radio.report_codec=1 \
    persist.vendor.radio.sib16_support=1 \
    ro.telephony.default_cdma_sub=0 \
    ro.telephony.default_network=22,22 \
    ro.vendor.use_data_netmgrd=true \
    telephony.lteOnCdmaDevice=1 \
    vendor.rild.libpath=/vendor/lib64/libril-wrapper.so \
    vendor.voice.path.for.pcm.voip=true

# Sensors
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.sdk.sensors.gestures=false \
    ro.vendor.sensors.cfos=false \
    ro.vendor.sensors.cmc=false \
    ro.vendor.sensors.dev_ori=false \
    ro.vendor.sensors.dpc=true \
    ro.vendor.sensors.facing=false \
    ro.vendor.sensors.iod=false \
    ro.vendor.sensors.mot_detect=true \
    ro.vendor.sensors.multishake=true \
    ro.vendor.sensors.pmd=false \
    ro.vendor.sensors.pug=true \
    ro.vendor.sensors.spg=false \
    ro.vendor.sensors.sta_detect=true \
    ro.vendor.sensors.taptap_gesture=true

# SurfaceFlinger
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.surface_flinger.force_hwc_copy_for_virtual_displays=true \
    ro.surface_flinger.max_virtual_display_dimension=4096 \
    ro.surface_flinger.protected_contents=true \
    ro.surface_flinger.vsync_event_phase_offset_ns=2000000 \
    ro.surface_flinger.vsync_sf_event_phase_offset_ns=6000000

PRODUCT_PROPERTY_OVERRIDES += \
    debug.sf.early_phase_offset_ns=1500000 \
    debug.sf.early_app_phase_offset_ns=1500000 \
    debug.sf.early_gl_phase_offset_ns=3000000 \
    debug.sf.early_gl_app_phase_offset_ns=15000000

# Time services
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.delta_time.enable=true

# WFD
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.wfd.virtual=0

# Wlan
PRODUCT_PROPERTY_OVERRIDES += \
    wifi.interface=wlan0
