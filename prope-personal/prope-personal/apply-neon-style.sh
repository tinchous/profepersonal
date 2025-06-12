#!/bin/bash

# Script para aplicar estilo neon y actualizar menú en PEO v.3

# Step 1: Crear o actualizar tailwind.config.js
echo "Actualizando tailwind.config.js..."
cat <<EOL > tailwind.config.js
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./app/**/*.{js,ts,jsx,tsx}",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        'neon-lime': '#ccff00',
        'neon-cyan': '#00ffff',
        'neon-magenta': '#ff00ff',
        'neon-bg': '#1a0033',
        'neon-text': '#ffffff',
        'neon-border': '#00ccff',
      },
      boxShadow: {
        'neon': '0 0 10px #00ffff, 0 0 20px #ff00ff, 0 0 30px #ccff00',
        'neon-small': '0 0 5px #00ffff, 0 0 10px #ff00ff, 0 0 15px #ccff00',
      },
    },
  },
  plugins: [],
}
EOL

# Step 2: Crear o actualizar app/globals.css
echo "Actualizando app/globals.css..."
mkdir -p app
cat <<EOL > app/globals.css
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  :root {
    --neon-lime: #ccff00;
    --neon-cyan: #00ffff;
    --neon-magenta: #ff00ff;
    --neon-bg: #1a0033;
    --neon-text: #ffffff;
    --neon-border: #00ccff;
    --neon-shadow: 0 0 10px #00ffff, 0 0 20px #ff00ff, 0 0 30px #ccff00;
    --neon-shadow-small: 0 0 5px #00ffff, 0 0 10px #ff00ff, 0 0 15px #ccff00;
  }

  body {
    @apply font-sans bg-gradient-to-br from-[var(--neon-bg)] to-[#330066] text-[var(--neon-text)] min-h-screen p-5;
    font-family: 'Poppins', sans-serif;
  }
}

@layer components {
  .neon-border {
    @apply border-4 border-[var(--neon-border)] rounded-xl;
  }
  .neon-shadow {
    @apply shadow-[var(--neon-shadow)];
  }
  .neon-shadow-small {
    @apply shadow-[var(--neon-shadow-small)];
  }
  .neon-button {
    @apply bg-[var(--neon-lime)] text-black font-bold px-4 py-2 rounded-full border-none cursor-pointer transition-all duration-300 hover:bg-[#99cc00] hover:scale-105;
  }
  .neon-card {
    @apply bg-[rgba(0,0,0,0.3)] neon-border neon-shadow-small p-5 rounded-xl;
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
      <head>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&family=Orbitron:wght@400;700&display=swap" rel="stylesheet" />
      </head>
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

export default function Home() {
  return (
    <div className="min-h-screen flex flex-col">
      <header className="neon-border neon-shadow p-4 text-center relative">
        <Image
          src="/logo.png"
          alt="ProfePersonal Logo"
          width={150}
          height={50}
          className="mx-auto object-contain"
        />
        <nav className="mt-4">
          <ul className="flex justify-center gap-4 text-[var(--neon-cyan)]">
            <li><Link href="/">Inicio</Link></li>
            <li><Link href="/servicios">Servicios</Link></li>
            <li><Link href="/planes">Planes</Link></li>
            <li><Link href="/sobre-nosotros">Sobre Nosotros</Link></li>
            <li><Link href="/contacto">Contacto</Link></li>
            <li><Link href="/blog">Blog</Link></li>
            <li><Link href="/revista-peo">Revista PEO</Link></li>
            <li><Link href="/herramientas">Herramientas</Link></li>
            <li><Link href="/tienda">Tienda</Link></li>
          </ul>
        </nav>
        <div className="auth-buttons absolute top-4 right-4 flex gap-2">
          <button className="neon-button btn-login">Ingresar</button>
          <button className="neon-button btn-register">Registrarse</button>
          <button className="neon-button btn-logout" style={{ display: 'none' }}>Salir</button>
          <button className="neon-button btn-back" style={{ display: 'none' }}>Volver</button>
          <button className="neon-button" onClick={() => document.body.classList.toggle('high-contrast')}>
            Modo Alto Contraste
          </button>
        </div>
      </header>

      <main className="container neon-card mt-6">
        <section className="text-center mb-6">
          <h1 className="text-4xl font-orbitron text-[var(--neon-cyan)] neon-shadow">
            ¡Registrate en Mayo 2025 y obtené el Plan Premium gratis por todo el mes!
          </h1>
        </section>

        <section className="mb-6">
          <h2 className="text-2xl font-orbitron text-[var(--neon-cyan)] mb-4">Servicios</h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div className="neon-card">
              <h3 className="text-xl font-semibold text-[var(--neon-lime)]">TizaIA</h3>
              <p className="text-[var(--neon-text)]">
                Resolvé dudas de cualquier materia de 7mo a 12do con explicaciones claras. Por ejemplo, preguntá cómo resolver una ecuación cuadrática y TizaIA te guiará paso a paso con ejemplos prácticos. ¡Ideal para aprender a tu ritmo!
              </p>
              <Link href="/tizaia" className="neon-button mt-2 inline-block">Probar TIZ</Link>
            </div>
            <div className="neon-card">
              <h3 className="text-xl font-semibold text-[var(--neon-lime)]">TuProfePersonal</h3>
              <p className="text-[var(--neon-text)]">
                Clases virtuales con ElProfeTino, adaptadas a tu nivel y estilo. Aprendé física con simulaciones interactivas o profundizá en historia con relatos dinámicos. ¡Perfecto para clases personalizadas!
              </p>
              <Link href="/tuprofeersonal" className="neon-button mt-2 inline-block">Probar TPP</Link>
            </div>
            <div className="neon-card">
              <h3 className="text-xl font-semibold text-[var(--neon-lime)]">GeneraTusEjercicios</h3>
              <p className="text-[var(--neon-text)]">
                Creá prácticas personalizadas para cualquier materia de Ciclo Básico o Superior. Generá 10 ejercicios de química o 5 problemas de geometría en segundos. ¡Ideal para practicar antes de un examen!
              </p>
              <Link href="/generatusejercicios" className="neon-button mt-2 inline-block">Probar GTE</Link>
            </div>
            <div className="neon-card">
              <h3 className="text-xl font-semibold text-[var(--neon-lime)]">TuExamenPersonal</h3>
              <p className="text-[var(--neon-text)]">
                Generá exámenes personalizados con correcciones y retroalimentación en 45 minutos. Practicá con un examen de biología o literatura y recibí consejos para mejorar. ¡Prepárate con confianza!
              </p>
              <Link href="/tuexampersonal" className="neon-button mt-2 inline-block">Probar TEP</Link>
            </div>
            <div className="neon-card">
              <h3 className="text-xl font-semibold text-[var(--neon-lime)]">Probar PEO</h3>
              <p className="text-[var(--neon-text)]">
                Explorá TizaIA y otras herramientas sin registrarte. ¡Acceso gratuito por 24 horas!
              </p>
              <Link href="/prueba-peo" className="neon-button mt-2 inline-block">Probar Ahora</Link>
            </div>
          </div>
        </section>

        <section className="mb-6">
          <h2 className="text-2xl font-orbitron text-[var(--neon-cyan)] mb-4">Planes</h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div className="neon-card">
              <h3 className="text-xl font-semibold text-[var(--neon-lime)]">Plan DUDAS</h3>
              <p className="text-[var(--neon-text)]">GRATIS</p>
              <p className="text-[var(--neon-text)]">Consultas limitadas a TIZ y GTE. Perfecto para consultar y resolver tus dudas.</p>
              <Link href="/suscribir/dudas" className="neon-button mt-2 inline-block">Suscribirme</Link>
            </div>
            <div className="neon-card">
              <h3 className="text-xl font-semibold text-[var(--neon-lime)]">Plan REPASO</h3>
              <p className="text-[var(--neon-text)]">$200 UYU</p>
              <p className="text-[var(--neon-text)]">Acceso completo a TIZ, 10 accesos a GTE y 1 tutorías de TPP. Ideal para repasar antes de exámenes o parciales.</p>
              <Link href="/suscribir/repaso" className="neon-button mt-2 inline-block">Suscribirme</Link>
            </div>
            <div className="neon-card">
              <h3 className="text-xl font-semibold text-[var(--neon-lime)]">Plan APOYO</h3>
              <p className="text-[var(--neon-text)]">$400 UYU</p>
              <p className="text-[var(--neon-text)]">Todo lo anterior + 10 exámenes personalizados en TEP. Para estudiantes que buscan apoyo constante.</p>
              <Link href="/suscribir/apoyo" className="neon-button mt-2 inline-block">Suscribirme</Link>
            </div>
            <div className="neon-card">
              <h3 className="text-xl font-semibold text-[var(--neon-lime)]">Plan PREMIUM</h3>
              <p className="text-[var(--neon-text)]">$600 UYU</p>
              <p className="text-[var(--neon-text)]">Acceso ilimitado a TIZ, TPP, GTE y TEP. ¡La mejor opción para dominar todas tus materias!</p>
              <Link href="/suscribir/premium" className="neon-button mt-2 inline-block">Suscribirme</Link>
            </div>
          </div>
        </section>

        <section className="mb-6">
          <h2 className="text-2xl font-orbitron text-[var(--neon-cyan)] mb-4">Sobre Nosotros</h2>
          <p className="text-[var(--neon-text)]">
            Somos ProfePersonal, un equipo apasionado por transformar la educación en Uruguay. Nuestra misión es apoyar a estudiantes de 7mo a 12do grado con herramientas innovadoras alineadas con el Plan de Estudios 2023 de ANEP. Diseñamos nuestra plataforma para ser accesible, inclusiva y fácil de usar, especialmente para estudiantes con discapacidades.
          </p>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mt-4">
            <div className="neon-card">
              <h3 className="text-xl font-semibold text-[var(--neon-lime)]">TizaIA</h3>
              <p className="text-[var(--neon-text)]">Tu asistente educativo del futuro. Resuelve dudas con explicaciones claras.</p>
            </div>
            <div className="neon-card">
              <h3 className="text-xl font-semibold text-[var(--neon-lime)]">ProfeTino</h3>
              <p className="text-[var(--neon-text)]">El tutor virtual más copado. Te guía en clases personalizadas con paciencia y buena onda.</p>
            </div>
          </div>
        </section>

        <section>
          <h2 className="text-2xl font-orbitron text-[var(--neon-cyan)] mb-4">Contacto</h2>
          <form className="neon-card">
            <div className="form-group">
              <label htmlFor="name">Nombre</label>
              <input type="text" id="name" name="name" required />
            </div>
            <div className="form-group">
              <label htmlFor="email">Email</label>
              <input type="email" id="email" name="email" required />
            </div>
            <div className="form-group">
              <label htmlFor="message">Mensaje</label>
              <textarea id="message" name="message" rows={4} required></textarea>
            </div>
            <button type="submit" className="neon-button form-submit">Enviar Mensaje</button>
            <p className="text-[var(--neon-lime)] mt-2" style={{ display: 'none' }}>
              ¡Gracias por tu mensaje! Te hemos enviado un email de confirmación. Pronto te responderemos.
            </p>
          </form>
        </section>
      </main>

      <footer className="neon-border neon-shadow-small p-4 mt-6 text-center">
        <p className="text-[var(--neon-text)]">
          Seguinos en nuestras redes: <a href="#" className="text-[var(--neon-lime)]">Instagram</a> | <a href="#" className="text-[var(--neon-lime)]">WhatsApp</a>
          <br />
          Contacto: [email protected]
          <br />
          <Link href="/terminos" className="text-[var(--neon-lime)]">Términos y Condiciones</Link> | <Link href="/privacidad" className="text-[var(--neon-lime)]">Políticas de Privacidad</Link>
          <br />
          © 2025 ProfePersonal. Todos los derechos reservados.
        </p>
      </footer>

      <style>{`
        .high-contrast body {
          background: #000 !important;
          color: #fff !important;
        }
        .high-contrast .neon-card, .high-contrast .neon-border {
          border-color: #fff !important;
          background: #333 !important;
        }
        .high-contrast .neon-button {
          background: #fff !important;
          color: #000 !important;
        }
        .high-contrast .text-[var(--neon-cyan)] {
          color: #0ff !important;
        }
        .high-contrast .text-[var(--neon-lime)] {
          color: #ff0 !important;
        }
      `}</style>
    </div>
  );
}
EOL

# Step 5: Crear páginas placeholder
echo "Creando páginas placeholder..."
mkdir -p app/{servicios,planes,sobre-nosotros,contacto,blog,revista-peo,herramientas,tienda,tizaia,tuprofeersonal,generatusejercicios,tuexampersonal,prueba-peo,suscribir,terminos,privacidad}
for page in servicios planes sobre-nosotros contacto blog revista-peo herramientas tienda tizaia tuprofeersonal generatusejercicios tuexampersonal prueba-peo suscribrir/dudas suscribrir/repaso suscribrir/apoyo suscribrir/premium terminos privacidad; do
  cat <<EOL > app/$page/page.tsx
export default function $page() {
  return <div>$page - En desarrollo</div>;
}
EOL
done

# Step 6: Instalar dependencias
echo "Instalando dependencias..."
npm install next-auth bcrypt @types/bcrypt @prisma/client prisma

# Step 7: Instalar shadcn/ui components
echo "Instalando shadcn/ui Button y Input components..."
npx shadcn-ui@latest add button input

# Step 8: Limpiar caché de Next.js
echo "Limpiando caché de Next.js..."
rm -rf .next

# Step 9: Reiniciar servidor
echo "Configuración completa. Por favor, reinicia el servidor:"
echo "npm run dev"
