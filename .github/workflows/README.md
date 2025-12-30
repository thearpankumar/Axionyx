# GitHub Actions Workflows

Automated CI workflows for Axionyx project components.

## Workflows

### 🐍 Backend CI (`backend-ci.yml`)
- **Triggers**: Changes in `backend/` directory
- **Actions**:
  - Install uv and Python
  - Install dependencies
  - Run tests with pytest

### ⚛️ Frontend CI (`frontend-ci.yml`)
- **Triggers**: Changes in `frontend/` directory
- **Actions**:
  - Setup Node.js
  - Install npm dependencies
  - Run ESLint
  - Build Next.js app

### 📱 Mobile CI (`mobile-ci.yml`)
- **Triggers**: Changes in `mobile/` directory
- **Actions**:
  - Setup Flutter
  - Get dependencies
  - Run Flutter analyze
  - Run tests
  - Build debug APK

### 🔧 Firmware CI (`firmware-ci.yml`)
- **Triggers**: Changes in `firmware/` directory
- **Actions**:
  - Setup Arduino CLI
  - Install ESP32 core
  - Verify firmware structure

## Path Filters

Each workflow only runs when files in its specific directory change, saving CI minutes and reducing noise.
