#!/bin/bash

# Script to fix Client Component event handler error for PEO v.3

# Step 1: Remove misplaced app/api/auth/signin/page.tsx
echo "Removing misplaced app/api/auth/signin/page.tsx..."
rm app/api/auth/signin/page.tsx 2>/dev/null || true

# Step 2: Verify app/auth/signin/page.tsx
echo "Verifying app/auth/signin/page.tsx..."
mkdir -p app/auth/signin
cat <<EOL > app/auth/signin/page.tsx
"use client";

import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { signIn } from "next-auth/react";
import Link from "next/link";

export default function SignInPage() {
  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    const formData = new FormData(e.currentTarget);
    await signIn("credentials", {
      username: formData.get("username"),
      password: formData.get("password"),
      redirect: true,
      callbackUrl: "/",
    });
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-900">
      <form
        onSubmit={handleSubmit}
        className="bg-gray-800 p-6 rounded shadow-md space-y-4"
        aria-label="Formulario de inicio de sesión"
      >
        <h2 className="text-2xl font-bold text-center">Iniciar Sesión</h2>
        <div>
          <label htmlFor="username" className="block text-sm">
            Usuario
          </label>
          <Input
            id="username"
            name="username"
            type="text"
            required
            className="bg-gray-700 text-white"
            aria-required="true"
            placeholder="Ingrese su usuario"
          />
        </div>
        <div>
          <label htmlFor="password" className="block text-sm">
            Contraseña
          </label>
          <Input
            id="password"
            name="password"
            type="password"
            required
            className="bg-gray-700 text-white"
            aria-required="true"
            placeholder="Ingrese su contraseña"
          />
        </div>
        <Button type="submit" className="w-full bg-blue-600 hover:bg-blue-700">
          Iniciar Sesión
        </Button>
        <p className="text-center text-sm">
          ¿No tiene cuenta?{" "}
          <Link href="/auth/register" className="text-blue-400">
            Registrarse
          </Link>
        </p>
      </form>
    </div>
  );
}
EOL

# Step 3: Verify app/auth/register/page.tsx
echo "Verifying app/auth/register/page.tsx..."
mkdir -p app/auth/register
cat <<EOL > app/auth/register/page.tsx
"use client";

import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { useState } from "react";

export default function RegisterPage() {
  const router = useRouter();
  const [error, setError] = useState<string | null>(null);

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    const formData = new FormData(e.currentTarget);
    const username = formData.get("username") as string;
    const email = formData.get("email") as string;
    const password = formData.get("password") as string;

    try {
      const response = await fetch("/api/auth/register", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ username, email, password }),
      });

      if (response.ok) {
        router.push("/auth/signin");
      } else {
        const data = await response.json();
        setError(data.error || "Error al registrarse");
      }
    } catch {
      setError("Error al conectar con el servidor");
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-900">
      <form
        onSubmit={handleSubmit}
        className="bg-gray-800 p-6 rounded shadow-md space-y-4"
        aria-label="Formulario de registro"
      >
        <h2 className="text-2xl font-bold text-center">Registrarse</h2>
        {error && <p className="text-red-500 text-center">{error}</p>}
        <div>
          <label htmlFor="username" className="block text-sm">
            Usuario
          </label>
          <Input
            id="username"
            name="username"
            type="text"
            required
            className="bg-gray-700 text-white"
            aria-required="true"
            placeholder="Ingrese su usuario"
          />
        </div>
        <div>
          <label htmlFor="email" className="block text-sm">
            Correo Electrónico
          </label>
          <Input
            id="email"
            name="email"
            type="email"
            required
            className="bg-gray-700 text-white"
            aria-required="true"
            placeholder="Ingrese su correo"
          />
        </div>
        <div>
          <label htmlFor="password" className="block text-sm">
            Contraseña
          </label>
          <Input
            id="password"
            name="password"
            type="password"
            required
            className="bg-gray-700 text-white"
            aria-required="true"
            placeholder="Ingrese su contraseña"
          />
        </div>
        <Button type="submit" className="w-full bg-blue-600 hover:bg-blue-700">
          Registrarse
        </Button>
        <p className="text-center text-sm">
          ¿Ya tiene cuenta?{" "}
          <Link href="/auth/signin" className="text-blue-400">
            Iniciar Sesión
          </Link>
        </p>
      </form>
    </div>
  );
}
EOL

# Step 4: Install dependencies
echo "Installing dependencies..."
npm install next-auth bcrypt @types/bcrypt @prisma/client prisma

# Step 5: Install shadcn/ui components
echo "Installing shadcn/ui Button and Input components..."
npx shadcn-ui@latest add button input

# Step 6: Clear Next.js cache
echo "Clearing Next.js cache..."
rm -rf .next

# Step 7: Restart development server
echo "Setup complete. Please restart the development server:"
echo "npm run dev"
