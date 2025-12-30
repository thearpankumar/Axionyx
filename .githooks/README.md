# Git Hooks

This directory contains git hooks for the Axionyx project.

## Installation

Run the installation script to set up the hooks:

```bash
./.githooks/install-hooks.sh
```

Or manually:

```bash
cp .githooks/pre-commit .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

## Available Hooks

### pre-commit

Runs automatically before each commit and performs the following checks:

#### Backend (Python) - only if `backend/` files changed
- ✅ Ruff linting with auto-fix
- ✅ Ruff formatting

#### Frontend (Next.js) - only if `frontend/` files changed
- ✅ ESLint
- ✅ TypeScript type checking

#### Mobile (Flutter) - only if `mobile/` files changed
- ✅ Dart formatting
- ✅ Flutter analyze

#### General Checks
- ⚠️ Trailing whitespace detection
- ℹ️ TODO/FIXME comment detection

## Skipping Hooks

If you need to skip hooks for a single commit:

```bash
git commit --no-verify -m "your message"
```

## Requirements

Make sure you have the following tools installed:

- **Backend**: `uv` (for Python dependency management)
- **Frontend**: `node` and `npm` (with dependencies installed)
- **Mobile**: `flutter` and `dart`

The hook will gracefully skip checks if the required tools are not found.
