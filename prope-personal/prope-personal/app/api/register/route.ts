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
