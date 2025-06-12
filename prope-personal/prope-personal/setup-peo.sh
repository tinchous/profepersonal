#!/bin/bash

# Colores para la salida
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # Sin color

# Función para mostrar mensajes
print_message() {
  echo -e "${2}[${1}] ${3}${NC}"
}

# 1. Crear o limpiar la estructura del proyecto
print_message "INFO" $YELLOW "Limpando y reorganizando estructura del proyecto..."

# Eliminar duplicados y carpetas innecesarias
rm -rf app/tiz app/tpp app/gte app/tep app/auth/register app/auth/signin app/api/auth/register app/api/auth/signin 2>/dev/null

# Renombrar carpetas a nombres estandarizados
mv app/generatusejercicios app/gte 2>/dev/null || print_message "WARNING" $YELLOW "generatusejercicios ya existe, saltando..."
mv app/tuexampersonal app/tep 2>/dev/null || print_message "WARNING" $YELLOW "tuexampersonal ya existe, saltando..."
mv app/tizaia app/tiz 2>/dev/null || print_message "WARNING" $YELLOW "tizaia ya existe, saltando..."
mv app/tuprofeersonal app/tpp 2>/dev/null || print_message "WARNING" $YELLOW "tuprofeersonal ya existe, saltando..."

# Crear estructura básica
mkdir -p app/{auth,api/auth,components} app/{tizaia,tuprofeersonal,generatusejercicios,tuexampersonal,servicios,planes,sobre-nosotros,contacto,terminos,privacidad,blog,revista-peo,herramientas,laboratorios,tienda} 2>/dev/null

# 2. Generar archivos principales
print_message "INFO" $YELLOW "Generando archivos principales..."

# app/globals.css
if [ ! -f app/globals.css ]; then
  cat <<'EOL' > app/globals.css
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  body {
    @apply font-poppins text-base leading-loose text-white min-h-screen h-[100vh] h-[webkit-fill-available] max-h-[100vh] max-h-[webkit-fill-available] m-0 bg-gradient-to-br from-[#1a0033] via-[#330066] to-[#4b0082] overflow-x-hidden;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
  }
}

@layer components {
  .neon-text {
    @apply text-[#00ffff] shadow-[0_0_10px_#00ffff,0_0_20px_#ff00ff,0_0_30px_#ccff00] font-orbitron;
  }
  .neon-link {
    @apply text-[#00ffff] no-underline transition-colors duration-300 hover:text-[#ccff00] hover:underline;
  }
  .neon-button {
    @apply bg-[#ccff00] text-[#000] border-none px-6 py-3 rounded-lg cursor-pointer shadow-[0_0_10px_#00ffff,0_0_20px_#ff00ff] hover:bg-[#99cc00] hover:scale-105 active:scale-95 transition-transform;
  }
  .neon-card {
    @apply bg-[#1a1a1a] p-6 rounded-xl border-2 border-[#00ccff] shadow-[0_0_15px_#00ffff,0_0_25px_#ff00ff] backdrop-blur-md;
  }
  .neon-header {
    @apply bg-[rgba(0,0,0,0.7)] p-4 text-center border-b-2 border-[#00ccff] shadow-[0_0_15px_#00ffff] fixed top-0 w-full z-50 flex justify-between items-center flex-wrap gap-2;
  }
  .neon-footer {
    @apply w-full p-4 text-center bg-[rgba(0,0,0,0.7)] border-t-2 border-[#00ccff] shadow-[0_0_15px_#00ffff];
  }
  .banner {
    @apply bg-[#ff00ff] text-white text-center py-2 px-4 rounded-md mb-4 shadow-[0_0_10px_#ff00ff];
  }
}

@layer utilities {
  .high-contrast {
    @apply bg-white text-black;
    --neon-bg: #ffffff;
    --neon-text: #000000;
    --neon-border: #000000;
    --neon-header-bg: #f0f0f0;
    --neon-shadow: none;
  }
  .high-contrast .neon-header,
  .high-contrast nav,
  .high-contrast section,
  .high-contrast .neon-card,
  .high-contrast .neon-footer {
    @apply bg-[#f0f0f0] border-black;
    box-shadow: none;
  }
  .high-contrast .neon-text,
  .high-contrast .neon-link,
  .high-contrast .neon-button {
    @apply text-black;
    text-shadow: none;
    background: #000000;
    border-color: #000000;
  }
  .high-contrast .neon-button:hover {
    @apply bg-[#333333];
    transform: none;
  }
  .high-contrast input,
  .high-contrast textarea {
    @apply bg-white text-black border-black;
  }
}
EOL
fi

# app/layout.tsx
if [ ! -f app/layout.tsx ]; then
  cat <<'EOL' > app/layout.tsx
import './globals.css'
import { metadata } from './metadata'
import SessionWrapper from './components/SessionWrapper'

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="es">
      <head>
        <meta charSet="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@700&family=Poppins:wght@400;500&display=swap" rel="stylesheet" />
      </head>
      <body>
        <SessionWrapper>
          {children}
        </SessionWrapper>
      </body>
    </html>
  )
}

export const metadata = {
  title: 'Tu Plataforma Educativa Online',
  description: 'PEO: Tu plataforma educativa para 7mo a 12do grado, alineada con ANEP. ¡Gratis en Mayo 2025!',
  keywords: 'plataforma educativa Uruguay, ANEP, liceo, estudiar online, TizaIA, ElProfeTino',
  icons: [{ rel: 'icon', type: 'image/x-icon', url: '/favicon.ico' }],
  canonical: 'https://www.tuplataformaeducativa.online/prope',
}
EOL
fi

# app/components/SessionWrapper.tsx
if [ ! -f app/components/SessionWrapper.tsx ]; then
  cat <<'EOL' > app/components/SessionWrapper.tsx
"use client";

import { SessionProvider } from "next-auth/react";

export default function SessionWrapper({ children }: { children: React.ReactNode }) {
  return <SessionProvider>{children}</SessionProvider>;
}
EOL
fi

# app/page.tsx
if [ ! -f app/page.tsx ]; then
  cat <<'EOL' > app/page.tsx
"use client";

import Link from "next/link";
import Image from "next/image";
import { useSession, signIn, signOut } from "next-auth/react";
import { useState, useEffect } from "react";
import SessionWrapper from "./components/SessionWrapper";

export default function Home() {
  const { data: session } = useSession();
  const [isHighContrast, setIsHighContrast] = useState(false);
  const [activeSection, setActiveSection] = useState("servicios");

  useEffect(() => {
    const savedContrast = localStorage.getItem('highContrast') === 'true';
    if (savedContrast) {
      setIsHighContrast(true);
      document.body.classList.add('high-contrast');
    }

    const showInitialSection = () => {
      setActiveSection("servicios");
      const hash = window.location.hash.toLowerCase();
      if (hash === '#register') {
        // Modal de registro (a implementar)
      }
      const urlParams = new URLSearchParams(window.location.search);
      if (urlParams.get('verified') === 'true') alert('¡Cuenta verificada! Ahora podés iniciar sesión y disfrutar de PEO.');
    };

    showInitialSection();

    const handleHashChange = () => {
      const hash = window.location.hash.toLowerCase();
      if (hash === '#register') {
        // Modal de registro (a implementar)
      }
    };

    window.addEventListener('hashchange', handleHashChange);

    return () => window.removeEventListener('hashchange', handleHashChange);
  }, []);

  const toggleHighContrast = () => {
    setIsHighContrast(!isHighContrast);
    document.body.classList.toggle('high-contrast');
    localStorage.setItem('highContrast', !isHighContrast);
  };

  const showSection = (sectionId: string) => {
    setActiveSection(sectionId);
    setTimeout(() => {
      document.querySelector(`#${sectionId}`)?.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }, 100);
    document.querySelectorAll('nav a').forEach((link) => link.classList.remove('active'));
    document.querySelector(`nav a[href="#${sectionId}"]`)?.classList.add('active');
  };

  return (
    <div className="min-h-screen flex flex-col">
      <header className="neon-header">
        <h1 className="neon-text text-xl md:text-2xl font-orbitron">Tu Plataforma Educativa Online</h1>
        <div className="flex gap-2">
          {!session ? (
            <button onClick={() => signIn()} className="neon-button" aria-label="Ingresar o registrarse">
              Ingresar/Registrarse
            </button>
          ) : (
            <button onClick={() => signOut()} className="neon-button" aria-label="Salir">
              Salir
            </button>
          )}
          <button
            onClick={toggleHighContrast}
            onKeyDown={(e) => { if (e.key === 'Enter' || e.key === ' ') toggleHighContrast(); }}
            className="neon-button bg-[#ff00ff] border-2 border-[#00ccff]"
            aria-label={isHighContrast ? 'Desactivar Modo Alto Contraste' : 'Activar Modo Alto Contraste'}
          >
            {isHighContrast ? 'Desactivar' : 'Modo'} Alto Contraste
          </button>
        </div>
      </header>

      <nav className="fixed top-16 w-full bg-[rgba(0,0,0,0.7)] p-2 border-b-2 border-[#00ccff] shadow-[0_0_15px_#00ffff] z-40">
        <ul className="flex justify-center gap-4 flex-wrap">
          <li><Link href="#servicios" className="neon-link font-orbitron" onClick={() => showSection('servicios')}>Servicios</Link></li>
          <li><Link href="#planes" className="neon-link font-orbitron" onClick={() => showSection('planes')}>Planes</Link></li>
          <li><Link href="/blog" className="neon-link font-orbitron">Blog</Link></li>
          <li><Link href="/revista-peo" className="neon-link font-orbitron">Revista PEO</Link></li>
          <li><Link href="/herramientas" className="neon-link font-orbitron">Herramientas</Link></li>
          <li><Link href="/laboratorios" className="neon-link font-orbitron">Laboratorios</Link></li>
          <li><Link href="/tienda" className="neon-link font-orbitron">Tienda</Link></li>
          <li><Link href="#sobre-nosotros" className="neon-link font-orbitron" onClick={() => showSection('sobre-nosotros')}>Sobre Nosotros</Link></li>
          <li><Link href="#contacto" className="neon-link font-orbitron" onClick={() => showSection('contacto')}>Contacto</Link></li>
        </ul>
      </nav>

      <main className="container mx-auto pt-24 pb-4 flex-grow">
        <section id="servicios" className={activeSection === "servicios" ? "active" : "hidden"}>
          <div className="banner">¡Registrate en Mayo 2025 y obtené el Plan Premium gratis por todo el mes!</div>
          <h2 className="neon-text text-2xl md:text-3xl font-orbitron mb-6 text-center">Servicios</h2>
          <div className="grid grid-cols-1 md:grid-cols-5 gap-4">
            <div className="neon-card text-center">
              <h3 className="neon-text text-lg font-orbitron">TizaIA</h3>
              <p className="text-white">Resolvé dudas de cualquier materia de 7mo a 12do con explicaciones claras.</p>
              <Link href="/tizaia" className="neon-button mt-2 block">Probar TIZ</Link>
            </div>
            <div className="neon-card text-center">
              <h3 className="neon-text text-lg font-orbitron">TuProfePersonal</h3>
              <p className="text-white">Clases virtuales adaptadas a tu nivel.</p>
              <Link href="/tuprofeersonal" className="neon-button mt-2 block">Probar TPP</Link>
            </div>
            <div className="neon-card text-center">
              <h3 className="neon-text text-lg font-orbitron">GeneraTusEjercicios</h3>
              <p className="text-white">Creá prácticas personalizadas.</p>
              <Link href="/generatusejercicios" className="neon-button mt-2 block">Probar GTE</Link>
            </div>
            <div className="neon-card text-center">
              <h3 className="neon-text text-lg font-orbitron">TuExamenPersonal</h3>
              <p className="text-white">Exámenes personalizados con retroalimentación.</p>
              <Link href="/tuexampersonal" className="neon-button mt-2 block">Probar TEP</Link>
            </div>
            <div className="neon-card text-center">
              <h3 className="neon-text text-lg font-orbitron">Probar PEO</h3>
              <p className="text-white">Explorá nuestras herramientas gratis por 24 horas.</p>
              <button onClick={tryPEO} className="neon-button mt-2 block">Probar Ahora</button>
            </div>
          </div>
        </section>

        <section id="planes" className={activeSection === "planes" ? "active" : "hidden"}>
          <h2 className="neon-text text-2xl md:text-3xl font-orbitron mb-6 text-center">Planes</h2>
          <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
            <div className="neon-card text-center">
              <h3 className="neon-text text-lg font-orbitron">Plan DUDAS</h3>
              <h2 className="text-2xl">GRATIS</h2>
              <p className="text-white">Consultas limitadas a TIZ y GTE.</p>
              <button className="neon-button mt-2" onClick={() => subscribePlan('DUDAS')}>Suscribirme</button>
            </div>
            <div className="neon-card text-center">
              <h3 className="neon-text text-lg font-orbitron">Plan REPASO</h3>
              <h2 className="text-2xl">$200 UYU</h2>
              <p className="text-white">Acceso completo a TIZ y 10 GTE.</p>
              <button className="neon-button mt-2" onClick={() => subscribePlan('REPASO')}>Suscribirme</button>
            </div>
            <div className="neon-card text-center">
              <h3 className="neon-text text-lg font-orbitron">Plan APOYO</h3>
              <h2 className="text-2xl">$400 UYU</h2>
              <p className="text-white">Todo lo anterior + 10 TEP.</p>
              <button className="neon-button mt-2" onClick={() => subscribePlan('APOYO')}>Suscribirme</button>
            </div>
            <div className="neon-card text-center">
              <h3 className="neon-text text-lg font-orbitron">Plan PREMIUM</h3>
              <h2 className="text-2xl">$600 UYU</h2>
              <p className="text-white">Acceso ilimitado a todo.</p>
              <button className="neon-button mt-2" onClick={() => subscribePlan('PREMIUM')}>Suscribirme</button>
            </div>
          </div>
        </section>

        <section id="sobre-nosotros" className={activeSection === "sobre-nosotros" ? "active" : "hidden"}>
          <h2 className="neon-text text-2xl md:text-3xl font-orbitron mb-6 text-center">Sobre Nosotros</h2>
          <p className="text-white mb-4">Apoyamos a estudiantes con herramientas innovadoras.</p>
        </section>

        <section id="contacto" className={activeSection === "contacto" ? "active" : "hidden"}>
          <h2 className="neon-text text-2xl md:text-3xl font-orbitron mb-6 text-center">Contacto</h2>
          <form className="contact-form flex flex-col gap-4 max-w-md mx-auto">
            <input type="text" id="nombre" placeholder="Nombre" required aria-label="Nombre" className="p-2 border-2 border-[#00ccff] bg-[#1a1a1a] rounded-lg" />
            <input type="text" id="apellido" placeholder="Apellido" required aria-label="Apellido" className="p-2 border-2 border-[#00ccff] bg-[#1a1a1a] rounded-lg" />
            <input type="email" id="email" placeholder="Email" required aria-label="Correo electrónico" className="p-2 border-2 border-[#00ccff] bg-[#1a1a1a] rounded-lg" />
            <textarea id="mensaje" placeholder="Mensaje" required aria-label="Mensaje" className="p-2 border-2 border-[#00ccff] bg-[#1a1a1a] rounded-lg h-24"></textarea>
            <button type="button" id="sendEmailButton" aria-label="Enviar mensaje" className="neon-button">Enviar Mensaje</button>
          </form>
          <div className="thank-you hidden text-center mt-4" id="thankYou">
            <p>¡Gracias por tu mensaje! Te contactaremos pronto.</p>
          </div>
        </section>
      </main>

      <footer className="neon-footer">
        <p className="text-white">© 2025 ProfePersonal</p>
      </footer>

      <style>{`
        .hidden { display: none; }
        .active { display: block; }
        @media (max-width: 768px) {
          .neon-header { flex-direction: column; padding: 0.8rem; }
          nav { top: 6.5rem; }
          nav ul { flex-wrap: wrap; gap: 0.5rem; }
          main { margin-top: 8rem; }
          section { padding: 1rem; }
          .grid { grid-template-columns: 1fr; }
          .neon-button { font-size: 0.9rem; padding: 0.5rem; }
        }
        @media (max-width: 480px) {
          .neon-header h1 { font-size: 1.2rem; }
          .neon-button { padding: 0.4rem 0.8rem; font-size: 0.8rem; }
          section h2 { font-size: 1.3rem; }
          nav a { font-size: 0.9rem; }
        }
      `}</style>
    </div>
  );

  async function tryPEO() {
    const tempEmail = `temp_${Date.now()}@tuplataformaeducativa.online`;
    const tempPassword = randomString(12);
    const tempUser = { email: tempEmail, password: tempPassword, curso: '7mo', plan: 'TRIAL' };
    try {
      const response = await fetch('/api/register', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(tempUser),
      });
      if (response.ok) window.location.href = '/tizaia';
      else alert('¡Ups! Error al probar PEO.');
    } catch (error) {
      alert('¡Ups! Error de conexión.');
    }
  }

  function randomString(length: number) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    let result = '';
    for (let i = 0; i < length; i++) result += chars.charAt(Math.floor(Math.random() * chars.length));
    return result;
  }

  async function subscribePlan(plan: string) {
    alert(`¡Gracias por tu interés en el ${plan}! Redirigiendo a pago.`);
    // Integrar MercadoPago/PayPal aquí
  }
}
EOL
fi

# app/auth/page.tsx (Registro)
if [ ! -f app/auth/page.tsx ]; then
  cat <<'EOL' > app/auth/page.tsx
"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";

export default function Register() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [curso, setCurso] = useState("");
  const [error, setError] = useState("");
  const router = useRouter();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    const res = await fetch("/api/register", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ email, password, curso, plan: "TRIAL" }),
    });
    if (res.ok) {
      router.push("/auth/signin");
    } else {
      const data = await res.json();
      setError(data.error || "Error al registrarse");
    }
  };

  return (
    <div className="neon-card p-6 max-w-md mx-auto mt-20">
      <h2 className="neon-text text-2xl font-orbitron mb-4 text-center">Registrarse</h2>
      <form onSubmit={handleSubmit} className="flex flex-col gap-4">
        <input
          type="email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          placeholder="Email"
          required
          aria-label="Correo electrónico"
          className="p-2 border-2 border-[#00ccff] bg-[#1a1a1a] rounded-lg text-white"
        />
        <input
          type="password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          placeholder="Contraseña"
          required
          aria-label="Contraseña"
          className="p-2 border-2 border-[#00ccff] bg-[#1a1a1a] rounded-lg text-white"
        />
        <select
          value={curso}
          onChange={(e) => setCurso(e.target.value)}
          required
          aria-label="Curso"
          className="p-2 border-2 border-[#00ccff] bg-[#1a1a1a] rounded-lg text-white"
        >
          <option value="" disabled>Selecciona tu curso</option>
          <option value="7mo">7mo Grado</option>
          <option value="8vo">8vo Grado</option>
          <option value="9no">9no Grado</option>
          <option value="10mo">10mo Grado</option>
          <option value="11vo">11vo Grado</option>
          <option value="12do">12do Grado</option>
        </select>
        {error && <p className="text-[#ff00ff] text-center">{error}</p>}
        <button type="submit" className="neon-button">Registrarse</button>
      </form>
      <p className="neon-link text-center mt-4" onClick={() => router.push("/auth/signin")}>¿Ya tienes cuenta? Ingresar</p>
    </div>
  );
}
EOL
fi

# app/auth/signin/page.tsx (Iniciar Sesión)
if [ ! -f app/auth/signin/page.tsx ]; then
  mkdir -p app/auth/signin
  cat <<'EOL' > app/auth/signin/page.tsx
"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";

export default function SignIn() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const router = useRouter();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    const res = await fetch("/api/login", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ email, password }),
    });
    if (res.ok) {
      router.push("/tizaia");
    } else {
      const data = await res.json();
      setError(data.error || "Error al iniciar sesión");
    }
  };

  return (
    <div className="neon-card p-6 max-w-md mx-auto mt-20">
      <h2 className="neon-text text-2xl font-orbitron mb-4 text-center">Iniciar Sesión</h2>
      <form onSubmit={handleSubmit} className="flex flex-col gap-4">
        <input
          type="email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          placeholder="Email"
          required
          aria-label="Correo electrónico"
          className="p-2 border-2 border-[#00ccff] bg-[#1a1a1a] rounded-lg text-white"
        />
        <input
          type="password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          placeholder="Contraseña"
          required
          aria-label="Contraseña"
          className="p-2 border-2 border-[#00ccff] bg-[#1a1a1a] rounded-lg text-white"
        />
        {error && <p className="text-[#ff00ff] text-center">{error}</p>}
        <button type="submit" className="neon-button">Ingresar</button>
      </form>
      <p className="neon-link text-center mt-4" onClick={() => router.push("/auth")}>¿No tienes cuenta? Registrarse</p>
    </div>
  );
}
EOL
fi

# app/api/auth/[...nextauth]/route.ts
if [ ! -f app/api/auth/[...nextauth]/route.ts ]; then
  mkdir -p app/api/auth/[...nextauth]
  cat <<'EOL' > app/api/auth/[...nextauth]/route.ts
import NextAuth from "next-auth";
import CredentialsProvider from "next-auth/providers/credentials";
import { PrismaAdapter } from "@next-auth/prisma-adapter";
import { PrismaClient } from "@prisma/client";
import bcrypt from "bcrypt";

const prisma = new PrismaClient();

export const authOptions = {
  adapter: PrismaAdapter(prisma),
  providers: [
    CredentialsProvider({
      name: "Credentials",
      credentials: {
        email: { label: "Email", type: "email" },
        password: { label: "Password", type: "password" },
      },
      async authorize(credentials) {
        const user = await prisma.user.findUnique({ where: { email: credentials?.email } });
        if (!user || !credentials?.password) return null;
        const isValid = await bcrypt.compare(credentials.password, user.password);
        if (isValid) return user;
        return null;
      },
    }),
  ],
  pages: {
    signIn: "/auth/signin",
    signOut: "/auth/signout",
    error: "/auth/error",
    newUser: "/auth",
  },
  callbacks: {
    async signIn({ user, account, profile, email, credentials }) {
      if (user) return true;
      return false;
    },
    async session({ session, token, user }) {
      session.user.id = user.id;
      return session;
    },
  },
};

const handler = NextAuth(authOptions);

export { handler as GET, handler as POST };
EOL
fi

# app/api/contact/route.ts
if [ ! -f app/api/contact/route.ts ]; then
  mkdir -p app/api/contact
  cat <<'EOL' > app/api/contact/route.ts
import { NextResponse } from "next/server";
import { Resend } from "resend";

const resend = new Resend(process.env.RESEND_API_KEY);

export async function POST(request: Request) {
  const { nombre, apellido, email, mensaje } = await request.json();
  try {
    await resend.emails.send({
      from: "contacto@tuplataformaeducativa.online",
      to: email,
      subject: "Confirmación de Contacto - Tu Plataforma Educativa",
      text: \`Hola \${nombre} \${apellido},\n\nGracias por tu mensaje: \${mensaje}\n\nPronto te responderemos.\n\nSaludos,\nProfePersonal\`,
    });
    return NextResponse.json({ message: "Email enviado" }, { status: 200 });
  } catch (error) {
    return NextResponse.json({ error: "Error al enviar email" }, { status: 500 });
  }
}
EOL
fi

# app/api/register/route.ts
if [ ! -f app/api/register/route.ts ]; then
  mkdir -p app/api/register
  cat <<'EOL' > app/api/register/route.ts
import { neon } from '@neondatabase/serverless';
import bcrypt from 'bcrypt';
import { NextResponse } from 'next/server';
import { randomBytes } from 'crypto';
import { Resend } from 'resend';

export async function POST(request: Request) {
  try {
    const { nombre, apellido, email, password, liceo, materias, curso } = await request.json();
    console.log('Datos recibidos:', { nombre, apellido, email, curso });

    // Validar campos obligatorios
    if (!nombre || !apellido || !email || !password || !liceo || !materias || materias.length === 0 || !curso) {
      return NextResponse.json(
        { error: '¡Ups! Todos los campos son obligatorios: nombre, apellido, email, contraseña, liceo, materias y curso.' },
        { status: 400 }
      );
    }

    // Validar curso
    const validCursos = ['7mo', '8vo', '9no', '10mo', '11vo', '12do'];
    if (!validCursos.includes(curso)) {
      return NextResponse.json({ error: '¡Ups! Curso inválido.' }, { status: 400 });
    }

    console.log('DATABASE_URL:', process.env.DATABASE_URL);
    const sql = neon(process.env.DATABASE_URL!);

    const existingUser = await sql`SELECT email FROM users WHERE email = ${email}`;
    console.log('Resultado de existingUser:', existingUser);
    if (existingUser.length > 0) {
      return NextResponse.json(
        { error: '¡Este email ya está registrado! Probá con otro.' },
        { status: 400 }
      );
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    const verificationToken = email.startsWith('temp_') ? null : randomBytes(32).toString('hex');
    const plan = email.startsWith('temp_') ? 'TRIAL' : 'PREMIUM';

    console.log('Ejecutando INSERT');
    const result = await sql`
      INSERT INTO users (
        nombre, apellido, email, password, liceo, materias, curso, plan, verification_token, verified
      ) VALUES (
        ${nombre},
        ${apellido},
        ${email},
        ${hashedPassword},
        ${liceo},
        ${JSON.stringify(materias)}, -- Convertir array a string JSON
        ${curso},
        ${plan},
        ${verificationToken},
        ${email.startsWith('temp_') ? true : false}
      )
      RETURNING id
    `;
    console.log('Resultado de INSERT:', result);

    if (!email.startsWith('temp_')) {
      try {
        const resend = new Resend(process.env.RESEND_API_KEY);
        console.log('Enviando email con Resend a:', email);
        await resend.emails.send({
          from: 'no-reply@tuplataformaeducativa.online',
          to: email,
          subject: '¡Verificá tu cuenta en PEO!',
          html: `
            <h2>¡Bienvenido a PEO, ${nombre}!</h2>
            <p>Hacé clic en el siguiente enlace para verificar tu cuenta:</p>
            <p><a href="https://tuplataformaeducativa.online/api/verify?token=${verificationToken}">Verificar mi cuenta</a></p>
            <p>Si no creaste una cuenta, podés ignorar este mensaje.</p>
            <p>¡Estamos listos para ayudarte a brillar en tus estudios! ✨</p>
          `
        });
      } catch (emailError) {
        console.error('Error enviando email:', emailError);
        return NextResponse.json(
          { message: '¡Registro exitoso! No pudimos enviar el email de verificación, revisá tu correo más tarde.' },
          { status: 200 }
        );
      }
    }

    return NextResponse.json(
      { message: '¡Registro exitoso! Revisá tu correo para verificar tu cuenta.' },
      { status: 200 }
    );
  } catch (error) {
    console.error('Error en registro:', error);
    return NextResponse.json(
      { error: '¡Ups! Algo salió mal. Intentá de nuevo en un ratito.' },
      { status: 500 }
    );
  }
}
EOL
fi

# app/api/login/route.ts
if [ ! -f app/api/login/route.ts ]; then
  mkdir -p app/api/login
  cat <<'EOL' > app/api/login/route.ts
import { neon } from '@neondatabase/serverless';
import { NextResponse } from 'next/server';
import bcrypt from 'bcrypt';

export async function POST(request: Request) {
  try {
    const { email, password } = await request.json();
    if (!email || !password) {
      return NextResponse.json({ error: 'Email y contraseña requeridos.' }, { status: 400 });
    }
    const sql = neon(process.env.DATABASE_URL!);
    const { rows: users } = await sql`SELECT * FROM users WHERE email = ${email}`;
    if (users.length === 0) {
      return NextResponse.json({ error: 'Credenciales incorrectas.' }, { status: 401 });
    }
    const user = users[0];
    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) {
      return NextResponse.json({ error: 'Credenciales incorrectas.' }, { status: 401 });
    }
    return NextResponse.json({ success: true, message: 'Login exitoso.', user: { id: user.id, email } });
  } catch (error) {
    console.error('Error en login:', error);
    return NextResponse.json({ error: 'Error en el servidor.' }, { status: 500 });
  }
}
EOL
fi

# app/api/tts/route.ts
if [ ! -f app/api/tts/route.ts ]; then
  mkdir -p app/api/tts
  cat <<'EOL' > app/api/tts/route.ts
import { NextResponse } from 'next/server';

export async function POST(request: Request) {
  const { text, voice = 'es-US-Neural2-A' } = await request.json();
  try {
    const response = await fetch('https://texttospeech.googleapis.com/v1/text:synthesize', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${process.env.GOOGLE_CLOUD_API_KEY}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        input: { text },
        voice: { languageCode: 'es-US', name: voice },
        audioConfig: { audioEncoding: 'MP3' },
      }),
    });
    if (!response.ok) throw new Error('Error en TTS');
    const { audioContent } = await response.json();
    return NextResponse.json({ audio: audioContent });
  } catch (error) {
    console.error('Error en TTS:', error);
    return NextResponse.json({ error: 'Error al generar audio' }, { status: 500 });
  }
}
EOL
fi

# 3. Inicializar Prisma y configurar base de datos
print_message "INFO" $YELLOW "Verificando y configurando Prisma..."
if [ ! -f prisma/schema.prisma ]; then
  mkdir -p prisma
  cat <<'EOL' > prisma/schema.prisma
generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

model User {
  id                String    @id @default(cuid())
  nombre            String
  apellido          String
  email             String    @unique
  password          String
  liceo             String
  materias          Json      @default("[]")
  curso             String
  plan              String
  verification_token String?
  verified          Boolean   @default(false)
  createdAt         DateTime  @default(now())
}
EOL
  print_message "INFO" $YELLOW "Archivo schema.prisma creado. Ejecuta 'npx prisma generate' y 'npx prisma migrate dev' después de configurar .env.local."
else
  print_message "WARNING" $YELLOW "El archivo prisma/schema.prisma ya existe. Verifica manualmente si necesitas actualizarlo."
fi

# 4. Instalar dependencias
print_message "INFO" $YELLOW "Instalando dependencias..."
npm install next-auth @next-auth/prisma-adapter prisma bcrypt resend tailwindcss postcss autoprefixer @neondatabase/serverless 2>/dev/null || print_message "WARNING" $YELLOW "Algunas dependencias pueden estar ya instaladas."

# 5. Configurar tailwind.config.js
if [ ! -f tailwind.config.js ]; then
  print_message "INFO" $YELLOW "Configurando tailwind.config.js..."
  cat <<'EOL' > tailwind.config.js
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./app/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      fontFamily: {
        poppins: ['Poppins', 'sans-serif'],
        orbitron: ['Orbitron', 'sans-serif'],
      },
    },
  },
  plugins: [],
}
EOL
else
  print_message "WARNING" $YELLOW "El archivo tailwind.config.js ya existe. Verifica manualmente si necesitas actualizarlo."
fi

# 6. Configurar next.config.js para permitir imágenes externas
if [ ! -f next.config.js ]; then
  print_message "INFO" $YELLOW "Configurando next.config.js para permitir imágenes externas..."
  cat <<'EOL' > next.config.js
/** @type {import('next').NextConfig} */
const nextConfig = {
  images: {
    domains: ['via.placeholder.com'],
  },
}

module.exports = nextConfig
EOL
else
  print_message "WARNING" $YELLOW "El archivo next.config.js ya existe. Verifica manualmente si necesitas agregar 'via.placeholder.com' a la propiedad 'images.domains'."
fi

# 7. Crear páginas placeholder
print_message "INFO" $YELLOW "Creando páginas placeholder..."
for page in tizaia tuprofeersonal generatusejercicios tuexampersonal servicios planes sobre-nosotros contacto blog revista-peo herramientas laboratorios tienda; do
  if [ ! -f app/$page/page.tsx ]; then
    cat <<EOL > app/$page/page.tsx
export default function $page() {
  return <div>$page - En desarrollo</div>;
}
EOL
  else
    print_message "WARNING" $YELLOW "La página $page/page.tsx ya existe, saltando..."
  fi
done

# 8. Limpiar caché de Next.js
print_message "INFO" $YELLOW "Limpiando caché de Next.js..."
rm -rf .next 2>/dev/null

# 9. Instrucciones finales
print_message "SUCCESS" $GREEN "Configuración completa a las 04:02 AM -03 del 12/06/2025!"
print_message "INFO" $YELLOW "Por favor, configura las variables de entorno en .env.local:"
cat <<EOL

RESEND_API_KEY=tu_clave_api_resend
DATABASE_URL=postgresql://usuario:contraseña@neon-host:port/dbname?sslmode=require
GOOGLE_CLOUD_API_KEY=tu_clave_api_google

EOL
print_message "INFO" $YELLOW "Luego, ejecuta los siguientes comandos manualmente si es necesario:"
print_message "INFO" $YELLOW "  - npx prisma generate"
print_message "INFO" $YELLOW "  - npx prisma migrate dev"
print_message "INFO" $YELLOW "Finalmente, reinicia el servidor con: npm run dev"
