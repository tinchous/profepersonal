#!/bin/bash

# Script para aplicar estilo galaxia a PEO v.3

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
    background: #121212 url('/galaxias.jpg') no-repeat center/cover;
  }
}

@layer components {
  .neon-text {
    @apply text-[#0ff] shadow-[0_0_5px_#0ff,_0_0_10px_#0ff];
  }
  .neon-link {
    @apply text-[#0ff] no-underline transition-colors duration-300 hover:text-[#f0f];
  }
  .neon-button {
    @apply bg-[#0ff] text-[#121212] border-none px-4 py-2 cursor-pointer shadow-[0_0_5px_#0ff] hover:bg-[#f0f];
  }
  .neon-card {
    @apply bg-[#1a1a1a] p-4 rounded-lg shadow-[0_0_10px_#0ff];
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

export default function Home() {
  return (
    <div className="min-h-screen flex flex-col">
      <header className="neon-card text-center">
        <Image
          src="/logo.png"
          alt="Tu Plataforma Educativa Online Logo"
          width={150}
          height={50}
          className="mx-auto object-contain"
        />
        <h1 className="text-3xl neon-text mt-2">Tu Plataforma Educativa Online</h1>
        <nav className="page-controls mt-4">
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
        <div className="page-controls mt-2">
          <button className="neon-button">Ingresar/Registrarse</button>
          <button className="neon-button" onClick={() => document.body.classList.toggle('high-contrast')}>
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
              Resuelve dudas de cualquier materia de 7mo a 12do con explicaciones claras. Por ejemplo, preguntá cómo resolver una ecuación cuadrática y TizaIA te guiará paso a paso con ejemplos prácticos. ¡Ideal para aprender a tu ritmo!
            </p>
            <button className="neon-button mt-2">Probar TIZ</button>
          </div>
          <div className="neon-card text-center">
            <h3 className="text-xl neon-text">TuProfePersonal</h3>
            <p className="text-white">
              Clases virtuales con ElProfeTino, adaptadas a tu nivel y estilo. Aprendé física con simulaciones interactivas o profundizá en historia con relatos dinámicos. ¡Perfecto para clases personalizadas!
            </p>
            <button className="neon-button mt-2">Probar TPP</button>
          </div>
          <div className="neon-card text-center">
            <h3 className="text-xl neon-text">GeneraTusEjercicios</h3>
            <p className="text-white">
              Creá prácticas personalizadas para cualquier materia de Ciclo Básico o Superior. Generá 10 ejercicios de química o 5 problemas de geometría en segundos. ¡Ideal para practicar antes de un examen!
            </p>
            <button className="neon-button mt-2">Probar GTE</button>
          </div>
          <div className="neon-card text-center">
            <h3 className="text-xl neon-text">TuExamenPersonal</h3>
            <p className="text-white">
              Generá exámenes personalizados con correcciones y retroalimentación en 45 minutos. Practicá con un examen de biología o literatura y recibí consejos para mejorar. ¡Prepárate con confianza!
            </p>
            <button className="neon-button mt-2">Probar TEP</button>
          </div>
          <div className="neon-card text-center">
            <h3 className="text-xl neon-text">Probar PEO</h3>
            <p className="text-white">
              Explorá TizaIA y otras herramientas sin registrarte. ¡Acceso gratuito por 24 horas!
            </p>
            <button className="neon-button mt-2">Probar Ahora</button>
          </div>
        </div>
      </main>

      <footer className="neon-card text-center p-4 mt-6">
        <p className="text-white">
          Seguinos en nuestras redes: <a href="#" className="neon-link">Instagram</a> | <a href="#" className="neon-link">WhatsApp</a>
          <br />
          Contacto: <a href="mailto:contacto@tuplataformaeducativa.online" className="neon-link">contacto@tuplataformaeducativa.online</a>
          <br />
          <a href="/terminos" className="neon-link">Términos y Condiciones</a> | <a href="/privacidad" className="neon-link">Políticas de Privacidad</a>
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

# Step 5: Crear páginas placeholder
echo "Creando páginas placeholder..."
mkdir -p app/{servicios,planes,sobre-nosotros,contacto,blog,revista-peo,herramientas,tienda,terminos,privacidad}
for page in servicios planes sobre-nosotros contacto blog revista-peo herramientas tienda terminos privacidad; do
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
npx shadcn@latest add button input card

# Step 8: Limpiar caché de Next.js
echo "Limpiando caché de Next.js..."
rm -rf .next

# Step 9: Reiniciar servidor
echo "Configuración completa. Por favor, reinicia el servidor:"
echo "npm run dev"
