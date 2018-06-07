/*
 * Copyright (C) 2017-2018 The LineageOS Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define LOG_TAG "VibratorService"

#include <cmath>
#include <fstream>

#include <android-base/logging.h>

#include "Vibrator.h"

namespace android {
namespace hardware {
namespace vibrator {
namespace V1_1 {
namespace implementation {

#define VIBRATOR "/sys/devices/virtual/timed_output/vibrator/"

#define ENABLE      "enable"
#define VTG_DEFAULT "vtg_default"
#define VTG_MIN     "vtg_min"
#define VTG_MAX     "vtg_max"
#define VTG_LEVEL   "vtg_level"

#define CLICK_TIMING_MS 40
#define TICK_TIMING_MS 20

#define DEFAULT_MIN_VTG 1
#define DEFAULT_MAX_VTG 255

using Status = ::android::hardware::vibrator::V1_0::Status;
using EffectStrength = ::android::hardware::vibrator::V1_0::EffectStrength;

static int get(std::string path, int defaultValue) {
    int value = defaultValue;
    std::ifstream file(path);

    if (!file) {
        LOG(ERROR) << "Failed to open " << path;
        return value;
    }

    file >> value;

    if (!file) {
        LOG(ERROR) << "Failed to read value from " << path;
    }

    return value;
}

static int set(std::string path, int value) {
    std::ofstream file(path);

    if (!file) {
        LOG(ERROR) << "Failed to open " << path;
        return -1;
    }

    file << value;

    if (!file) {
        LOG(ERROR) << "Failed to write " << value << " to " << path;
        return -1;
    }

    return 0;
}

Vibrator::Vibrator() {
    minVoltage = get(VIBRATOR VTG_MIN, DEFAULT_MIN_VTG);
    maxVoltage = get(VIBRATOR VTG_MAX, DEFAULT_MAX_VTG);
}

// Methods from ::android::hardware::vibrator::V1_0::IVibrator follow.
Return<Status> Vibrator::on(uint32_t timeout_ms) {
    if (set(VIBRATOR ENABLE, timeout_ms)) {
        return Status::UNKNOWN_ERROR;
    }

    return Status::OK;
}

Return<Status> Vibrator::off()  {
    if (set(VIBRATOR ENABLE, 0)) {
        return Status::UNKNOWN_ERROR;
    }

    return Status::OK;
}

Return<bool> Vibrator::supportsAmplitudeControl()  {
    return true;
}

Return<Status> Vibrator::setAmplitude(uint8_t amplitude) {
    if (amplitude == 0) {
        return Status::BAD_VALUE;
    }

    /*
     * Scale the voltage such that an amplitude of 1 is minVoltage
     * and an amplitude of 255 is maxVoltage.
     */
    uint32_t ledge = std::lround((maxVoltage - minVoltage) / 4);
    uint32_t level = get(VIBRATOR VTG_LEVEL, (maxVoltage - ledge));
    uint32_t loVoltage = ((level > ledge) && ((level - ledge) > minVoltage)) ? (level - ledge) : minVoltage;
    uint32_t hiVoltage = ((level + ledge) < maxVoltage) ? (level + ledge) : maxVoltage;
    uint32_t voltage =
            std::lround((amplitude - 1) / 254.0 * (hiVoltage - loVoltage) + loVoltage);

    if (set(VIBRATOR VTG_DEFAULT, voltage)) {
        return Status::UNKNOWN_ERROR;
    }

    LOG(INFO) << "setAmplitude " << +amplitude << " -> got level " << level << " -> voltage set to " << voltage;

    return Status::OK;
}

static uint8_t convertEffectStrength(EffectStrength strength) {
    uint8_t amplitude;

    switch (strength) {
    case EffectStrength::LIGHT:
        amplitude = 1;
        break;
    case EffectStrength::MEDIUM:
        amplitude = 128;
        break;
    default:
    case EffectStrength::STRONG:
        amplitude = 255;
        break;
    }

    return amplitude;
}

Return<void> Vibrator::perform(Effect effect, EffectStrength strength,
        perform_cb _hidl_cb) {
    if (effect == Effect::CLICK) {
        on(CLICK_TIMING_MS);
        setAmplitude(convertEffectStrength(strength));
        _hidl_cb(Status::OK, CLICK_TIMING_MS);
    } else {
        _hidl_cb(Status::UNSUPPORTED_OPERATION, 0);
    }
    return Void();
}

// Methods from ::android::hardware::vibrator::V1_1::IVibrator follow.
Return<void> Vibrator::perform_1_1(Effect_1_1 effect, EffectStrength strength,
        perform_cb _hidl_cb) {
    if (effect == Effect_1_1::TICK) {
        on(TICK_TIMING_MS);
        setAmplitude(convertEffectStrength(strength));
        _hidl_cb(Status::OK, TICK_TIMING_MS);
        return Void();
    } else if (effect < Effect_1_1::TICK) {
        return perform(static_cast<Effect>(effect), strength, _hidl_cb);
    } else {
        _hidl_cb(Status::UNSUPPORTED_OPERATION, 0);
        return Void();
    }
}

}  // namespace implementation
}  // namespace V1_1
}  // namespace vibrator
}  // namespace hardware
}  // namespace android
