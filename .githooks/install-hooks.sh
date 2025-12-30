#!/bin/bash

# Script to install git hooks

echo "📦 Installing git hooks..."

# Get the git root directory
GIT_ROOT=$(git rev-parse --show-toplevel)

# Copy hooks to .git/hooks
cp "$GIT_ROOT/.githooks/pre-commit" "$GIT_ROOT/.git/hooks/pre-commit"
chmod +x "$GIT_ROOT/.git/hooks/pre-commit"

echo "✅ Git hooks installed successfully!"
echo ""
echo "The following hooks were installed:"
echo "  - pre-commit (runs linting and checks for backend, frontend, mobile)"
echo ""
echo "To skip hooks for a single commit, use: git commit --no-verify"
