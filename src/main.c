#include <stdio.h>
#include <stdint.h>

#include "convert_time.h"

int main(void) {
    const char* tests[] = {
        "12:30",
        "1:30",
        "00:00",
        "23:59",
        "9:05",
        NULL
    };

    for (int i = 0; tests[i] != NULL; i++) {
        uint16_t packed = ConvertStrTimeToInt(tests[i]);

        printf("%s -> %u:%02u (packed 0x%04X)\n",
               tests[i],
               (unsigned)TimeHour(packed),
               (unsigned)TimeMinute(packed),
               (unsigned)packed);
    }

    return 0;
}
