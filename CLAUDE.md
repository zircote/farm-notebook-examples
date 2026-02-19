# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with notebooks in this repository.

## Project Overview

This is a minimal Jupyter notebook project for experiments and learning. It prioritizes simplicity over production-grade structure.

## Project Structure

```
notebooks/           # All Jupyter notebooks
├── example.ipynb    # Example notebook template
└── *.ipynb          # Your experiment notebooks
```

## Build Commands

This project uses [uv](https://docs.astral.sh/uv/) as the package manager.

```bash
# Install dependencies
uv sync

# Install with data science extras
uv sync --extra data

# Start Jupyter
uv run jupyter notebook

# Or use JupyterLab
uv run jupyter lab

# Lint notebooks
uv run nbqa ruff notebooks/

# Format notebooks
uv run nbqa ruff --fix notebooks/
```

## Notebook Best Practices

### Cell Organization

1. **First cell**: Imports and setup
   ```python
   # Imports
   import pandas as pd
   import numpy as np

   # Configuration
   pd.set_option("display.max_columns", None)
   ```

2. **Markdown cells**: Explain each section before code
   - Use `## Section Title` for major sections
   - Use `### Subsection` for details
   - Explain the "why", not just the "what"

3. **Code cells**: Keep focused and small
   - One logical operation per cell
   - Avoid cells longer than 20 lines
   - Print intermediate results for debugging

4. **Final cells**: Summary and conclusions

### Documentation Conventions

- Start notebooks with a title markdown cell: `# Notebook Title`
- Include a brief description of the notebook's purpose
- Add `## Conclusion` section at the end with findings

### Variable Naming

- Use descriptive names: `customer_data` not `df1`
- Prefix raw data with `raw_`: `raw_sales`, `raw_customers`
- Prefix cleaned data with `clean_`: `clean_sales`
- Suffix aggregations: `sales_by_region`, `count_by_category`

### Output Management

- Clear all outputs before committing: `Kernel > Restart & Clear Output`
- Or use the pre-commit hook to strip outputs automatically
- Include key visualizations in markdown (export and embed)

## Linting with nbQA

This project uses nbQA to run ruff on notebooks:

```bash
# Check for issues
uv run nbqa ruff notebooks/

# Auto-fix issues
uv run nbqa ruff --fix notebooks/

# Check specific notebook
uv run nbqa ruff notebooks/example.ipynb
```

## Adding Dependencies

For experiments, add dependencies as needed:

```bash
# Add a package
uv add pandas

# Add to data extras group
uv add --optional data scikit-learn
```

## Quick Experiment Workflow

1. Create new notebook: `notebooks/experiment-name.ipynb`
2. Add imports and setup in first cell
3. Document your hypothesis/goal in markdown
4. Write exploratory code
5. Document findings
6. Clear outputs before commit (optional)
