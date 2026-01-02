# timeparse-masm

Tiny MASM x64 example that parses a time string like `"12:30"` or `"1:30"` and returns a packed 16-bit value:

- `AH` = hour
- `AL` = minute

The goal is intentionally small: one MASM function + a C harness.

## What this repo contains

- `src/convert_time.asm` - `ConvertStrTimeToInt(const char* s)` (MASM, x86-64)
- `src/main.c` - small test harness
- `scripts/build.ps1` - local build + smoke test
- `.github/workflows/release.yml` - CI build (PRs / main pushes) + release on tags
- `docs/WHY.md` - "why this setup" with pointers to official docs

## Build locally (Windows)

Prereq: Visual Studio (or "Build Tools for Visual Studio") with the **Desktop development with C++** workload (so you have `cl`, `link`, and `ml64`).

1. Open **x64 Native Tools Command Prompt** (or run the equivalent `vcvars64.bat`).
2. From repo root:

```bat
scripts\build.cmd
```

Output:

- `build\timeparse.exe`

## CI / Releases

- Every PR and push to `main` builds and runs the smoke test.
- Pushing a tag like `v0.1.0` additionally creates a GitHub Release and attaches:
  - `timeparse.exe`
  - `timeparse.exe.sha256`

See `docs/WHY.md` for the official doc links.
