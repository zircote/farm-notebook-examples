# Farm Notebook Examples - Task Runner
# Run `just` with no arguments to see all available recipes.
# Run `just <recipe>` to execute a recipe.

# Default recipe: show help
default:
    @just --list

# ---------- Setup & Install ----------

# Install all dependencies (data + dev extras)
install:
    uv sync --extra data --extra dev

# Install only the minimal dependencies (Jupyter + kernel)
install-minimal:
    uv sync

# Install data science extras (pandas, numpy, matplotlib, tabulate)
install-data:
    uv sync --extra data

# Install dev tools (nbqa, ruff)
install-dev:
    uv sync --extra dev

# Install the NSIP CLI binary for the current platform
install-nsip:
    #!/usr/bin/env bash
    set -euo pipefail
    VERSION="v0.3.3"
    BASE_URL="https://github.com/zircote/nsip/releases/download/${VERSION}"
    OS="$(uname -s)"
    ARCH="$(uname -m)"
    case "${OS}-${ARCH}" in
        Darwin-arm64)  BINARY="nsip-macos-arm64" ;;
        Darwin-x86_64) BINARY="nsip-macos-amd64" ;;
        Linux-x86_64)  BINARY="nsip-linux-amd64" ;;
        Linux-aarch64) BINARY="nsip-linux-arm64" ;;
        *)
            echo "Unsupported platform: ${OS}-${ARCH}"
            echo "Download manually from https://github.com/zircote/nsip/releases/latest"
            exit 1
            ;;
    esac
    DEST="${HOME}/.local/bin/nsip"
    mkdir -p "$(dirname "${DEST}")"
    echo "Downloading ${BINARY} (${VERSION})..."
    curl -fsSL "${BASE_URL}/${BINARY}" -o "${DEST}"
    chmod +x "${DEST}"
    echo "Installed nsip to ${DEST}"
    "${DEST}" --version

# Pull the NSIP MCP server Docker image
install-mcp:
    docker pull ghcr.io/zircote/nsip:latest

# Full setup: install all deps + NSIP CLI
setup: install install-nsip
    @echo ""
    @echo "Setup complete. Run 'just lab' to start JupyterLab."

# ---------- Run ----------

# Start JupyterLab
lab:
    uv run jupyter lab

# Start Jupyter Notebook (classic interface)
notebook:
    uv run jupyter notebook

# ---------- Lint & Format ----------

# Lint all notebooks with ruff (via nbqa)
lint:
    uv run nbqa ruff notebooks/

# Auto-fix lint issues in all notebooks
fix:
    uv run nbqa ruff --fix notebooks/

# Lint a specific notebook (e.g., just lint-one getting-started)
lint-one name:
    uv run nbqa ruff "notebooks/{{name}}.ipynb"

# ---------- Validate ----------

# Validate all notebooks are well-formed JSON (mirrors CI validate job)
validate:
    #!/usr/bin/env bash
    set -euo pipefail
    uv run python -c "
    import json, sys
    from pathlib import Path

    notebooks = sorted(Path('notebooks').glob('*.ipynb'))
    if not notebooks:
        print('No notebooks found')
        sys.exit(0)

    errors = []
    for nb_path in notebooks:
        try:
            with open(nb_path) as f:
                nb = json.load(f)
            assert 'cells' in nb, 'Missing cells'
            assert 'nbformat' in nb, 'Missing nbformat'
            assert nb.get('nbformat') == 4, f'Expected nbformat 4, got {nb.get(\"nbformat\")}'
            print(f'OK: {nb_path} ({len(nb[\"cells\"])} cells)')
        except Exception as e:
            errors.append(f'{nb_path}: {e}')

    if errors:
        for err in errors:
            print(f'FAIL: {err}', file=sys.stderr)
        sys.exit(1)
    print(f'All {len(notebooks)} notebooks valid.')
    "

# Verify NSIP CLI is working
check-nsip:
    @nsip --version
    @nsip date-updated

# Run all checks: validate notebooks, lint, verify NSIP
check: validate lint check-nsip
    @echo "All checks passed."

# Run the same checks as CI (no NSIP required)
ci: validate lint
    @echo "CI checks passed."

# ---------- Info ----------

# Show notebook inventory (cell counts, sizes)
info:
    #!/usr/bin/env bash
    printf "%-45s %5s %5s %5s %7s\n" "Notebook" "MD" "Code" "Total" "Size"
    printf "%-45s %5s %5s %5s %7s\n" "--------" "--" "----" "-----" "----"
    for nb in notebooks/*.ipynb; do
        uv run python -c "
    import json, os
    with open('${nb}') as f:
        data = json.load(f)
    md = sum(1 for c in data['cells'] if c['cell_type'] == 'markdown')
    code = sum(1 for c in data['cells'] if c['cell_type'] == 'code')
    size = os.path.getsize('${nb}')
    name = os.path.basename('${nb}')
    print(f'{name:<45} {md:>5} {code:>5} {md+code:>5} {size//1024:>5}KB')
    "
    done

# Show installed tool versions
versions:
    @echo "uv:     $(uv --version 2>/dev/null || echo 'not installed')"
    @echo "python: $(python3 --version 2>/dev/null || echo 'not installed')"
    @echo "just:   $(just --version 2>/dev/null || echo 'not installed')"
    @echo "nsip:   $(nsip --version 2>/dev/null || echo 'not installed')"
    @echo "docker: $(docker --version 2>/dev/null || echo 'not installed')"
