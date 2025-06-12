#!/bin/bash

# Step 1: Verificar o mover galaxias.jpg
echo "Verificando galaxias.jpg..."
if [ ! -f public/galaxias.jpg ]; then
  echo "Moviendo galaxias.jpg a public/ (ajusta la ruta si es necesario)"
  mv /ruta/a/galaxias.jpg public/galaxias.jpg 2>/dev/null || echo "Por favor, coloca galaxias.jpg en public/"
fi

# Step 2: Crear o actualizar app/globals.css
echo "Actualizando app/globals.css..."
mkdir -p app
cat <<EOL > app/globals.css
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  body {
    @apply font-sans text-xl leading-loose text-white min-h-screen h-[100vh] h-[webkit-fill-available] max-h-[100vh] max-h-[webkit-fill-available] m-0;
    font-family: 'sf pro text', 'helvetica neue', helvetica, arial, sans-serif;
    background: linear-gradient(135deg, #121212, #1a0033);
    background-image: url('/galaxias.jpg');
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    overflow: hidden;
  }
}

@layer components {
  .neon-text {
    @apply text-[#00ffff] shadow-[0_0_10px_#00ffff,_0_0_20px_#ff00ff,_0_0_30px_#ccff00];
  }
  .neon-link {
    @apply text-[#00ffff] no-underline transition-colors duration-300 hover:text-[#ff00ff];
  }
  .neon-button {
    @apply bg-[#ccff00] text-[#121212] border-none px-4 py-2 rounded-full cursor-pointer shadow-[0_0_10px_#00ffff,_0_0_20px_#ff00ff] hover:bg-[#99cc00] hover:scale-105;
  }
  .neon-card {
    @apply bg-[#1a1a1a] p-4 rounded-lg border-4 border-[#00ccff] shadow-[0_0_15px_#00ffff,_0_0_25px_#ff00ff];
  }
  .neon-header {
    @apply bg-[#1a1a1a] p-4 text-center border-b-4 border-[#00ccff] shadow-[0_0_15px_#00ffff];
  }
}
EOL

# Step 3: Crear o actualizar app/layout.tsx
echo "Actualizando app/layout.tsx..."
cat <<EOL > app/layout.tsx
import './globals.css'

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="es">
      <body>{children}</body>
    </html>
  )
}
EOL

# Step 4: Crear o actualizar app/page.tsx
echo "Actualizando app/page.tsx..."
cat <<'EOL' > app/page.tsx
"use client";

import Link from "next/link";
import Image from "next/image";
import { useSession, signIn, signOut } from "next-auth/react";

export default function Home() {
  const { data: session } = useSession();

  return (
    <div className="min-h-screen flex flex-col">
      <header className="neon-header">
        <Image
          src="/logo.png"
          alt="Tu Plataforma Educativa Online Logo"
          width={150}
          height={50}
          className="mx-auto object-contain"
        />
        <h1 className="text-3xl neon-text mt-2">Tu Plataforma Educativa Online</h1>
        <nav className="page-controls mt-4">
          <ul className="flex justify-center gap-4">
            <li><Link href="/" className="neon-link">Inicio</Link></li>
            <li><Link href="/servicios" className="neon-link">Servicios</Link></li>
            <li><Link href="/planes" className="neon-link">Planes</Link></li>
            <li><Link href="/sobre-nosotros" className="neon-link">Sobre Nosotros</Link></li>
            <li><Link href="/contacto" className="neon-link">Contacto</Link></li>
            <li><Link href="/blog" className="neon-link">Blog</Link></li>
            <li><Link href="/revista-peo" className="neon-link">Revista PEO</Link></li>
            <li><Link href="/herramientas" className="neon-link">Herramientas</Link></li>
            <li><Link href="/tienda" className="neon-link">Tienda</Link></li>
          </ul>
        </nav>
        <div className="page-controls mt-2">
          {!session ? (
            <button onClick={() => signIn("google")} className="neon-button">
              Ingresar/Registrarse
            </button>
          ) : (
            <button onClick={() => signOut()} className="neon-button">
              Salir
            </button>
          )}
          <button
            className="neon-button"
            onClick={() => document.body.classList.toggle("high-contrast")}
          >
            Modo Alto Contraste
          </button>
        </div>
      </header>

      <div className="bg-purple-900 p-2 text-center text-white">
        ¡Registrate en Mayo 2025 y obtené el Plan Premium gratis por todo el mes!
      </div>

      <main className="container mx-auto p-6 flex-grow">
        <h2 className="text-2xl neon-text text-center mb-6">Servicios</h2>
        <div className="grid grid-cols-1 md:grid-cols-5 gap-4">
          <div className="neon-card text-center">
            <h3 className="text-xl neon-text">TizaIA</h3>
            <p className="text-white">
              Resuelve dudas de cualquier materia de 7mo a 12do con explicaciones
              claras. Por ejemplo, preguntá cómo resolver una ecuación cuadrática
              y TizaIA te guiará paso a paso con ejemplos prácticos. ¡Ideal para
              aprender a tu ritmo!
            </p>
            <Link href="/tizaia" className="neon-button mt-2 block">Probar TIZ</Link>
          </div>
          <div className="neon-card text-center">
            <h3 className="text-xl neon-text">TuProfePersonal</h3>
            <p className="text-white">
              Clases virtuales con ElProfeTino, adaptadas a tu nivel y estilo.
              Aprendé física con simulaciones interactivas o profundizá en
              historia con relatos dinámicos. ¡Perfecto para clases
              personalizadas!
            </p>
            <Link href="/tuprofeersonal" className="neon-button mt-2 block">Probar TPP</Link>
          </div>
          <div className="neon-card text-center">
            <h3 className="text-xl neon-text">GeneraTusEjercicios</h3>
            <p className="text-white">
              Creá prácticas personalizadas para cualquier materia de Ciclo Básico
              o Superior. Generá 10 ejercicios de química o 5 problemas de
              geometría en segundos. ¡Ideal para practicar antes de un examen!
            </p>
            <Link href="/generatusejercicios" className="neon-button mt-2 block">Probar GTE</Link>
          </div>
          <div className="neon-card text-center">
            <h3 className="text-xl neon-text">TuExamenPersonal</h3>
            <p className="text-white">
              Generá exámenes personalizados con correcciones y retroalimentación
              en 45 minutos. Practicá con un examen de biología o literatura y
              recibí consejos para mejorar. ¡Prepárate con confianza!
            </p>
            <Link href="/tuexampersonal" className="neon-button mt-2 block">Probar TEP</Link>
          </div>
          <div className="neon-card text-center">
            <h3 className="text-xl neon-text">Probar PEO</h3>
            <p className="text-white">
              Explorá TizaIA y otras herramientas sin registrarte. ¡Acceso
              gratuito por 24 horas!
            </p>
            <Link href="/prueba-peo" className="neon-button mt-2 block">Probar Ahora</Link>
          </div>
        </div>
      </main>

      <footer className="neon-card text-center p-4 mt-6">
        <p className="text-white">
          Seguinos en nuestras redes: <a href="#" className="neon-link">Instagram</a> |{" "}
          <a href="#" className="neon-link">WhatsApp</a>
          <br />
          Contacto:{" "}
          <a
            href="mailto:contacto@tuplataformaeducativa.online"
            className="neon-link"
          >
            contacto@tuplataformaeducativa.online
          </a>
          <br />
          <a href="/terminos" className="neon-link">
            Términos y Condiciones
          </a>{" "}
          |{" "}
          <a href="/privacidad" className="neon-link">
            Políticas de Privacidad
          </a>
          <br />
          © 2025 ProfePersonal. Todos los derechos reservados.
        </p>
      </footer>

      <style>{`
        .high-contrast body {
          background: #000 !important;
          background-image: none !important;
          color: #fff !important;
        }
        .high-contrast .neon-card {
          background: #333 !important;
          border-color: #fff !important;
          box-shadow: 0 0 10px #fff !important;
        }
        .high-contrast .neon-text {
          color: #fff !important;
          text-shadow: 0 0 5px #fff, 0 0 10px #fff !important;
        }
        .high-contrast .neon-button {
          background: #fff !important;
          color: #000 !important;
          text-shadow: none !important;
        }
        .high-contrast .neon-link {
          color: #fff !important;
        }
        .high-contrast .neon-link:hover {
          color: #000 !important;
        }
      `}</style>
    </div>
  );
}
EOL

# Step 5: Crear páginas placeholder y autenticación
echo "Creando páginas placeholder..."
mkdir -p app/{servicios,planes,sobre-nosotros,contacto,blog,revista-peo,herramientas,tienda,tizaia,tuprofeersonal,generatusejercicios,tuexampersonal,prueba-peo,auth,terminos,privacidad}
for page in servicios planes sobre-nosotros contacto blog revista-peo herramientas tienda tizaia tuprofeersonal generatusejercicios tuexampersonal prueba-peo terminos privacidad; do
  cat <<EOL > app/$page/page.tsx
export default function $page() {
  return <div>$page - En desarrollo</div>;
}
EOL
done

cat <<EOL > app/auth/signin/page.tsx
"use client";

import { signIn } from "next-auth/react";

export default function SignIn() {
  return (
    <div className="neon-card text-center p-6">
      <h2 className="text-2xl neon-text">Iniciar Sesión</h2>
      <button onClick={() => signIn("google")} className="neon-button mt-4">
        Ingresar con Google
      </button>
    </div>
  );
}
EOL

cat <<EOL > app/auth/register/page.tsx
"use client";

import { signIn } from "next-auth/react";

export default function Register() {
  return (
    <div className="neon-card text-center p-6">
      <h2 className="text-2xl neon-text">Registrarse</h2>
      <button onClick={() => signIn("google")} className="neon-button mt-4">
        Registrarse con Google
      </button>
    </div>
  );
}
EOL

# Step 6: Crear app/api/auth/[...nextauth]/route.ts
echo "Creando app/api/auth/[...nextauth]/route.ts..."
mkdir -p app/api/auth
cat <<EOL > app/api/auth/[...nextauth]/route.ts
import NextAuth from "next-auth";
import GoogleProvider from "next-auth/providers/google";
import { PrismaAdapter } from "@next-auth/prisma-adapter";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export const authOptions = {
  adapter: PrismaAdapter(prisma),
  providers: [
    GoogleProvider({
      clientId: "162719615056-8gs6bb8l8lcqvsiddp1v4gp1p5gauqs6.apps.googleusercontent.com",
      clientSecret: process.env.GOOGLE_CLIENT_SECRET,
    }),
  ],
  pages: {
    signIn: "/auth/signin",
    signOut: "/auth/signout",
    error: "/auth/error",
  },
  callbacks: {
    async session({ session, token, user }) {
      session.user.id = user.id;
      return session;
    },
  },
};

const handler = NextAuth(authOptions);
export { handler as GET, handler as POST };
EOL

# Step 7: Inicializar Prisma
echo "Inicializando Prisma..."
npx prisma init

# Step 8: Editar prisma/schema.prisma
echo "Actualizando prisma/schema.prisma..."
cat <<EOL > prisma/schema.prisma
generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

model User {
  id            String    @id @default(cuid())
  name          String?
  email         String?   @unique
  emailVerified DateTime?
  image         String?
  accounts      Account[]
  sessions      Session[]
}

model Account {
  id                String  @id @default(cuid())
  userId            String
  type               String
  provider          String
  providerAccountId String
  refresh_token     String? @db.Text
  access_token      String? @db.Text
  expires_at        Int?
  token_type        String?
  scope             String?
  id_token          String? @db.Text
  session_state     String?
  user              User    @relation(fields: [userId], references: [id], onDelete: Cascade)

  @@unique([provider, providerAccountId])
}

model Session {
  id           String   @id @default(cuid())
  sessionToken String   @unique
  userId       String
  expires      DateTime
  user         User     @relation(fields: [userId], references: [id], onDelete: Cascade)
}
EOL

# Step 9: Instalar dependencias
echo "Instalando dependencias..."
npm install next-auth @next-auth/prisma-adapter prisma

# Step 10: Instalar shadcn/ui components
echo "Instalando shadcn/ui Button y Input components..."
npx shadcn@latest add button input card

# Step 11: Limpiar caché de Next.js
echo "Limpiando caché de Next.js..."
rm -rf .next

# Step 12: Reiniciar servidor
echo "Configuración completa. Por favor, reinicia el servidor y agrega GOOGLE_CLIENT_SECRET en .env.local:"
echo "npm run dev"
