# HITS - Compiled Version for Windows

This folder contains the compiled version of HITS for Windows 32-bit.

## Files
- `HITS.EXE` - Main executable (Windows 32-bit)
- `HITS.PAK` - Game data package (3.6 MB)
- `DIV32RUN.DLL` - DIV Games Studio runtime library
- `HITS.ICO` - Game icon
- `HITS.PIF` - Windows shortcut configuration

## How to Play

### Option 1: Direct Execution (Windows 32-bit only)

**Important:** This version requires the DIV32RUN.DLL to be accessible. You have two options:

1. Copy `DIV32RUN.DLL` to `C:\Windows\System32\` (requires administrator privileges)
2. Keep `DIV32RUN.DLL` in the same folder as `HITS.EXE`

Then simply run `HITS.EXE`

**Note:** This version may not work on Windows 10/11 64-bit without compatibility mode or DOSBox.

### Option 2: Using DOSBox (Recommended for modern systems)

For the best compatibility on modern Windows, use the DOS version located in the `HITS` folder at the repository root instead.

```bash
dosbox -c "mount c path\to\Avalon" -c "c:" -c "cd HITS" -c "Hits.exe"
```

## About This Version

This is the Windows 32-bit compiled version created with DIV Games Studio. It was designed for Windows 95/98/ME/2000/XP and may have compatibility issues with modern 64-bit operating systems.

For maximum compatibility and authentic retro experience, we recommend using the DOS version with DOSBox.
