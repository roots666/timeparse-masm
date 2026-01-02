# Why this setup?

This repo is intentionally "boring" and explicit so you can copy/paste it into other tiny MASM experiments.

## ABI / calling convention

We keep the assembly function C-callable by following the Windows x64 calling convention:

- first integer/pointer arg comes in `RCX`
- integer return value comes back in `RAX`

Official reference:

- <https://learn.microsoft.com/en-us/cpp/build/x64-calling-convention?view=msvc-170>

That's why the MASM function takes `RCX = const char*` and returns a small integer in `RAX`.

## Return format

For the demo we pack the result into a 16-bit value (returned in the low bits of `RAX`):

- `AH` = hour
- `AL` = minute

This makes the C harness dead-simple and keeps the function "leaf" (no stack frame).

## `ml64` + `cl` + `link`

These are the standard Microsoft toolchain pieces for x64:

- `ml64.exe` assembles MASM for x64
- `cl.exe` compiles C
- `link.exe` links the objects into an `.exe`

Official references:

- MASM for x64 (ml64.exe): <https://learn.microsoft.com/en-us/cpp/assembler/masm/masm-for-x64-ml64-exe?view=msvc-170>
- ML and ML64 command line reference: <https://learn.microsoft.com/en-us/cpp/assembler/masm/ml-and-ml64-command-line-reference?view=msvc-170>
- MSVC command-line environment: <https://learn.microsoft.com/en-us/cpp/build/building-on-the-command-line?view=msvc-170>
