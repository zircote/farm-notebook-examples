# farm-notebook

<!-- Badges -->
[![GitHub Template](https://img.shields.io/badge/template-zircote%2Fnotebook--template-blue?logo=github)](https://github.com/zircote/notebook-template)
[![CI](https://github.com/zircote/farm-notebook/actions/workflows/ci.yml/badge.svg)](https://github.com/zircote/farm-notebook/actions/workflows/ci.yml)
[![Python Version](https://img.shields.io/badge/python-3.12%2B-3776ab?logo=python&logoColor=white)](https://www.python.org/downloads/)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)
[![Jupyter](https://img.shields.io/badge/jupyter-notebook-f37626?logo=jupyter&logoColor=white)](https://jupyter.org/)
[![nbQA](https://img.shields.io/badge/linting-nbQA-blue)](https://github.com/nbQA-dev/nbQA)
[![uv](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/astral-sh/uv/main/assets/badge/v0.json)](https://github.com/astral-sh/uv)
[![Dependabot](https://img.shields.io/badge/dependabot-enabled-025e8c?logo=dependabot)](https://docs.github.com/en/code-security/dependabot)

A collection of Jupyter notebooks for experiments and learning.

## Quick Start

### Prerequisites

- Python 3.12+
- [uv](https://docs.astral.sh/uv/) package manager

### Setup

```bash
# Clone the repository
git clone https://github.com/zircote/farm-notebook.git
cd farm-notebook

# Install dependencies
uv sync

# Start Jupyter
uv run jupyter notebook
```

### With Data Science Packages

```bash
# Install with pandas, numpy, matplotlib
uv sync --extra data

# Start JupyterLab
uv run jupyter lab
```

## Project Structure

```
notebooks/           # All Jupyter notebooks
├── example.ipynb    # Example notebook template
└── *.ipynb          # Your experiment notebooks
```

## Development

### Linting Notebooks

```bash
# Check for issues
uv run nbqa ruff notebooks/

# Auto-fix issues
uv run nbqa ruff --fix notebooks/
```

### Adding Dependencies

```bash
# Add a package
uv add requests

# Add to data extras group
uv add --optional data scikit-learn
```

## Notebook Guidelines

1. **Clear documentation**: Start with a title and purpose
2. **Organized cells**: Imports first, then data, then analysis
3. **Small cells**: One logical operation per cell
4. **Clear outputs**: Clear before committing (optional)

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b experiment/topic-name`)
3. Add your notebook to `notebooks/`
4. Run linting (`uv run nbqa ruff notebooks/`)
5. Commit your changes
6. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
