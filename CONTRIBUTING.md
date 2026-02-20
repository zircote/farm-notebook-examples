# Contributing to Farm Notebook Examples

Thank you for your interest in contributing! This project welcomes improvements from farmers, agronomists, developers, and anyone who wants to make these tools more useful.

## Ways to Contribute

- **Report a bug** — open an [issue](https://github.com/zircote/farm-notebook-examples/issues) describing the problem and steps to reproduce it.
- **Request a feature or new notebook** — open an issue with your idea and use case.
- **Fix a bug or improve a notebook** — submit a pull request (PR).
- **Improve documentation** — typo fixes, clarifications, and additional examples are always welcome.

## Development Setup

```bash
# Clone the repo
git clone https://github.com/zircote/farm-notebook-examples.git
cd farm-notebook-examples

# Install all dependencies (data + dev tools: nbqa, ruff)
just install

# Or without just:
uv sync --extra data --extra dev
```

See [INSTALL.md](INSTALL.md) for full setup options, including cloud alternatives.

## Making Changes

1. **Fork** the repository and create a branch from `main`:

   ```bash
   git checkout -b your-topic-branch
   ```

2. **Edit notebooks** in `notebooks/`. Keep each cell focused — one logical operation per code cell.

3. **Lint and validate** before committing:

   ```bash
   just ci          # validate JSON + lint (no NSIP required)
   just fix         # auto-fix lint issues
   ```

4. **Clear notebook outputs** before committing (`Kernel › Restart & Clear Output` in JupyterLab). This keeps diffs readable and avoids committing generated data.

5. **Open a pull request** against `main` with a clear description of what changed and why.

## Code Style

- Python in notebooks follows [ruff](https://docs.astral.sh/ruff/) rules (see `pyproject.toml` for the active rule set).
- Line length is 100 characters.
- Use double quotes for strings (`"value"`, not `'value'`).
- Add inline comments that explain *why*, not just *what*.

## Commit Messages

Use clear, imperative subject lines:

```
Add carrying capacity calculation to pasture notebook
Fix typo in soil amendment table
Update NSIP CLI version to v0.4.0
```

## Questions

Open an issue or start a [discussion](https://github.com/zircote/farm-notebook-examples/discussions) — no question is too small.
