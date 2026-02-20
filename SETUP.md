# Detailed Setup Guide

This guide walks through every step required to use the Farm Notebook Examples, from scratch, on a computer that has none of the tools installed. Follow the section for your operating system.

### What You'll Need Before Starting

- **Internet connection** — for downloading tools and cloning the repository
- **Administrator password** — some install steps require elevated privileges
- **~2 GB of free disk space** — for Python, tools, and project dependencies
- **15–30 minutes** — depending on download speeds and familiarity with the terminal

---

## Table of Contents

1. [Opening a Terminal](#1-opening-a-terminal)
2. [Installing Python](#2-installing-python)
3. [Installing uv (Python Package Manager)](#3-installing-uv-python-package-manager)
4. [Installing just (Task Runner)](#4-installing-just-task-runner)
5. [Installing Git](#5-installing-git)
6. [Cloning the Repository](#6-cloning-the-repository)
7. [Installing Project Dependencies](#7-installing-project-dependencies)
8. [Installing the NSIP CLI](#8-installing-the-nsip-cli)
9. [Installing Docker (Optional)](#9-installing-docker-optional)
10. [Starting Jupyter](#10-starting-jupyter)
11. [Verifying Everything Works](#11-verifying-everything-works)
12. [Cloud Alternatives (No Local Install)](#12-cloud-alternatives-no-local-install)
13. [Complete Windows Walkthrough](#13-complete-windows-walkthrough)
14. [Troubleshooting](#14-troubleshooting)

---

## 1. Opening a Terminal

Every command in this guide is typed into a terminal (also called a command prompt or shell).

### macOS

1. Press `Cmd + Space` to open Spotlight Search.
2. Type `Terminal` and press `Enter`.
3. A window with a blinking cursor appears. This is your terminal.

Alternatively, open Finder, go to Applications > Utilities > Terminal.

### Linux (Ubuntu/Debian)

1. Press `Ctrl + Alt + T`. A terminal window opens.

### Windows

1. Press `Win + R`, type `powershell`, and press `Enter`.
2. A blue window with a blinking cursor appears.

For Windows, you have two options for this project:
- **Option A (Recommended):** Install [WSL 2](https://learn.microsoft.com/en-us/windows/wsl/install) and follow the Linux instructions inside WSL.
- **Option B:** Use PowerShell directly. Some commands differ slightly; notes are included below.

To install WSL 2, open PowerShell as Administrator and run:

```powershell
wsl --install
```

Restart your computer when prompted. After restart, open the "Ubuntu" app from the Start menu. This gives you a Linux terminal inside Windows. Use this terminal for all remaining steps.

---

## 2. Installing Python

This project requires Python 3.12 or newer. Python 3.12, 3.13, and 3.14 all work.

### Checking If Python Is Already Installed

Run this command in your terminal:

```bash
python3 --version
```

If the output shows `Python 3.12.x` or higher (e.g., `Python 3.13.1`, `Python 3.14.3`), you already have a compatible version. Skip to [Step 3](#3-installing-uv-python-package-manager).

If you see `command not found`, `Python 3.11.x`, or lower, continue below.

### macOS

**Option A: Using the official installer**

1. Go to https://www.python.org/downloads/
2. Click the yellow "Download Python 3.12.x" button (or whatever the latest 3.12+ version is).
3. Open the downloaded `.pkg` file.
4. Click Continue through the installer screens. Accept the license. Click Install.
5. Enter your Mac password when prompted.
6. When the installer finishes, close it.

Verify the installation:

```bash
python3 --version
```

You should see `Python 3.12.x` or higher.

**Option B: Using Homebrew**

If you have Homebrew installed (see https://brew.sh):

```bash
brew install python@3.12
```

Verify:

```bash
python3 --version
```

### Linux (Ubuntu/Debian)

```bash
sudo apt update
sudo apt install -y python3 python3-pip python3-venv
```

Verify:

```bash
python3 --version
```

If your distribution ships Python 3.11 or older, add the deadsnakes PPA:

```bash
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install -y python3.12 python3.12-venv
```

### Windows (PowerShell, without WSL)

1. Go to https://www.python.org/downloads/
2. Click "Download Python 3.12.x".
3. Run the downloaded `.exe` installer.
4. **IMPORTANT:** Check the box that says "Add python.exe to PATH" at the bottom of the first screen.
5. Click "Install Now".
6. When it finishes, close the installer.

Open a new PowerShell window and verify:

```powershell
python --version
```

Note: On Windows, the command is `python` (not `python3`).

---

## 3. Installing uv (Python Package Manager)

`uv` is a fast Python package manager that replaces pip and virtualenv. It manages all the libraries this project needs.

### macOS and Linux

Run this single command:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

This downloads and installs uv to `~/.local/bin/`. The installer will print instructions if you need to add it to your PATH.

After installation, **close and reopen your terminal** (or run `source ~/.bashrc` / `source ~/.zshrc`), then verify:

```bash
uv --version
```

You should see something like `uv 0.x.x` (your version number will differ).

### macOS (Homebrew alternative)

```bash
brew install uv
```

### Windows (PowerShell, without WSL)

```powershell
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
```

Close and reopen PowerShell, then verify:

```powershell
uv --version
```

### What If `uv --version` Says "command not found"?

The `uv` binary was installed to `~/.local/bin/`. Your shell may not include this directory in its PATH. Fix it:

**bash** (Linux, older macOS):
```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

**zsh** (modern macOS):
```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

Then try `uv --version` again.

---

## 4. Installing just (Task Runner)

`just` is a command runner (like `make` but simpler). The project's `justfile` defines recipes for common tasks so you don't have to remember long commands.

### macOS (Homebrew)

```bash
brew install just
```

### macOS (without Homebrew)

```bash
curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to ~/.local/bin
```

### Linux (Ubuntu/Debian)

**Option A: Using the install script**

```bash
curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to ~/.local/bin
```

**Option B: Using apt (if your distribution packages it)**

```bash
sudo apt install -y just
```

### Windows (PowerShell, without WSL)

```powershell
winget install Casey.Just
```

Or, if you use Scoop:

```powershell
scoop install just
```

### Verify

```bash
just --version
```

You should see `just 1.x.x`.

---

## 5. Installing Git

Git is required to download (clone) the project.

### Checking If Git Is Already Installed

```bash
git --version
```

If you see a version number (e.g., `git version 2.43.0`), skip to [Step 6](#6-cloning-the-repository).

### macOS

Git is included with the Xcode Command Line Tools. Install them:

```bash
xcode-select --install
```

A dialog box appears. Click "Install", then "Agree" to the license. Wait for the download to complete (may take several minutes).

Verify:

```bash
git --version
```

### Linux (Ubuntu/Debian)

```bash
sudo apt update
sudo apt install -y git
```

### Windows (PowerShell, without WSL)

1. Go to https://git-scm.com/download/win
2. Download and run the installer.
3. Accept all defaults. Click "Install".
4. Close and reopen PowerShell.

Verify:

```powershell
git --version
```

---

## 6. Cloning the Repository

"Cloning" downloads the project files to your computer.

1. Choose where you want the project to live. Your home directory is a good default:

```bash
cd ~
```

2. Clone the repository:

```bash
git clone https://github.com/zircote/farm-notebook-examples.git
```

3. Enter the project directory:

```bash
cd farm-notebook-examples
```

4. Confirm you are in the right place:

```bash
ls
```

You should see files including `justfile`, `pyproject.toml`, `README.md`, and a `notebooks/` directory.

---

## 7. Installing Project Dependencies

Now install all the Python libraries the notebooks need. Make sure you are in the `farm-notebook-examples` directory.

### Using just (recommended)

```bash
just install
```

This runs `uv sync --extra data --extra dev`, which installs:
- Jupyter and IPython kernel
- pandas, numpy, matplotlib, tabulate (data science libraries)
- nbqa and ruff (code quality tools)

### Without just

```bash
uv sync --extra data --extra dev
```

### What This Does

`uv` creates a virtual environment (a self-contained Python installation) inside the project and installs all required packages into it. You don't need to activate the virtual environment manually; `uv run` handles that.

### Verifying Dependencies

```bash
uv run python -c "import pandas; import matplotlib; import tabulate; print('All imports OK')"
```

If you see `All imports OK`, everything is installed correctly.

---

## 8. Installing the NSIP CLI

> **Version note:** The version below (v0.3.3) was current when this guide was written. Check https://github.com/zircote/nsip/releases/latest for the most current version. Using `just install-nsip` is recommended as it downloads the latest supported version automatically.

The NSIP CLI lets you query sheep genetic data from the National Sheep Improvement Program. It is required for the `getting-started` and `nsip-sheep-genetics` notebooks.

### Using just (recommended)

```bash
just install-nsip
```

This detects your operating system and CPU architecture, downloads the correct binary from GitHub, and installs it to `~/.local/bin/nsip`.

### Manual Installation

#### macOS (Apple Silicon: M1/M2/M3/M4)

```bash
mkdir -p ~/.local/bin
curl -fsSL https://github.com/zircote/nsip/releases/download/v0.3.3/nsip-macos-arm64 -o ~/.local/bin/nsip
chmod +x ~/.local/bin/nsip
```

#### macOS (Intel)

```bash
mkdir -p ~/.local/bin
curl -fsSL https://github.com/zircote/nsip/releases/download/v0.3.3/nsip-macos-amd64 -o ~/.local/bin/nsip
chmod +x ~/.local/bin/nsip
```

#### Linux (x86_64)

```bash
mkdir -p ~/.local/bin
curl -fsSL https://github.com/zircote/nsip/releases/download/v0.3.3/nsip-linux-amd64 -o ~/.local/bin/nsip
chmod +x ~/.local/bin/nsip
```

#### Linux (ARM64)

```bash
mkdir -p ~/.local/bin
curl -fsSL https://github.com/zircote/nsip/releases/download/v0.3.3/nsip-linux-arm64 -o ~/.local/bin/nsip
chmod +x ~/.local/bin/nsip
```

#### Windows

1. Download `nsip-windows-amd64.exe` from https://github.com/zircote/nsip/releases/tag/v0.3.3
2. Rename it to `nsip.exe`.
3. Move it to a directory on your PATH (e.g., `C:\Users\YourName\.local\bin\`).
4. Add that directory to your PATH if it isn't already:
   - Open Settings > System > About > Advanced system settings > Environment Variables.
   - Under "User variables", select `Path`, click Edit, click New, and add `C:\Users\YourName\.local\bin`.
   - Click OK on all dialogs.
5. Close and reopen PowerShell.

Alternatively, use the Windows MSI installer: download `nsip-0.3.3-x86_64.msi` from the same release page and double-click it.

### Verifying the NSIP CLI

```bash
nsip --version
```

Expected output: `nsip 0.3.3` (or similar).

```bash
nsip date-updated
```

This shows the date the NSIP genetic data was last refreshed.

### Quick Test

```bash
nsip --json search --breed-id 640 --name storm | head -20
```

If you see JSON data with animal records, the CLI is working.

---

## 9. Installing Docker (Optional)

Docker is only needed if you want to run the NSIP MCP server (for use with Claude Desktop or GitHub Copilot). If you only plan to use the notebooks with the CLI, skip this step.

### macOS

1. Go to https://www.docker.com/products/docker-desktop/
2. Download Docker Desktop for Mac.
3. Open the downloaded `.dmg` file.
4. Drag Docker to the Applications folder.
5. Open Docker from Applications. It will ask for your password to install helper tools.
6. Wait for Docker to start (you'll see the whale icon in your menu bar).

Verify:

```bash
docker --version
```

### Linux (Ubuntu/Debian)

```bash
sudo apt update
sudo apt install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
```

Log out and back in for the group change to take effect. Then verify:

```bash
docker --version
```

### Windows

1. Download Docker Desktop from https://www.docker.com/products/docker-desktop/
2. Run the installer. Accept defaults.
3. Restart your computer when prompted.
4. Open Docker Desktop from the Start menu.

### Pulling the NSIP MCP Image

```bash
just install-mcp
```

Or manually:

```bash
docker pull ghcr.io/zircote/nsip:latest
```

---

## 10. Starting Jupyter

Make sure you are in the `farm-notebook-examples` directory:

```bash
cd ~/farm-notebook-examples
```

### Using just

```bash
just lab
```

This starts JupyterLab and opens it in your default web browser.

### Without just

```bash
uv run jupyter lab
```

### What You Should See

Your web browser opens to a page that looks like a file browser. You'll see a `notebooks/` folder on the left side. Click into it and open `getting-started.ipynb` to begin.

### If the Browser Doesn't Open Automatically

Look in your terminal for a line like:

```
http://localhost:8888/lab?token=abc123...
```

Copy the full URL (including the token) and paste it into your web browser's address bar.

### Stopping Jupyter

Press `Ctrl + C` in the terminal where Jupyter is running, then type `y` and press Enter when asked to confirm.

---

## 11. Verifying Everything Works

Run the full verification suite:

```bash
just check
```

This validates all notebooks, runs the linter, and checks the NSIP CLI. If you see `All checks passed.`, you are ready to go.

You can also check individual components:

```bash
just versions       # Show all tool versions
just validate       # Check notebooks are valid JSON
just lint           # Run ruff linter on all notebooks
just check-nsip     # Verify NSIP CLI works
just info           # Show notebook cell counts and sizes
```

---

## 12. Cloud Alternatives (No Local Install)

If you do not want to install anything on your computer, you can run these notebooks in the cloud. Below are two free options.

### Google Colab

Google Colab is a free, browser-based Jupyter environment hosted by Google. It requires only a Google account (Gmail).

#### Step-by-Step: Opening a Notebook in Colab

1. Go to https://colab.research.google.com/
2. Sign in with your Google account.
3. Click **File > Open notebook**.
4. Click the **GitHub** tab.
5. Paste this URL into the search field:
   ```
   https://github.com/zircote/farm-notebook-examples
   ```
6. Press Enter. You will see a list of notebooks in the repository.
7. Click the notebook you want to open (e.g., `notebooks/soil-testing-guide.ipynb`).
8. The notebook opens in a new Colab tab. You can run cells with `Shift + Enter`, just like local Jupyter.

#### Installing Dependencies in Colab

Colab already has pandas, numpy, and matplotlib installed. You only need to install `tabulate` and (optionally) the NSIP CLI. Add a code cell at the top of the notebook with:

```python
!pip install tabulate
```

For the NSIP CLI (needed for `getting-started` and `nsip-sheep-genetics` notebooks):

```python
# Download the NSIP CLI for Linux (Colab runs Linux)
!curl -fsSL https://github.com/zircote/nsip/releases/download/v0.3.3/nsip-linux-amd64 -o /usr/local/bin/nsip
!chmod +x /usr/local/bin/nsip
!nsip --version
```

#### Saving Your Work in Colab

- **Save to Google Drive:** File > Save a copy in Drive. This creates a copy in your "Colab Notebooks" folder.
- **Download as .ipynb:** File > Download > Download .ipynb.
- **Push back to GitHub:** File > Save a copy in GitHub (requires linking your GitHub account).

#### Colab Limitations

- Free tier has usage limits (GPU/TPU time, idle timeout after ~90 minutes of inactivity).
- The runtime resets when it disconnects, so you lose installed packages and downloaded files. You will need to re-run the `!pip install` and `!curl` cells each time you reconnect.
- File system is ephemeral. Save important outputs to Google Drive or download them.

### GitHub Codespaces

GitHub Codespaces gives you a full VS Code editor in your browser with a Linux virtual machine behind it. It includes a terminal, so you can run `uv`, `just`, and the NSIP CLI exactly as described in this guide.

#### Prerequisites

- A GitHub account (free at https://github.com/signup).
- GitHub Free includes 120 core-hours/month of Codespaces (roughly 60 hours on a 2-core machine).

#### Step-by-Step: Opening a Codespace

1. Go to https://github.com/zircote/farm-notebook-examples
2. Click the green **Code** button.
3. Click the **Codespaces** tab.
4. Click **Create codespace on main**.
5. Wait 1-2 minutes for the environment to build. A VS Code editor appears in your browser.

#### Setting Up Inside the Codespace

Open the terminal in VS Code (`` Ctrl + ` `` or Terminal > New Terminal) and run:

```bash
# Install uv
curl -LsSf https://astral.sh/uv/install.sh | sh
source ~/.bashrc

# Install just
curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to ~/.local/bin
export PATH="$HOME/.local/bin:$PATH"

# Full setup (installs Python deps + NSIP CLI)
just setup
```

#### Running Notebooks in a Codespace

**Option A: JupyterLab in the browser**

```bash
just lab
```

VS Code will show a notification that a port was forwarded. Click "Open in Browser" to access JupyterLab.

**Option B: VS Code's built-in notebook support**

1. Install the "Jupyter" extension in VS Code (it may be pre-installed).
2. Open any `.ipynb` file from the file explorer on the left.
3. Click "Select Kernel" in the top-right of the notebook, then choose the Python environment.
4. Run cells with `Shift + Enter`.

#### Codespace Lifecycle

- Codespaces auto-stop after 30 minutes of inactivity (configurable in GitHub Settings > Codespaces).
- Stopped Codespaces retain all files and installed tools. When you restart, everything is where you left it.
- Deleted Codespaces lose all data. Download or commit your work before deleting.
- To manage your Codespaces, go to https://github.com/codespaces.

---

## 13. Complete Windows Walkthrough

This section provides a consolidated, start-to-finish guide for Windows users. It covers both the recommended WSL approach and the native PowerShell approach.

### Which Approach Should I Use?

| Approach | Pros | Cons |
|---|---|---|
| **WSL 2 (Recommended)** | Full Linux compatibility, all tools work identically to macOS/Linux, better NSIP CLI support | Requires one-time WSL setup, uses ~1-2 GB disk space |
| **Native PowerShell** | No WSL needed, familiar Windows environment | Some commands differ, file paths use backslashes, occasional compatibility quirks |

### Approach A: WSL 2 (Recommended for Farmers on Windows)

WSL (Windows Subsystem for Linux) lets you run a real Linux environment inside Windows. Once set up, every command in this guide works exactly as written.

#### A1. Install WSL 2

1. Click the **Start** button.
2. Type `powershell`.
3. Right-click **Windows PowerShell** and select **Run as administrator**.
4. In the blue PowerShell window, type this command and press Enter:

```powershell
wsl --install
```

5. Wait for the download and installation to complete. This may take 5-10 minutes.
6. When prompted, **restart your computer**.
7. After restart, the **Ubuntu** app will open automatically (or find it in the Start menu).
8. It will say "Installing, this may take a few minutes..." Wait for it to finish.
9. When prompted, create a username and password. This is your Linux username, not your Windows password. **Write it down.** You will need it when commands ask for `sudo`.
   - Type a username (lowercase, no spaces, e.g., `john`) and press Enter.
   - Type a password and press Enter. **The cursor will not move while you type the password.** This is normal. Type it carefully and press Enter.
   - Retype the password to confirm.

You now have a Linux terminal. The blinking cursor after `username@COMPUTERNAME:~$` is where you type commands.

#### A2. Install Python, uv, just, and Git

Ubuntu comes with Python, but you need to make sure it is new enough and install the other tools.

```bash
# Update the package list
sudo apt update

# Install Python 3.12 and venv support
sudo apt install -y python3 python3-venv python3-pip curl git

# Verify Python version (must be 3.12+)
python3 --version
# If python3 --version shows 3.11 or older, follow the deadsnakes PPA
# instructions in Step 2 (see "Installing Python" > "Linux" section above).

# Install uv
curl -LsSf https://astral.sh/uv/install.sh | sh
source ~/.bashrc

# Install just
curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to ~/.local/bin
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Verify
uv --version
just --version
```

#### A3. Clone and Set Up the Project

```bash
# Go to your home directory
cd ~

# Clone the repository
git clone https://github.com/zircote/farm-notebook-examples.git

# Enter the project
cd farm-notebook-examples

# Full setup (installs Python deps + NSIP CLI)
just setup
```

#### A4. Start Jupyter

```bash
just lab
```

A URL will appear in the terminal, something like:

```
http://localhost:8888/lab?token=abc123def456...
```

Copy the entire URL. Open your Windows web browser (Edge, Chrome, Firefox) and paste it into the address bar. JupyterLab will open.

#### A5. Accessing Windows Files from WSL

Your Windows files are available inside WSL at `/mnt/c/`. For example:

- `C:\Users\John\Documents` is at `/mnt/c/Users/John/Documents`
- The Windows Desktop is at `/mnt/c/Users/John/Desktop`

To copy a notebook to your Windows Desktop:

```bash
cp notebooks/soil-testing-guide.ipynb /mnt/c/Users/John/Desktop/
```

#### A6. Reopening WSL After a Restart

1. Click the Start button.
2. Type `Ubuntu` and click the Ubuntu app.
3. Navigate to the project:

```bash
cd ~/farm-notebook-examples
just lab
```

### Approach B: Native PowerShell (Without WSL)

If you prefer not to use WSL, you can run everything in PowerShell. Some commands are different.

#### B1. Install Python

1. Open your web browser and go to https://www.python.org/downloads/
2. Click the big yellow **Download Python 3.12.x** button.
3. Find the downloaded file (usually in your Downloads folder) and double-click it.
4. **CRITICAL:** On the first screen of the installer, check the box at the bottom that says **"Add python.exe to PATH"**. If you miss this step, nothing else will work.
5. Click **Install Now**.
6. Wait for the installation to complete. Click **Close**.

Open a **new** PowerShell window (the old one won't know about Python yet):

1. Press `Win + R`, type `powershell`, press Enter.
2. Verify Python:

```powershell
python --version
```

You should see `Python 3.12.x` or higher. If you see `Python was not found` or it opens the Microsoft Store, you missed the "Add to PATH" checkbox. Uninstall Python and try again.

#### B2. Install uv

```powershell
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
```

**Close PowerShell and open a new one**, then verify:

```powershell
uv --version
```

#### B3. Install just

```powershell
winget install Casey.Just
```

If `winget` is not available (older Windows 10), use Scoop instead:

```powershell
# Install Scoop first (if you don't have it)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

# Then install just
scoop install just
```

**Close PowerShell and open a new one**, then verify:

```powershell
just --version
```

#### B4. Install Git

1. Go to https://git-scm.com/download/win
2. The download should start automatically. If not, click the link for the latest version.
3. Run the downloaded installer.
4. **On the "Adjusting your PATH environment" screen**, select **"Git from the command line and also from 3rd-party software"** (this is the default).
5. Accept all other defaults. Click **Install**.
6. Click **Finish** when done.

**Close PowerShell and open a new one**, then verify:

```powershell
git --version
```

#### B5. Clone and Set Up the Project

```powershell
# Go to your user directory
cd $HOME

# Clone the repository
git clone https://github.com/zircote/farm-notebook-examples.git

# Enter the project
cd farm-notebook-examples

# Install all dependencies
just install
```

This installs Python dependencies but not the NSIP CLI. Continue to [Step B6](#b6-install-the-nsip-cli-on-windows) to install it.

#### B6. Install the NSIP CLI on Windows

1. Open your browser and go to:
   https://github.com/zircote/nsip/releases/tag/v0.3.3
2. Scroll down to the **Assets** section.
3. Download one of:
   - `nsip-0.3.3-x86_64.msi` (recommended - runs an installer)
   - `nsip-windows-amd64.exe` (manual placement)

**Option A: Using the MSI installer (easiest)**

1. Double-click the downloaded `nsip-0.3.3-x86_64.msi` file.
2. Follow the installer prompts. It will add `nsip` to your PATH automatically.
3. **Close PowerShell and open a new one.**

**Option B: Manual placement**

1. Create a directory for the binary:
   ```powershell
   mkdir -Force "$HOME\.local\bin"
   ```
2. Move and rename the downloaded file:
   ```powershell
   Move-Item "$HOME\Downloads\nsip-windows-amd64.exe" "$HOME\.local\bin\nsip.exe"
   ```
3. Add the directory to your PATH permanently:
   ```powershell
   $path = [Environment]::GetEnvironmentVariable("PATH", "User")
   if ($path -notlike "*$HOME\.local\bin*") {
       [Environment]::SetEnvironmentVariable("PATH", "$HOME\.local\bin;$path", "User")
   }
   ```
4. **Close PowerShell and open a new one.**

Verify:

```powershell
nsip --version
```

#### B7. Start Jupyter

```powershell
cd $HOME\farm-notebook-examples
just lab
```

Your web browser should open automatically with JupyterLab. If it doesn't, look for the URL in the PowerShell output and paste it into your browser.

#### B8. Windows-Specific Tips

- **File paths:** Windows uses backslashes (`\`) but Python and Jupyter accept forward slashes (`/`) too. You don't need to change any paths in the notebooks.
- **Long paths:** If you get errors about file paths being too long, enable long paths:
  1. Press `Win + R`, type `regedit`, press Enter.
  2. Navigate to `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem`.
  3. Double-click `LongPathsEnabled` and set its value to `1`.
  4. Restart your computer.
- **Antivirus:** Windows Defender may briefly scan the NSIP binary when you first run it. This is normal. If it blocks the file, click "More info" > "Run anyway" or add an exception.
- **PowerShell execution policy:** If you get errors about scripts being disabled, run:
  ```powershell
  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
  ```

---

## 14. Troubleshooting

### "command not found: uv"

The uv binary is not on your PATH. See the PATH instructions in [Step 3](#3-installing-uv-python-package-manager).

### "command not found: just"

Same issue. Make sure `~/.local/bin` is on your PATH, or install just via Homebrew (`brew install just`).

### "command not found: nsip"

The nsip binary is not on your PATH. If you installed it to `~/.local/bin/nsip`, make sure that directory is on your PATH. Run `echo $PATH` to check.

### "No such file or directory: notebooks/"

You are not in the `farm-notebook-examples` directory. Run `cd ~/farm-notebook-examples` (or wherever you cloned it).

### "uv sync" fails with a resolver error

Your Python version may be too old. Run `python3 --version` and confirm it shows 3.12 or higher. If not, install a newer Python (see [Step 2](#2-installing-python)).

### Jupyter opens but notebooks show errors

Make sure you ran `just install` (or `uv sync --extra data`) first. The notebooks need pandas, matplotlib, and tabulate installed.

### matplotlib charts don't display

If you're using the classic Jupyter Notebook interface (not JupyterLab), you may need to add `%matplotlib inline` at the top of your notebook. JupyterLab handles this automatically.

### Docker commands fail with "permission denied"

On Linux, your user may not be in the `docker` group. Run:

```bash
sudo usermod -aG docker $USER
```

Then log out and back in.

### NSIP search returns empty results

The NSIP database is periodically updated. If a search returns no results, try a broader search (e.g., remove the `--name` filter). Run `nsip date-updated` to see when the data was last refreshed.

### Python opens the Microsoft Store instead of running

Windows ships with a "python" app alias that redirects to the Microsoft Store. To fix this:

1. Open **Settings > Apps > Advanced app settings > App execution aliases**.
2. Turn **off** both "App Installer" entries for `python.exe` and `python3.exe`.
3. Close and reopen PowerShell.
4. Run `python --version` again. It should now show the version you installed.

If you still see the issue, you likely missed the "Add python.exe to PATH" checkbox during installation. Uninstall Python from **Settings > Apps**, re-run the installer, and check that box.

### I'm on Windows and things aren't working

We strongly recommend using WSL 2 (see [Step 1](#1-opening-a-terminal)). The Linux environment inside WSL is fully compatible with all the tools in this project and avoids many Windows-specific issues.
