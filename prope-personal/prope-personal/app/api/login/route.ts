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
