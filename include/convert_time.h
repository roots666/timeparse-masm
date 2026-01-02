#pragma once

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

// Returns a packed 16-bit value:
//   high byte (bits 15..8)  = hour
//   low  byte (bits 7..0)   = minute
uint16_t ConvertStrTimeToInt(const char* timeAsString);

static inline uint8_t TimeHour(uint16_t packed)   { return (uint8_t)(packed >> 8); }
static inline uint8_t TimeMinute(uint16_t packed) { return (uint8_t)(packed & 0xFF); }

#ifdef __cplusplus
}
#endif
