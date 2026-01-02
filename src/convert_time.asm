OPTION CASEMAP:none

; ConvertStrTimeToInt
;   RCX = const char* timeAsString  ("H:MM" or "HH:MM")
;   Returns: AX packed as [AH=hour, AL=minute]
; Notes:
;   - Assumes input is valid.
;   - Windows x64 calling convention: first arg in RCX, return in RAX.

.code

PUBLIC ConvertStrTimeToInt
ConvertStrTimeToInt PROC

    ; hour = s[0] - '0'
    movzx eax, byte ptr [rcx]
    sub eax, '0'

    ; if s[1] == ':' then it's a 1-digit hour
    movzx edx, byte ptr [rcx+1]
    cmp dl, ':'
    je  one_digit_hour

    ; two-digit hour: hour = (s[0]-'0')*10 + (s[1]-'0')
    imul eax, eax, 10
    sub edx, '0'
    add eax, edx

    ; minutes at s[3], s[4]
    movzx edx, byte ptr [rcx+3]    ; tens
    sub edx, '0'
    imul edx, edx, 10
    movzx r8d, byte ptr [rcx+4]   ; ones
    sub r8d, '0'
    add edx, r8d
    jmp pack

one_digit_hour:
    ; minutes at s[2], s[3]
    movzx edx, byte ptr [rcx+2]    ; tens
    sub edx, '0'
    imul edx, edx, 10
    movzx r8d, byte ptr [rcx+3]   ; ones
    sub r8d, '0'
    add edx, r8d

pack:
    ; pack result as AH=hour, AL=minute
    shl eax, 8
    and edx, 0FFh
    or  eax, edx
    ret

ConvertStrTimeToInt ENDP

END
