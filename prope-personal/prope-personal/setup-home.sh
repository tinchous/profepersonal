#!/bin/bash

# Script para configurar la página inicial de PEO v.3

# Crear app/page.tsx
echo "Creando app/page.tsx..."
mkdir -p app
echo "import Link from 'next/link';
import { getServerSession } from 'next-auth/next';
import { authOptions } from '@/lib/auth';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import Image from 'next/image';

export default async function HomePage() {
  const session = await getServerSession(authOptions);

  return (
    <div className=\"min-h-screen bg-gray-900 text-white flex flex-col\">
      <header className=\"container mx-auto p-4 flex justify-between items-center\">
        <div className=\"flex items-center space-x-4\">
          <Image src=\"/logo.png\" alt=\"Logo de ProfePersonal\" width={50} height={50} priority />
          <h1 className=\"text-2xl font-bold\" tabIndex={0}>ProfePersonal</h1>
        </div>
        <nav aria-label=\"Navegación principal\">
          {session ? (
            <Button asChild className=\"bg-gray-600 hover:bg-gray-700\" aria-label=\"Cerrar sesión\">
              <Link href=\"/auth/signout\">Cerrar Sesión</Link>
            </Button>
          ) : (
            <div className=\"space-x-2\">
              <Button asChild variant=\"link\" className=\"mr-2\" aria-label=\"Iniciar sesión\">
                <Link href=\"/auth/signin\">Iniciar Sesión</Link>
              </Button>
              <Button asChild className=\"bg-blue-600 hover:bg-blue-700\">
                <Link href=\"/auth/register\">Registrarse</Link>
              </Button>
            </div>
          )}
        </nav>
      </header>

      <main className=\"container mx-auto p-8 text-center\">
        <h2 className=\"text-3xl font-bold mb-6\" tabIndex={0}>Herramientas educativas para estudiantes de 7mo a 12do</h2>
        <p className=\"text-lg mb-8\" aria-label=\"Descripción de herramientas\">Accede a tus herramientas según tu plan:</p>

        <div className=\"grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4\">
          {[
            { icon: \"📚\", name: \"TizaIA\", desc: \"Asistente educativo para resolver dudas\", plan: \"Todos los planes\" },
            { icon: \"🔢\", name: \"GeneraTusEjercicios\", desc: \"Crea ejercicios personalizados\", plan: \"Plan Repaso+\" },
            { icon: \"📝\", name: \"TuExamPersonal\", desc: \"Genera y resuelve exámenes\", plan: \"Plan Apoyo+\" },
            { icon: \"🎓\", name: \"TuProfePersonal\", desc: \"Clases virtuales interactivas\", plan: \"Plan Premium\" },
          ].map((tool) => (
            <Card key={tool.name} className=\"bg-gray-800 border-none\" role=\"region\" aria-label={\`Herramienta \${tool.name}\`}>
              <CardHeader>
                <CardTitle className=\"text-xl flex items-center gap-2\">
                  <span>{tool.icon}</span> {tool.name}
                </CardTitle>
              </CardHeader>
              <CardContent>
                <p>{tool.desc}</p>
                <p className=\"text-sm text-gray-400 mt-2\">{tool.plan}</p>
              </CardContent>
            </Card>
          ))}
        </div>
      </main>

      <footer className=\"container mx-auto p-4 text-center\">
        <p>© 2025 ProfePersonal - Plataforma educativa</p>
        <p className=\"text-sm\">Conforme a los programas de ANEP</p>
      </footer>
    </div>
  );
}" > app/page.tsx

# Crear app/layout.tsx
echo "Creando app/layout.tsx..."
echo "import './globals.css';
import type { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'ProfePersonal',
  description: 'Plataforma educativa para estudiantes de 7mo a 12do',
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang=\"es\">
      <body className=\"bg-gray-900 text-white\">{children}</body>
    </html>
  );
}" > app/layout.tsx

# Crear lib/auth.ts
echo "Creando lib/auth.ts..."
mkdir -p lib
echo "import NextAuth from 'next-auth';
import CredentialsProvider from 'next-auth/providers/credentials';
import bcrypt from 'bcrypt';
import prisma from '@/lib/db';

export const authOptions = {
  providers: [
    CredentialsProvider({
      name: 'Credentials',
      credentials: {
        username: { label: 'Usuario', type: 'text' },
        password: { label: 'Contraseña', type: 'password' },
      },
      async authorize(credentials) {
        if (!credentials?.username || !credentials?.password) return null;
        const user = await prisma.user.findUnique({
          where: { username: credentials.username },
        });
        if (user && bcrypt.compareSync(credentials.password, user.password)) {
          return { id: user.id, name: user.username, email: user.email };
        }
        return null;
      },
    }),
  ],
  pages: {
    signIn: '/auth/signin',
    signOut: '/auth/signout',
  },
};

export default NextAuth(authOptions);" > lib/auth.ts

# Crear app/api/auth/[...nextauth]/route.ts
echo "Creando app/api/auth/[...nextauth]/route.ts..."
mkdir -p app/api/auth/[...nextauth]
echo "import NextAuth from 'next-auth';
import { authOptions } from '@/lib/auth';

const handler = NextAuth(authOptions);
export { handler as GET, handler as POST };" > app/api/auth/[...nextauth]/route.ts

# Crear app/auth/signin/page.tsx
echo "Creando app/auth/signin/page.tsx..."
mkdir -p app/auth/signin
echo "import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { signIn } from 'next-auth/react';
import Link from 'next/link';

export default function SignInPage() {
  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    const formData = new FormData(e.currentTarget);
    await signIn('credentials', {
      username: formData.get('username'),
      password: formData.get('password'),
      redirect: true,
      callbackUrl: '/',
    });
  };

  return (
    <div className=\"min-h-screen flex items-center justify-center bg-gray-900\">
      <form onSubmit={handleSubmit} className=\"bg-gray-800 p-6 rounded shadow-md space-y-4\" aria-label=\"Formulario de inicio de sesión\">
        <h2 className=\"text-2xl font-bold text-center\">Iniciar Sesión</h2>
        <div>
          <label htmlFor=\"username\" className=\"block text-sm\">Usuario</label>
          <Input id=\"username\" name=\"username\" type=\"text\" required className=\"bg-gray-700 text-white\" aria-required=\"true\" />
        </div>
        <div>
          <label htmlFor=\"password\" className=\"block text-sm\">Contraseña</label>
          <Input id=\"password\" name=\"password\" type=\"password\" required className=\"bg-gray-700 text-white\" aria-required=\"true\" />
        </div>
        <Button type=\"submit\" className=\"w-full bg-blue-600 hover:bg-blue-700\">Iniciar Sesión</Button>
        <p className=\"text-center text-sm\">
          ¿No tienes cuenta? <Link href=\"/auth/register\" className=\"text-blue-400\">Registrarse</Link>
        </p>
      </form>
    </div>
  );
}" > app/auth/signin/page.tsx

# Crear app/auth/register/page.tsx
echo "Creando app/auth/register/page.tsx..."
mkdir -p app/auth/register
echo "import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import prisma from '@/lib/db';
import bcrypt from 'bcrypt';
import { redirect } from 'next/navigation';
import Link from 'next/link';

export default function RegisterPage() {
  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    const formData = new FormData(e.currentTarget);
    const username = formData.get('username') as string;
    const email = formData.get('email') as string;
    const password = formData.get('password') as string;

    const hashedPassword = bcrypt.hashSync(password, 10);
    await prisma.user.create({
      data: {
        username,
        email,
        password: hashedPassword,
        role: 'student',
      },
    });

    redirect('/auth/signin');
  };

  return (
    <div className=\"min-h-screen flex items-center justify-center bg-gray-900\">
      <form onSubmit={handleSubmit} className=\"bg-gray-800 p-6 rounded shadow-md space-y-4\" aria-label=\"Formulario de registro\">
        <h2 className=\"text-2xl font-bold text-center\">Registrarse</h2>
        <div>
          <label htmlFor=\"username\" className=\"block text-sm\">Usuario</label>
          <Input id=\"username\" name=\"username\" type=\"text\" required className=\"bg-gray-700 text-white\" aria-required=\"true\" />
        </div>
        <div>
          <label htmlFor=\"email\" className=\"block text-sm\">Correo Electrónico</label>
          <Input id=\"email\" name=\"email\" type=\"email\" required className=\"bg-gray-700 text-white\" aria-required=\"true\" />
        </div>
        <div>
          <label htmlFor=\"password\" className=\"block text-sm\">Contraseña</label>
          <Input id=\"password\" name=\"password\" type=\"password\" required className=\"bg-gray-700 text-white\" aria-required=\"true\" />
        </div>
        <Button type=\"submit\" className=\"w-full bg-blue-600 hover:bg-blue-700\">Registrarse</Button>
        <p className=\"text-center text-sm\">
          ¿Ya tienes cuenta? <Link href=\"/auth/signin\" className=\"text-blue-400\">Iniciar Sesión</Link>
        </p>
      </form>
    </div>
  );
}" > app/auth/register/page.tsx

# Recordatorios
echo "Configuración completada. Siguientes pasos:"
echo "- Asegúrate de tener logo.png en public/."
echo "- Configura .env con DATABASE_URL para Neon PostgreSQL."
echo "- Ejecuta 'npx prisma migrate dev --name init' para aplicar el esquema."
echo "- Instala dependencias: npm install next-auth bcrypt @types/bcrypt."
echo "- Configura shadcn/ui: npx shadcn-ui@latest init."
