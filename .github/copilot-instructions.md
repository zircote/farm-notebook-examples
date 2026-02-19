# GitHub Copilot Instructions

This document provides context for GitHub Copilot when working with Jupyter notebooks in this project.

## Project Context

This is a minimal Jupyter notebook project for experiments and learning:
- **Python**: 3.12+
- **Package Manager**: uv
- **Linting**: nbQA + ruff
- **Focus**: Quick experiments, not production code

## Notebook Generation Guidelines

### Cell Structure

When generating notebook content:

1. **Start with imports cell**:
   ```python
   import pandas as pd
   import numpy as np
   import matplotlib.pyplot as plt
   ```

2. **Add configuration cell** (if needed):
   ```python
   # Display settings
   pd.set_option("display.max_columns", None)
   plt.style.use("seaborn-v0_8-whitegrid")
   ```

3. **Use markdown for section headers**:
   ```markdown
   ## Data Loading

   Load and preview the dataset.
   ```

4. **Keep code cells focused**:
   - One operation per cell
   - Show output for verification
   - Add inline comments for complex logic

### Data Science Patterns

#### Loading Data
```python
# Load CSV with explicit types
df = pd.read_csv("data.csv", dtype={"id": str, "value": float})
df.head()
```

#### Quick EDA
```python
# Overview
print(f"Shape: {df.shape}")
print(f"Columns: {df.columns.tolist()}")
df.info()
df.describe()
```

#### Visualization
```python
fig, ax = plt.subplots(figsize=(10, 6))
df["column"].hist(ax=ax, bins=30)
ax.set_title("Distribution of Column")
ax.set_xlabel("Value")
ax.set_ylabel("Frequency")
plt.tight_layout()
plt.show()
```

### Variable Naming

Use descriptive, consistent names:
- `raw_*` for unprocessed data
- `clean_*` for cleaned data
- `*_by_*` for grouped data
- `fig, ax` for matplotlib plots

### Inline Comments

Add comments that explain "why":
```python
# Filter to active users only (inactive users have incomplete data)
active_df = df[df["status"] == "active"]

# Use 7-day rolling average to smooth daily fluctuations
df["rolling_avg"] = df["value"].rolling(7).mean()
```

### Error Handling (Light)

For experiments, use assertions:
```python
# Sanity check
assert len(df) > 0, "DataFrame is empty after filtering"
assert df["date"].is_monotonic_increasing, "Dates not sorted"
```

## Commands Reference

```bash
uv run jupyter notebook    # Start Jupyter
uv run jupyter lab         # Start JupyterLab
uv run nbqa ruff notebooks/  # Lint notebooks
```

## File Locations

- Notebooks: `notebooks/`
- Data files: `data/` (create as needed, add to .gitignore)
- Output/exports: `output/` (create as needed, add to .gitignore)
