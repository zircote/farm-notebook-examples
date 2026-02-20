# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- **7 Jupyter notebooks** for farmers, ranchers, and agronomists:
  - [Getting Started](notebooks/getting-started.ipynb) -- Jupyter basics, tool installation, first NSIP query
  - [NSIP Sheep Genetics](notebooks/nsip-sheep-genetics.ipynb) -- EBVs, ram comparison, mating recommendations (Katahdin breed)
  - [Grant Writing for Farms](notebooks/grant-writing-for-farms.ipynb) -- EQIP/CSP/SARE proposals with budget templates
  - [Soil Testing Guide](notebooks/soil-testing-guide.ipynb) -- Lab report interpretation, amendment calculations, multi-year trends
  - [Ecological Monitoring (EOV)](notebooks/ecological-monitoring-eov.ipynb) -- Savory Institute 15-indicator framework, site assessments
  - [Livestock Health Records](notebooks/livestock-health-records.ipynb) -- Vaccinations, FAMACHA, growth curves, body condition scoring
  - [Pasture & Grazing Management](notebooks/pasture-grazing-management.ipynb) -- Carrying capacity, rotation planning, forage budgets
- **justfile** with 18 recipes for setup, install, run, lint, validate, and CI checks
- **INSTALL.md** -- Concise installation guide with cloud alternatives and just recipe table
- **SETUP.md** -- Detailed step-by-step guide (~1,000 lines) covering macOS, Linux, Windows (WSL + PowerShell), Google Colab, and GitHub Codespaces
- **LICENSE** -- MIT license
- **CI workflow** (`.github/workflows/ci.yml`) -- Lint and validate notebooks on push/PR
- **Social preview images** -- Light and dark SVG farm motifs with JPG conversions for GitHub
- **README infographic** -- 7-notebook card layout SVG
- **Shields.io badges** in README (MIT, Python 3.12+, Jupyter, NSIP)
- **Theme-aware hero image** in README using `<picture>` element for light/dark mode
- Graceful degradation in all notebooks -- `try/except` guards for optional `tabulate` and `matplotlib` imports
- Cross-references between related notebooks as clickable markdown links

### Changed

- **README.md** -- Rewritten from template placeholder to full project landing page with notebook table, prerequisites, quick start, cloud alternatives, and contributor guide
- **pyproject.toml** -- Updated name, description, author; added `tabulate` to data extras

### Removed

- `notebooks/example.ipynb` -- Template placeholder notebook replaced by 7 real notebooks

## [0.0.0] - 2026-02-19

### Added

- Initial project scaffolding from Jupyter notebook template
- Basic `pyproject.toml` with uv, Jupyter, and optional data/dev extras
- CI workflow for notebook linting and validation
- Dependabot auto-merge workflow

[Unreleased]: https://github.com/zircote/farm-notebook-examples/compare/v0.0.0...HEAD
[0.0.0]: https://github.com/zircote/farm-notebook-examples/releases/tag/v0.0.0
