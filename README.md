# Ollama Vulkan for Windows

This project builds [Ollama](https://github.com/ollama/ollama) for Windows x64 with the Vulkan backend enabled.

## Download

Download the latest portable ZIP or EXE installer from the project's [Releases](https://github.com/jarsXk/ollama-vulkan/releases). 
Release versions are based on the upstream Ollama tag.

## Install

Run the downloaded EXE installer and follow its prompts. The installer can
create Start Menu and desktop shortcuts and add the install directory to your
user `PATH`. Configure these options and the Start Menu folder name together
on one installer page. The desktop shortcut is not selected by default.

Alternatively, extract the portable ZIP to a folder and run
`start-ollama.cmd`. The portable package does not add itself to `PATH`.

## Run

`start-ollama.cmd` starts `ollama.exe serve` in a minimized command window.

The server listens on `127.0.0.1:11434`, so it is available only from the
local machine by default. Models are stored in
`%USERPROFILE%\.ollama\models`.

For example, with the server running, use the Ollama CLI to download and run a
model:

```powershell
.\ollama.exe pull llama3.2
.\ollama.exe run llama3.2
```

Run these commands from the directory containing `ollama.exe`. If you selected
the installer option to add Ollama to `PATH`, you can use `ollama` instead.

## Build details

The Windows x64 build uses Go and the Vulkan SDK. CMake is configured with
`OLLAMA_LLAMA_BACKENDS=vulkan`; the resulting package contains the executable,
native runtime payload, and launcher script.

## Runtime settings

The startup script sets these environment variables for the Ollama server:

| Variable | Value | Purpose |
| --- | --- | --- |
| `OLLAMA_MODELS` | `%USERPROFILE%\.ollama\models` | Model storage directory |
| `OLLAMA_HOST` | `127.0.0.1:11434` | Local server address |
| `OLLAMA_CONTEXT_LENGTH` | `8192` | Context window size |
| `OLLAMA_KEEP_ALIVE` | `5m` | Keep models loaded for five minutes after use |

Edit `start-ollama.cmd` to change these defaults. The Vulkan backend requires a
Vulkan-capable GPU and a compatible graphics driver; actual GPU support depends
on the device and its driver.
