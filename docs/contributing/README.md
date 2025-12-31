# Contributing to Axionyx

Thank you for your interest in contributing to Axionyx! This guide will help you get started with contributing to the project.

---

## Overview

Axionyx is an open-source platform for controlling biomedical devices. We welcome contributions of all kinds:

- Bug reports and feature requests
- Code contributions (features, bug fixes, improvements)
- Documentation improvements
- Testing and QA
- Community support

---

## Quick Navigation

- **[Code Style Guide](code-style.md)** - Coding standards for all components
- **[Git Workflow](git-workflow.md)** - Branching and commit conventions
- **[Documentation Guide](documentation.md)** - Writing documentation
- **[Testing Guidelines](testing-guidelines.md)** - Testing best practices

---

## Getting Started

### Prerequisites

1. **GitHub Account** - Required for contributing
2. **Development Environment** - See [Getting Started](../getting-started/README.md)
3. **Familiarity with Git** - Basic Git knowledge required

### First-Time Setup

1. **Fork the Repository**
   ```bash
   # Visit https://github.com/axionyx/axionyx and click "Fork"
   ```

2. **Clone Your Fork**
   ```bash
   git clone https://github.com/YOUR-USERNAME/axionyx.git
   cd axionyx
   ```

3. **Add Upstream Remote**
   ```bash
   git remote add upstream https://github.com/axionyx/axionyx.git
   ```

4. **Install Pre-commit Hooks**
   ```bash
   cp .githooks/pre-commit .git/hooks/pre-commit
   chmod +x .git/hooks/pre-commit
   ```

5. **Set Up Development Environment**
   - Follow component-specific setup guides in [Getting Started](../getting-started/README.md)

---

## How to Contribute

### Reporting Bugs

**Before Submitting:**
- Check if the bug has already been reported
- Verify it's reproducible on the latest version
- Gather relevant information (logs, screenshots, steps to reproduce)

**Bug Report Template:**
```markdown
## Description
Brief description of the bug

## Steps to Reproduce
1. Step one
2. Step two
3. See error

## Expected Behavior
What should happen

## Actual Behavior
What actually happens

## Environment
- Firmware version: 1.0.0
- Device type: PCR
- OS: macOS 13.0
- App version: 1.0.0

## Logs
```
Paste relevant logs here
```
```

**Submit via:** GitHub Issues

### Requesting Features

**Feature Request Template:**
```markdown
## Feature Description
Clear description of the feature

## Use Case
Why is this feature needed?

## Proposed Solution
How should it work?

## Alternatives Considered
Other approaches you've considered

## Additional Context
Any other relevant information
```

**Submit via:** GitHub Issues with "enhancement" label

### Contributing Code

#### Step 1: Choose an Issue

- Check [Issues](https://github.com/axionyx/axionyx/issues) for open tasks
- Comment on the issue to express interest
- Wait for maintainer approval before starting work

#### Step 2: Create a Branch

```bash
# Update your fork
git fetch upstream
git checkout main
git merge upstream/main

# Create feature branch
git checkout -b feature/your-feature-name
```

**Branch Naming:**
- `feature/` - New features
- `fix/` - Bug fixes
- `docs/` - Documentation
- `refactor/` - Code refactoring
- `test/` - Adding tests

#### Step 3: Make Changes

- Write clean, well-documented code
- Follow [Code Style Guide](code-style.md)
- Add tests for new features
- Update documentation as needed

#### Step 4: Test Your Changes

```bash
# Firmware
pio test

# Backend
pytest

# Frontend
npm test

# Mobile
flutter test
```

#### Step 5: Commit Changes

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```bash
git add .
git commit -m "feat(firmware): add support for new sensor"
```

See [Git Workflow](git-workflow.md) for commit conventions.

#### Step 6: Push and Create Pull Request

```bash
git push origin feature/your-feature-name
```

Create PR on GitHub with:
- Clear title and description
- Link to related issue
- Screenshots/demos (if applicable)
- Checklist completion

**Pull Request Template:**
```markdown
## Description
Brief description of changes

## Related Issue
Fixes #123

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Tests pass locally
- [ ] Added new tests
- [ ] Manual testing completed

## Checklist
- [ ] Code follows style guide
- [ ] Documentation updated
- [ ] No breaking changes (or documented)
- [ ] Commit messages follow convention
```

---

## Code Review Process

### Review Timeline

- Initial review: 2-3 business days
- Follow-up reviews: 1-2 business days

### Review Criteria

**Code Quality:**
- Follows style guide
- Well-documented
- No unnecessary complexity
- Proper error handling

**Testing:**
- Tests pass
- Adequate test coverage
- Edge cases covered

**Documentation:**
- README updated if needed
- API documentation current
- Comments where necessary

### Addressing Feedback

1. Read all feedback carefully
2. Make requested changes
3. Push updates to same branch
4. Respond to comments
5. Request re-review

---

## Development Guidelines

### Code Style

Follow language-specific style guides:
- **C++:** Google C++ Style Guide
- **Python:** PEP 8 + Black
- **TypeScript:** ESLint + Prettier
- **Dart:** Effective Dart

See [Code Style Guide](code-style.md) for details.

### Git Workflow

**Commit Messages:**
```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

**Types:**
- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation
- `style:` Formatting
- `refactor:` Code restructuring
- `test:` Tests
- `chore:` Maintenance

See [Git Workflow](git-workflow.md) for details.

### Testing

**Minimum Requirements:**
- Unit tests for new code
- Integration tests for APIs
- Manual testing completed

See [Testing Guidelines](testing-guidelines.md) for details.

### Documentation

**Update When:**
- Adding new features
- Changing APIs
- Fixing bugs (if behavior changes)

See [Documentation Guide](documentation.md) for details.

---

## Community Guidelines

### Code of Conduct

**Be Respectful:**
- Treat everyone with respect
- Welcome diverse perspectives
- Accept constructive criticism gracefully

**Be Collaborative:**
- Share knowledge
- Help newcomers
- Review others' code thoughtfully

**Be Professional:**
- Stay on topic
- Avoid inflammatory language
- Focus on technical merit

### Communication Channels

**GitHub Issues:**
- Bug reports
- Feature requests
- Technical discussions

**Pull Requests:**
- Code reviews
- Implementation discussions

**Discussions:**
- General questions
- Ideas and proposals
- Community support

---

## Recognition

### Contributors

All contributors are recognized in:
- GitHub contributors list
- Release notes
- CONTRIBUTORS.md file

### Maintainer Path

Active contributors may be invited to become maintainers with:
- Commit access
- Issue triage permissions
- Code review responsibilities

---

## Legal

### Contributor License Agreement (CLA)

By contributing, you agree that:
- You have the right to submit the code
- Your contribution is under the project's license
- You grant the project rights to use your contribution

### License

All contributions are licensed under the project's license (see LICENSE file).

---

## Getting Help

### Resources

- [Documentation](../README.md)
- [Development Guides](../development/README.md)
- [API Reference](../reference/README.md)

### Support Channels

- **GitHub Issues:** Bug reports and feature requests
- **Discussions:** General questions
- **Email:** developers@axionyx.com (for sensitive matters)

---

## Component-Specific Guidelines

### Firmware Contributions

**Focus Areas:**
- New device types
- Sensor integrations
- Performance optimizations
- Bug fixes

**Requirements:**
- Test on real hardware
- Maintain compatibility
- Document pin configurations

See [Firmware Development](../development/firmware/overview.md)

### Backend Contributions

**Focus Areas:**
- API endpoints
- Database models
- Business logic
- Performance

**Requirements:**
- Write tests (80%+ coverage)
- Follow FastAPI patterns
- Document endpoints

See [Backend Development](../development/backend/overview.md)

### Frontend Contributions

**Focus Areas:**
- UI components
- Pages and layouts
- State management
- Accessibility

**Requirements:**
- Responsive design
- Accessibility (WCAG 2.1)
- Browser compatibility

See [Frontend Development](../development/frontend/overview.md)

### Mobile Contributions

**Focus Areas:**
- Screens and widgets
- Device integration
- Platform features
- Performance

**Requirements:**
- Test on iOS and Android
- Follow platform guidelines
- Optimize performance

See [Mobile Development](../development/mobile/overview.md)

---

## Release Process

### Versioning

**Semantic Versioning (SemVer):**
- MAJOR: Breaking changes
- MINOR: New features (backward compatible)
- PATCH: Bug fixes

### Release Cycle

- **Firmware:** Monthly releases
- **Apps:** Bi-weekly releases
- **Hotfixes:** As needed

### Changelog

All changes documented in CHANGELOG.md following [Keep a Changelog](https://keepachangelog.com/).

---

## FAQ

**Q: I'm new to open source. How do I start?**
A: Look for issues labeled "good first issue" or "help wanted". These are great starting points!

**Q: How long does code review take?**
A: Typically 2-3 business days for initial review. Complex PRs may take longer.

**Q: Can I work on an issue without assignment?**
A: Comment on the issue first to avoid duplicate work. Wait for maintainer approval.

**Q: My PR got rejected. What should I do?**
A: Read the feedback, ask questions if unclear, and either revise or discuss alternatives.

**Q: How do I become a maintainer?**
A: Contribute consistently, help with reviews, and demonstrate technical expertise. Maintainers are invited.

---

## Thank You!

Your contributions make Axionyx better for everyone. We appreciate your time and effort!

---

[← Back to Documentation Home](../README.md)
