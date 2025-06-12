#!/bin/bash

# Script para configurar la conexión a Neon PostgreSQL en PEO v.3

# Paso 1: Configurar variables de entorno para desarrollo local
echo "Configurando variables de entorno en .env..."
if [ ! -f .env ]; then
  touch .env
fi
echo "DATABASE_URL=postgres://neondb_owner:npg_gMl58NRhbrXi@ep-calm-queen-ac7aftpu-pooler.sa-east-1.aws.neon.tech/neondb?connect_timeout=15&sslmode=require" >> .env

# Paso 2: Instalar dependencias necesarias
echo "Instalando dependencias..."
npm install bcrypt
npm install -D @types/bcrypt

# Paso 3: Inicializar y aplicar el esquema de Prisma
echo "Aplicando el esquema de Prisma a la base de datos..."
npx prisma migrate dev --name init

# Paso 4: Crear una ruta API de prueba para verificar la conexión a la base de datos
echo "Creando ruta API de prueba en app/api/test-db/route.ts..."
mkdir -p app/api/test-db
echo "import { NextResponse } from 'next/server';
import prisma from '@/lib/db';

export async function GET() {
  try {
    const users = await prisma.user.findMany();
    return NextResponse.json({ users });
  } catch (error) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
}" > app/api/test-db/route.ts

# Paso 5 (Opcional): Configurar autenticación con NextAuth.js y Prisma
echo "Para integrar autenticación con Prisma, actualiza tu configuración de NextAuth.js en app/api/auth/[...nextauth]/route.ts como se indica a continuación:"
echo "/* Ejemplo:
import prisma from '@/lib/db';
import bcrypt from 'bcrypt';
import NextAuth from 'next-auth';
import CredentialsProvider from 'next-auth/providers/credentials';

export const authOptions = {
  providers: [
    CredentialsProvider({
      name: 'Credentials',
      credentials: {
        username: { label: 'Username', type: 'text' },
        password: { label: 'Password', type: 'password' },
      },
      async authorize(credentials) {
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
};

const handler = NextAuth(authOptions);
export { handler as GET, handler as POST };
*/"

# Recordatorio para configurar variables de entorno en Vercel
echo "IMPORTANTE: Para el despliegue en Vercel, configura la variable de entorno DATABASE_URL en el dashboard de Vercel con el valor:"
echo "postgres://neondb_owner:npg_gMl58NRhbrXi@ep-calm-queen-ac7aftpu-pooler.sa-east-1.aws.neon.tech/neondb?connect_timeout=15&sslmode=require"

echo "Configuración completada. Ahora puedes probar la conexión a la base de datos visitando /api/test-db en tu aplicación local."
