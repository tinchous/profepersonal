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

export async function POST(req: Request) {
  const { email, password, curso, plan } = await req.json();
  if (req.url.includes("register")) {
    try {
      const existingUser = await prisma.user.findUnique({ where: { email } });
      if (existingUser) return new Response(JSON.stringify({ error: "Email ya registrado" }), { status: 400 });
      const hashedPassword = await bcrypt.hash(password, 10);
      const user = await prisma.user.create({
        data: { email, password: hashedPassword, curso, plan },
      });
      return new Response(JSON.stringify(user), { status: 201 });
    } catch (error) {
      return new Response(JSON.stringify({ error: "Error al registrar" }), { status: 500 });
    }
  } else if (req.url.includes("login")) {
    try {
      const user = await prisma.user.findUnique({ where: { email } });
      if (!user) return new Response(JSON.stringify({ error: "Usuario no encontrado" }), { status: 401 });
      const isValid = await bcrypt.compare(password, user.password);
      if (!isValid) return new Response(JSON.stringify({ error: "Contraseña incorrecta" }), { status: 401 });
      return new Response(JSON.stringify({ user }), { status: 200 });
    } catch (error) {
      return new Response(JSON.stringify({ error: "Error al iniciar sesión" }), { status: 500 });
    }
  }
  return new Response(JSON.stringify({ error: "Método no soportado" }), { status: 405 });
}

export { handler as GET, handler as POST };
