#!/bin/bash

# Script to fix globals.css and Tailwind CSS setup for PEO v.3

# Step 1: Install Tailwind CSS dependencies
echo "Installing Tailwind CSS dependencies..."
npm install -D tailwindcss postcss autoprefixer

# Step 2: Initialize Tailwind CSS
echo "Initializing Tailwind CSS..."
npx tailwindcss init -p

# Step 3: Configure tailwind.config.js
echo "Configuring tailwind.config.js..."
cat <<EOL > tailwind.config.js
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/**/*.{js,ts,jsx,tsx,mdx}',
    './pages/**/*.{js,ts,jsx,tsx,mdx}',
    './components/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {},
  },
  plugins: [],
};
EOL

# Step 4: Create globals.css
echo "Creating app/globals.css..."
mkdir -p app
cat <<EOL > app/globals.css
@tailwind base;
@tailwind components;
@tailwind utilities;
EOL

# Step 5: Update app/layout.tsx
echo "Updating app/layout.tsx..."
cat <<EOL > app/layout.tsx
import './globals.css';
import type { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'ProfePersonal',
  description: 'Plataforma educativa para estudiantes de 7mo a 12do',
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="es">
      <body className="bg-gray-900 text-white">{children}</body>
    </html>
  );
}
EOL

# Step 6: Restart development server
echo "Setup complete. Please restart the development server:"
echo "npm run dev"
