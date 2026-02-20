# Installation

## Requirements

- Python 3.12+
- [uv](https://docs.astral.sh/uv/) package manager
- [just](https://github.com/casey/just) task runner
- [NSIP (National Sheep Improvement Program) CLI (command-line interface)](https://github.com/zircote/nsip) v0.3.3+ (for genetics notebooks)
- [Docker](https://www.docker.com/) (optional, for NSIP MCP server)

## Quick Setup

> **Platform note:** The commands below are for macOS. For Linux or Windows, see [SETUP.md](SETUP.md).

```bash
# Install just (macOS)
brew install just

# Install uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# Clone and set up the project
git clone https://github.com/zircote/farm-notebook-examples.git
cd farm-notebook-examples
just setup
```

`just setup` installs all Python dependencies and the NSIP CLI binary.

> **NSIP version freshness:** The setup pins a specific NSIP CLI version. Check [the latest release](https://github.com/zircote/nsip/releases/latest) to see if a newer version is available.

## Individual Steps

```bash
just install          # Install all Python deps (data + dev extras)
just install-nsip     # Download and install the NSIP CLI
just install-mcp      # Pull the NSIP MCP Docker image (optional)
```

## Running Notebooks

```bash
just lab              # Start JupyterLab
just notebook         # Start classic Jupyter Notebook
```

## Verifying Your Setup

```bash
just check            # Run all checks (validate notebooks, lint, NSIP)
just versions         # Show installed tool versions
```

## All Available Commands

Run `just` with no arguments to see every available recipe.

| Recipe | Description |
|---|---|
| `just setup` | Full setup: install all deps + NSIP CLI |
| `just install` | Install all Python dependencies (data + dev extras) |
| `just install-minimal` | Install only the minimal dependencies (Jupyter + kernel) |
| `just install-data` | Install data science extras (pandas, numpy, matplotlib, tabulate) |
| `just install-dev` | Install dev tools (nbqa, ruff) |
| `just install-nsip` | Download and install the NSIP CLI binary |
| `just install-mcp` | Pull the NSIP MCP Docker image |
| `just lab` | Start JupyterLab |
| `just notebook` | Start classic Jupyter Notebook |
| `just lint` | Lint all notebooks with ruff (via nbqa) |
| `just fix` | Auto-fix lint issues in all notebooks |
| `just lint-one <name>` | Lint a specific notebook by name |
| `just validate` | Validate all notebooks are well-formed JSON |
| `just check-nsip` | Verify NSIP CLI is working |
| `just check` | Run all checks (validate, lint, NSIP) |
| `just info` | Show notebook inventory (cell counts, sizes) |
| `just versions` | Show installed tool versions |

## Cloud Alternatives (No Install Required)

Don't want to install anything? Run the notebooks in the cloud:

- **Google Colab:** Open any notebook directly from GitHub at https://colab.research.google.com/ (just add `!pip install tabulate` in the first cell). Note: the NSIP CLI is not available in Colab, so genetics notebooks that call `nsip` commands will not work without manual setup.
- **GitHub Codespaces:** Click the green "Code" button on the repo page, then "Create codespace on main" for a full VS Code environment in your browser

See [SETUP.md](SETUP.md#12-cloud-alternatives-no-local-install) for detailed instructions.

## Detailed Instructions

- **New to all of this?** See [SETUP.md](SETUP.md) for step-by-step instructions covering every tool from scratch.
- **Windows users:** See the [Complete Windows Walkthrough](SETUP.md#13-complete-windows-walkthrough) for both WSL and native PowerShell approaches.
- **Prefer the cloud?** See [Cloud Alternatives](SETUP.md#12-cloud-alternatives-no-local-install) for Google Colab and GitHub Codespaces guides.
