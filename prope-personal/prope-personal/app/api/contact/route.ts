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
