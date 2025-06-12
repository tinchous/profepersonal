#!/bin/bash

# Script para mejorar el diseño de la página principal de PEO v.3

# Step 1: Verificar o mover logo.png
echo "Verificando logo.png..."
if [ ! -f public/logo.png ]; then
  echo "Moviendo logo.png a public/ (ajusta la ruta si es necesario)"
  mv /ruta/a/logo.png public/logo.png 2>/dev/null || echo "Por favor, coloca logo.png en public/"
fi

# Step 2: Crear o actualizar app/page.tsx
echo "Actualizando app/page.tsx..."
mkdir -p app
cat <<EOL > app/page.tsx
import Link from "next/link";
import Image from "next/image";

export default function Home() {
  return (
    <div className="min-h-screen bg-gradient-to-b from-blue-100 to-blue-500 text-gray-800 flex flex-col items-center">
      <header className="w-full bg-blue-600 p-4 flex justify-center">
        <Image
          src="/logo.png"
          alt="ProfePersonal Logo"
          width={150}
          height={50}
          className="object-contain"
        />
      </header>

      <main className="max-w-4xl mx-auto p-6 text-center">
        <h1 className="text-4xl font-bold text-white mb-6 drop-shadow-lg">
          Herramientas Educativas para Estudiantes de 7mo a 12do
        </h1>
        <p className="text-lg text-gray-200 mb-8">
          Accede a tus herramientas según tu plan:
        </p>

        <section className="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">
          <div className="bg-white p-6 rounded-lg shadow-lg hover:shadow-xl transition-shadow">
            <h2 className="text-2xl font-semibold text-blue-600 mb-2">Plan Repaso</h2>
            <ul className="text-left text-gray-700 list-disc pl-5">
              <li>Asistente educativo para resolver dudas</li>
            </ul>
          </div>
          <div className="bg-white p-6 rounded-lg shadow-lg hover:shadow-xl transition-shadow">
            <h2 className="text-2xl font-semibold text-blue-600 mb-2">Plan Apoyo</h2>
            <ul className="text-left text-gray-700 list-disc pl-5">
              <li>Genera y resuelve exámenes</li>
            </ul>
          </div>
          <div className="bg-white p-6 rounded-lg shadow-lg hover:shadow-xl transition-shadow">
            <h2 className="text-2xl font-semibold text-blue-600 mb-2">Plan Premium</h2>
            <ul className="text-left text-gray-700 list-disc pl-5">
              <li>Clases virtuales interactivas</li>
            </ul>
          </div>
        </section>

        <section className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <Link href="/tizaia" className="bg-blue-700 text-white p-4 rounded-lg hover:bg-blue-800 transition-colors">
            <h3 className="text-xl font-semibold">TizaIA</h3>
            <p className="text-sm">Asistente educativo para resolver dudas</p>
          </Link>
          <Link href="/generatusejercicios" className="bg-blue-700 text-white p-4 rounded-lg hover:bg-blue-800 transition-colors">
            <h3 className="text-xl font-semibold">GeneraTusEjercicios</h3>
            <p className="text-sm">Crea ejercicios personalizados</p>
          </Link>
          <Link href="/tuexampersonal" className="bg-blue-700 text-white p-4 rounded-lg hover:bg-blue-800 transition-colors">
            <h3 className="text-xl font-semibold">TuExamPersonal</h3>
            <p className="text-sm">Genera y resuelve exámenes</p>
          </Link>
          <Link href="/tuprofeersonal" className="bg-blue-700 text-white p-4 rounded-lg hover:bg-blue-800 transition-colors">
            <h3 className="text-xl font-semibold">TuProfePersonal</h3>
            <p className="text-sm">Clases virtuales interactivas</p>
          </Link>
        </section>

        <footer className="mt-8 text-gray-400 text-sm">
          © 2025 ProfePersonal - Plataforma educativa
          <br />
          Confórmate los programas de ANEP
        </footer>
      </main>
    </div>
  );
}
EOL

# Step 3: Verificar app/globals.css
echo "Verificando app/globals.css..."
mkdir -p app
cat <<EOL > app/globals.css
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  body {
    @apply bg-gray-50 text-gray-800;
  }
}
EOL

# Step 4: Crear páginas placeholder
echo "Creando páginas placeholder..."
mkdir -p app/tizaia app/generatusejercicios app/tuexampersonal app/tuprofeersonal
for page in tizaia generatusejercicios tuexampersonal tuprofeersonal; do
  cat <<EOL > app/$page/page.tsx
export default function $page() {
  return <div>$page - En desarrollo</div>;
}
EOL
done

# Step 5: Instalar dependencias
echo "Instalando dependencias..."
npm install next-auth bcrypt @types/bcrypt @prisma/client prisma

# Step 6: Instalar shadcn/ui components
echo "Instalando shadcn/ui Button y Input components..."
npx shadcn-ui@latest add button input

# Step 7: Limpiar caché de Next.js
echo "Limpiando caché de Next.js..."
rm -rf .next

# Step 8: Reiniciar servidor
echo "Configuración completa. Por favor, reinicia el servidor:"
echo "npm run dev"
