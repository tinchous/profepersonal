#!/bin/bash

# Step 1: Ajustar app/layout.tsx
echo "Ajustando app/layout.tsx..."
cat <<EOL > app/layout.tsx
"use client";

import './globals.css'
import { SessionProvider } from "next-auth/react"

export const metadata = {
  title: 'Tu Plataforma Educativa Online',
  description: 'PEO: Tu plataforma educativa para 7mo a 12do grado, alineada con ANEP. ¡Gratis en Mayo 2025!',
  keywords: 'plataforma educativa Uruguay, ANEP, liceo, estudiar online, TizaIA, ElProfeTino',
  icons: [{ rel: 'icon', type: 'image/x-icon', url: '/favicon.ico' }],
  canonical: 'https://www.tuplataformaeducativa.online/prope',
}

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="es">
      <head>
        <meta charSet="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@700&family=Poppins:wght@400;500&display=swap" rel="stylesheet" />
      </head>
      <body>
        <SessionProvider>{children}</SessionProvider>
      </body>
    </html>
  )
}
EOL

# Step 2: Actualizar app/page.tsx
echo "Actualizando app/page.tsx..."
cat <<'EOL' > app/page.tsx
"use client";

import Link from "next/link";
import Image from "next/image";
import { useSession, signIn, signOut } from "next-auth/react";
import { useState, useEffect } from "react";

export default function Home() {
  const { data: session } = useSession();
  const [isHighContrast, setIsHighContrast] = useState(false);

  useEffect(() => {
    const savedContrast = localStorage.getItem('highContrast') === 'true';
    if (savedContrast) {
      setIsHighContrast(true);
      document.body.classList.add('high-contrast');
    }
  }, []);

  const toggleHighContrast = () => {
    setIsHighContrast(!isHighContrast);
    document.body.classList.toggle('high-contrast');
    localStorage.setItem('highContrast', !isHighContrast);
  };

  const showSection = (sectionId: string) => {
    document.querySelectorAll('section').forEach((section) => section.classList.remove('active'));
    document.querySelector('#' + sectionId)?.classList.add('active');
    setTimeout(() => document.querySelector('#' + sectionId)?.scrollIntoView({ behavior: 'smooth', block: 'start' }), 100);
    document.querySelectorAll('nav a').forEach((link) => link.classList.remove('active'));
    document.querySelector(`nav a[href="#${sectionId}"]`)?.classList.add('active');
  };

  const tryPEO = async () => {
    const tempEmail = `temp_${Date.now()}@tuplataformaeducativa.online`;
    const tempPassword = randomString(12);
    const tempUser = { email: tempEmail, password: tempPassword, curso: '7mo', plan: 'TRIAL' };
    try {
      const response = await fetch('/api/register', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify(tempUser) });
      if (response.ok) {
        const loginResponse = await fetch('/api/login', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ email: tempEmail, password: tempPassword }) });
        if (loginResponse.ok) window.location.href = '/tizaia';
        else alert('¡Ups! Error al probar PEO. Intentá de nuevo.');
      } else {
        const errorData = await response.json();
        alert(`¡Ups! Error al probar PEO: ${errorData.error}`);
      }
    } catch (error) {
      alert('¡Ups! Error de conexión. Intentá de nuevo.');
    }
  };

  const subscribePlan = (plan: string) => {
    alert(`¡Gracias por tu interés en el ${plan}! Serás redirigido al proceso de suscripción con MercadoPago/Paypal.`);
    // Implementar integración con MercadoPago/Paypal aquí
  };

  useEffect(() => {
    showSection('servicios');
    const hash = window.location.hash.toLowerCase();
    if (hash === '#register') {
      // Modal de registro (a implementar)
    }
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('verified') === 'true') alert('¡Cuenta verificada! Ahora podés iniciar sesión y disfrutar de PEO.');
  }, []);

  return (
    <div className="min-h-screen flex flex-col">
      <header className="neon-header">
        <h1 className="neon-text text-xl md:text-2xl font-orbitron">Tu Plataforma Educativa Online</h1>
        <div className="flex gap-2">
          {!session ? (
            <button onClick={() => signIn()} className="neon-button" aria-label="Ingresar o registrarse">
              Ingresar/Registrarse
            </button>
          ) : (
            <button onClick={() => signOut()} className="neon-button" aria-label="Salir">
              Salir
            </button>
          )}
          <button
            onClick={toggleHighContrast}
            onKeyDown={(e) => { if (e.key === 'Enter' || e.key === ' ') toggleHighContrast(); }}
            className="neon-button bg-[#ff00ff] border-2 border-[#00ccff]"
            aria-label={isHighContrast ? 'Desactivar Modo Alto Contraste' : 'Activar Modo Alto Contraste'}
          >
            {isHighContrast ? 'Desactivar' : 'Modo'} Alto Contraste
          </button>
        </div>
      </header>

      <nav className="fixed top-16 w-full bg-[rgba(0,0,0,0.7)] p-2 border-b-2 border-[#00ccff] shadow-[0_0_15px_#00ffff] z-40">
        <ul className="flex justify-center gap-4">
          <li><Link href="#servicios" className="neon-link font-orbitron" onClick={() => showSection('servicios')}>Servicios</Link></li>
          <li><Link href="#planes" className="neon-link font-orbitron" onClick={() => showSection('planes')}>Planes</Link></li>
          <li><Link href="#sobre-nosotros" className="neon-link font-orbitron" onClick={() => showSection('sobre-nosotros')}>Sobre Nosotros</Link></li>
          <li><Link href="#contacto" className="neon-link font-orbitron" onClick={() => showSection('contacto')}>Contacto</Link></li>
        </ul>
      </nav>

      <main className="container mx-auto pt-24 pb-4 flex-grow">
        <section id="servicios" className="active">
          <div className="banner">¡Registrate en Mayo 2025 y obtené el Plan Premium gratis por todo el mes!</div>
          <h2 className="neon-text text-2xl md:text-3xl font-orbitron mb-6 text-center">Servicios</h2>
          <div className="grid grid-cols-1 md:grid-cols-5 gap-4">
            <div className="neon-card text-center">
              <h3 className="neon-text text-lg font-orbitron">TizaIA</h3>
              <p className="text-white">Resolvé dudas de cualquier materia de 7mo a 12do con explicaciones claras. Por ejemplo, preguntá cómo resolver una ecuación cuadrática y TizaIA te guiará paso a paso con ejemplos prácticos. ¡Ideal para aprender a tu ritmo!</p>
              <Link href="/tizaia" className="neon-button mt-2 block" data-tooltip="Consultá ahora con TizaIA">Probar TIZ</Link>
            </div>
            <div className="neon-card text-center">
              <h3 className="neon-text text-lg font-orbitron">TuProfePersonal</h3>
              <p className="text-white">Clases virtuales con ElProfeTino, adaptadas a tu nivel y estilo. Aprendé física con simulaciones interactivas o profundizá en historia con relatos dinámicos. ¡Perfecto para clases personalizadas!</p>
              <Link href="/tuprofeersonal" className="neon-button mt-2 block" data-tooltip="Tomá una clase con ElProfeTino">Probar TPP</Link>
            </div>
            <div className="neon-card text-center">
              <h3 className="neon-text text-lg font-orbitron">GeneraTusEjercicios</h3>
              <p className="text-white">Creá prácticas personalizadas para cualquier materia de Ciclo Básico o Superior. Generá 10 ejercicios de química o 5 problemas de geometría en segundos. ¡Ideal para practicar antes de un examen!</p>
              <Link href="/generatusejercicios" className="neon-button mt-2 block" data-tooltip="Generá ejercicios a medida">Probar GTE</Link>
            </div>
            <div className="neon-card text-center">
              <h3 className="neon-text text-lg font-orbitron">TuExamenPersonal</h3>
              <p className="text-white">Generá exámenes personalizados con correcciones y retroalimentación en 45 minutos. Practicá con un examen de biología o literatura y recibí consejos para mejorar. ¡Prepárate con confianza!</p>
              <Link href="/tuexampersonal" className="neon-button mt-2 block" data-tooltip="Practicá con exámenes personalizados">Probar TEP</Link>
            </div>
            <div className="neon-card text-center">
              <h3 className="neon-text text-lg font-orbitron">Probar PEO</h3>
              <p className="text-white">Explorá TizaIA y otras herramientas sin registrarte. ¡Acceso gratuito por 24 horas!</p>
              <button onClick={tryPEO} className="neon-button mt-2 block" data-tooltip="Probar sin compromiso">Probar Ahora</button>
            </div>
          </div>
        </section>

        <section id="planes" className="hidden">
          <h2 className="neon-text text-2xl md:text-3xl font-orbitron mb-6 text-center">Planes</h2>
          <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
            <div className="neon-card text-center">
              <h3 className="neon-text text-lg font-orbitron">Plan DUDAS</h3>
              <h2 className="text-2xl">GRATIS</h2>
              <p className="text-white">Consultas limitadas a TIZ y GTE. Perfecto para consultar y resolver tus dudas.</p>
              <button className="neon-button mt-2" data-tooltip="Suscribite al Plan Dudas" onClick={() => subscribePlan('DUDAS')}>Suscribirme</button>
            </div>
            <div className="neon-card text-center">
              <h3 className="neon-text text-lg font-orbitron">Plan REPASO</h3>
              <h2 className="text-2xl">$200 UYU</h2>
              <p className="text-white">Acceso completo a TIZ, 10 accesos a GTE y 1 tutorías de TPP. Ideal para repasar antes de exámenes o parciales.</p>
              <button className="neon-button mt-2" data-tooltip="Suscribite al Plan Repaso" onClick={() => subscribePlan('REPASO')}>Suscribirme</button>
            </div>
            <div className="neon-card text-center">
              <h3 className="neon-text text-lg font-orbitron">Plan APOYO</h3>
              <h2 className="text-2xl">$400 UYU</h2>
              <p className="text-white">Todo lo anterior + 10 exámenes personalizados en TEP. Para estudiantes que buscan apoyo constante.</p>
              <button className="neon-button mt-2" data-tooltip="Suscribite al Plan Apoyo" onClick={() => subscribePlan('APOYO')}>Suscribirme</button>
            </div>
            <div className="neon-card text-center">
              <h3 className="neon-text text-lg font-orbitron">Plan PREMIUM</h3>
              <h2 className="text-2xl">$600 UYU</h2>
              <p className="text-white">Acceso ilimitado a TIZ, TPP, GTE y TEP. ¡La mejor opción para dominar todas tus materias!</p>
              <button className="neon-button mt-2" data-tooltip="Suscribite al Plan Premium" onClick={() => subscribePlan('PREMIUM')}>Suscribirme</button>
            </div>
          </div>
        </section>

        <section id="sobre-nosotros" className="hidden">
          <h2 className="neon-text text-2xl md:text-3xl font-orbitron mb-6 text-center">Sobre Nosotros</h2>
          <p className="text-white mb-4">Somos ProfePersonal, un equipo apasionado por transformar la educación en Uruguay. Nuestra misión es apoyar a estudiantes de 7mo a 12do grado con herramientas innovadoras alineadas con el Plan de Estudios 2023 de ANEP. Diseñamos nuestra plataforma para ser accesible, inclusiva y fácil de usar, especialmente para estudiantes con discapacidades.</p>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div className="neon-card text-center">
              <Image src="https://via.placeholder.com/100?text=TizaIA" alt="Avatar de TizaIA" width={100} height={100} className="mx-auto rounded-full border-2 border-[#00ccff] shadow-[0_0_15px_#00ffff]" />
              <h3 className="neon-text text-lg font-orbitron">TizaIA</h3>
              <p className="text-white">Tu asistente educativo del futuro. Resuelve dudas con explicaciones claras.</p>
            </div>
            <div className="neon-card text-center">
              <Image src="https://via.placeholder.com/100?text=ElProfeTino" alt="Avatar de ElProfeTino" width={100} height={100} className="mx-auto rounded-full border-2 border-[#00ccff] shadow-[0_0_15px_#00ffff]" />
              <h3 className="neon-text text-lg font-orbitron">ProfeTino</h3>
              <p className="text-white">El tutor virtual más copado. Te guía en clases personalizadas con paciencia y buena onda.</p>
            </div>
          </div>
        </section>

        <section id="contacto" className="hidden">
          <h2 className="neon-text text-2xl md:text-3xl font-orbitron mb-6 text-center">Contacto</h2>
          <form className="contact-form" id="contactForm">
            <input type="text" id="nombre" placeholder="Nombre" required aria-label="Nombre" className="w-full p-2 mb-2 border-2 border-[#00ccff] bg-[#1a1a1a] rounded" />
            <input type="text" id="apellido" placeholder="Apellido" required aria-label="Apellido"
