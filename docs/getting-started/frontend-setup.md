# Frontend Development Setup

**Next.js Web Dashboard Setup Guide**

This guide covers setting up the Axionyx web dashboard for development.

---

## Overview

The Axionyx frontend is built with:
- **Next.js 16.1** - React framework with App Router
- **React 19.2** - UI library
- **TypeScript 5** - Type-safe JavaScript
- **Tailwind CSS v4** - Utility-first CSS framework
- **ESLint** - Code linting

**Current Status:** In early development

---

## Prerequisites

### Required Software

- **Node.js 18+** - JavaScript runtime
- **npm 9+** or **yarn 1.22+** - Package manager
- **Git** - Version control

### Operating System

Supported on Linux, macOS, and Windows 10/11

---

## Installation

### Step 1: Verify Node.js Installation

```bash
# Check Node.js version
node --version
# Should output: v18.x.x or higher

# Check npm version
npm --version
# Should output: 9.x.x or higher

# If Node.js not installed:
# Download from https://nodejs.org/
# Or use nvm (recommended)
```

### Using nvm (Node Version Manager)

```bash
# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Install Node.js 18
nvm install 18
nvm use 18

# Set default
nvm alias default 18
```

### Step 2: Clone Repository (if not done)

```bash
git clone https://github.com/axionyx/axionyx.git
cd axionyx/frontend
```

### Step 3: Install Dependencies

```bash
# Install all dependencies
npm install

# Or using yarn
yarn install

# Expected output:
# added XXX packages in Xs
# No vulnerabilities found
```

---

## Project Structure

```
frontend/
├── app/                     # Next.js app directory
│   ├── layout.tsx          # Root layout
│   ├── page.tsx            # Home page
│   ├── globals.css         # Global styles
│   └── api/                # API routes (future)
├── components/             # Reusable components (future)
│   ├── ui/                 # UI components
│   └── features/           # Feature components
├── lib/                    # Utilities and helpers (future)
│   ├── api.ts             # API client
│   └── utils.ts           # Helper functions
├── public/                 # Static assets
│   ├── favicon.ico
│   └── images/
├── styles/                 # Additional styles (future)
├── next.config.ts          # Next.js configuration
├── tailwind.config.ts      # Tailwind configuration
├── tsconfig.json           # TypeScript configuration
├── package.json            # Dependencies and scripts
└── README.md
```

---

## Configuration

### Environment Variables

```bash
# Create .env.local file
cat > .env.local << 'EOF'
# API Configuration
NEXT_PUBLIC_API_URL=http://localhost:8000
NEXT_PUBLIC_WS_URL=ws://localhost:8000/ws

# Device Configuration
NEXT_PUBLIC_DEFAULT_DEVICE_IP=192.168.4.1

# Feature Flags
NEXT_PUBLIC_ENABLE_MOCK_DATA=true
NEXT_PUBLIC_ENABLE_ANALYTICS=false
EOF
```

**Environment Files:**
- `.env.local` - Local development (not committed)
- `.env.development` - Development defaults
- `.env.production` - Production values

### Next.js Configuration

```typescript
// next.config.ts
import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  reactStrictMode: true,
  swcMinify: true,

  // API proxy (for development)
  async rewrites() {
    return [
      {
        source: '/api/:path*',
        destination: 'http://localhost:8000/api/:path*',
      },
    ];
  },
};

export default nextConfig;
```

---

## Running the Development Server

### Start Development Mode

```bash
# Start Next.js development server
npm run dev

# Or with yarn
yarn dev

# Expected output:
# ▲ Next.js 16.1.1
# - Local:        http://localhost:3000
# - Ready in XXXms
```

### Access the Application

- **Local:** http://localhost:3000
- **Network:** http://[your-ip]:3000

### Hot Module Replacement

Changes to files will automatically reload in the browser.

---

## Development

### Creating Components

**1. Create Component File:**
```typescript
// components/ui/Button.tsx
import React from 'react';

interface ButtonProps {
  children: React.ReactNode;
  onClick?: () => void;
  variant?: 'primary' | 'secondary';
  disabled?: boolean;
}

export function Button({
  children,
  onClick,
  variant = 'primary',
  disabled = false
}: ButtonProps) {
  const baseStyles = 'px-4 py-2 rounded-lg font-medium transition-colors';
  const variantStyles = {
    primary: 'bg-blue-600 text-white hover:bg-blue-700',
    secondary: 'bg-gray-200 text-gray-800 hover:bg-gray-300',
  };

  return (
    <button
      onClick={onClick}
      disabled={disabled}
      className={`${baseStyles} ${variantStyles[variant]} ${
        disabled ? 'opacity-50 cursor-not-allowed' : ''
      }`}
    >
      {children}
    </button>
  );
}
```

**2. Use Component:**
```typescript
// app/page.tsx
import { Button } from '@/components/ui/Button';

export default function Home() {
  return (
    <div className="p-8">
      <h1 className="text-3xl font-bold mb-4">Axionyx Dashboard</h1>
      <Button onClick={() => alert('Clicked!')}>
        Click Me
      </Button>
    </div>
  );
}
```

### Creating Pages

**1. Create Route:**
```typescript
// app/devices/page.tsx
export default function DevicesPage() {
  return (
    <div>
      <h1>Devices</h1>
      <p>List of devices will appear here</p>
    </div>
  );
}
```

**2. Access Page:**
- Navigate to http://localhost:3000/devices

### API Integration

**Create API Client:**
```typescript
// lib/api.ts
const API_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:8000';

export async function fetchDevices() {
  const response = await fetch(`${API_URL}/api/v1/devices`);
  if (!response.ok) {
    throw new Error('Failed to fetch devices');
  }
  return response.json();
}

export async function startDevice(deviceId: string, setpoint: number) {
  const response = await fetch(`http://${deviceId}/api/v1/device/start`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ setpoint }),
  });
  return response.json();
}
```

**Use in Component:**
```typescript
// app/devices/page.tsx
'use client';

import { useEffect, useState } from 'react';
import { fetchDevices } from '@/lib/api';

export default function DevicesPage() {
  const [devices, setDevices] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchDevices()
      .then(setDevices)
      .catch(console.error)
      .finally(() => setLoading(false));
  }, []);

  if (loading) return <div>Loading...</div>;

  return (
    <div>
      <h1>Devices</h1>
      <ul>
        {devices.map((device: any) => (
          <li key={device.id}>{device.name}</li>
        ))}
      </ul>
    </div>
  );
}
```

---

## Styling with Tailwind CSS

### Using Utility Classes

```tsx
<div className="container mx-auto px-4 py-8">
  <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
    <div className="bg-white rounded-lg shadow-md p-6">
      <h2 className="text-xl font-bold mb-2">Device Name</h2>
      <p className="text-gray-600">Status: Online</p>
    </div>
  </div>
</div>
```

### Custom CSS (when needed)

```css
/* app/globals.css */
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer components {
  .btn-primary {
    @apply px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700;
  }

  .card {
    @apply bg-white rounded-lg shadow-md p-6;
  }
}
```

---

## Building for Production

### Create Production Build

```bash
# Build optimized production bundle
npm run build

# Output:
# Route (app)              Size     First Load JS
# ├ ○ /                    5.02 kB     90.1 kB
# └ ○ /devices            3.41 kB     88.5 kB
```

### Run Production Server

```bash
# Start production server
npm start

# Access at http://localhost:3000
```

### Static Export (Optional)

```bash
# Update next.config.ts
const nextConfig: NextConfig = {
  output: 'export',
};

# Build static files
npm run build

# Output in: out/
# Deploy to static hosting (Vercel, Netlify, etc.)
```

---

## Testing

### Linting

```bash
# Run ESLint
npm run lint

# Fix auto-fixable issues
npm run lint -- --fix
```

### Type Checking

```bash
# Run TypeScript compiler
npx tsc --noEmit
```

### Unit Tests (Future)

```bash
# Install Jest and React Testing Library
npm install --save-dev jest @testing-library/react @testing-library/jest-dom

# Run tests
npm test
```

**Example Test:**
```typescript
// __tests__/components/Button.test.tsx
import { render, screen, fireEvent } from '@testing-library/react';
import { Button } from '@/components/ui/Button';

describe('Button', () => {
  it('renders button with text', () => {
    render(<Button>Click me</Button>);
    expect(screen.getByText('Click me')).toBeInTheDocument();
  });

  it('calls onClick when clicked', () => {
    const handleClick = jest.fn();
    render(<Button onClick={handleClick}>Click me</Button>);
    fireEvent.click(screen.getByText('Click me'));
    expect(handleClick).toHaveBeenCalledTimes(1);
  });
});
```

---

## Troubleshooting

### Common Issues

**Port 3000 Already in Use:**
```bash
# Use different port
PORT=3001 npm run dev

# Or kill process using port 3000
lsof -i :3000  # Find PID
kill -9 <PID>
```

**Module Not Found:**
```bash
# Clear Next.js cache
rm -rf .next

# Reinstall dependencies
rm -rf node_modules package-lock.json
npm install
```

**TypeScript Errors:**
```bash
# Regenerate types
npx next dev

# Check tsconfig.json
# Ensure "strict": true
```

**Hydration Errors:**
```tsx
// Ensure server and client render same content
// Use 'use client' for client-only components
'use client';

export function ClientOnlyComponent() {
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
  }, []);

  if (!mounted) return null;

  return <div>Client content</div>;
}
```

---

## Best Practices

### File Organization

```
components/
├── ui/              # Generic UI components
│   ├── Button.tsx
│   ├── Card.tsx
│   └── Input.tsx
├── features/        # Feature-specific components
│   ├── DeviceCard.tsx
│   └── DeviceList.tsx
└── layouts/         # Layout components
    ├── Header.tsx
    └── Footer.tsx
```

### Component Patterns

**Server Components (default):**
```tsx
// app/devices/page.tsx
async function getDevices() {
  const res = await fetch('http://api.example.com/devices');
  return res.json();
}

export default async function DevicesPage() {
  const devices = await getDevices();
  return <DeviceList devices={devices} />;
}
```

**Client Components:**
```tsx
// components/DeviceControl.tsx
'use client';

import { useState } from 'react';

export function DeviceControl() {
  const [temperature, setTemperature] = useState(25);

  return (
    <div>
      <input
        type="number"
        value={temperature}
        onChange={(e) => setTemperature(Number(e.target.value))}
      />
    </div>
  );
}
```

### Performance Optimization

```tsx
// Use dynamic imports for large components
import dynamic from 'next/dynamic';

const HeavyComponent = dynamic(() => import('./HeavyComponent'), {
  loading: () => <p>Loading...</p>,
});

// Optimize images
import Image from 'next/image';

<Image
  src="/device.png"
  alt="Device"
  width={400}
  height={300}
  priority
/>
```

---

## Next Steps

### Development

1. **Build Components:** Create reusable UI components
2. **Add Pages:** Implement device management pages
3. **Integrate API:** Connect to backend/device APIs
4. **Add State Management:** Implement global state (if needed)

### Resources

- [Next.js Documentation](https://nextjs.org/docs)
- [React Documentation](https://react.dev/)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)
- [Frontend Development Guide](../development/frontend/overview.md)

---

[← Back to Getting Started](README.md) | [Documentation Home](../README.md)
