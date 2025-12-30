"""Placeholder test to ensure pytest runs successfully."""


def test_placeholder():
    """Basic placeholder test."""
    assert True


def test_project_setup():
    """Test that basic imports work."""
    import sys
    from pathlib import Path

    # Verify Python version
    assert sys.version_info >= (3, 12)

    # Verify project structure
    backend_dir = Path(__file__).parent.parent
    assert (backend_dir / "src").exists()
    assert (backend_dir / "pyproject.toml").exists()
