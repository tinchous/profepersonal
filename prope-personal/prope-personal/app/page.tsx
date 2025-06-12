"use client";

import Link from "next/link";
import Image from "next/image";
import { useSession, signIn, signOut } from "next-auth/react";
import { useState, useEffect } from "react";
import SessionWrapper from "./components/SessionWrapper";

export default function Home() {
  const { data: session } = useSession();
  const [isHighContrast, setIsHighContrast] = useState(false);
  const [activeSection, setActiveSection] = useState("servicios");

  useEffect(() => {
    const savedContrast = localStorage.getItem('highContrast') === 'true';
    if (savedContrast) {
      setIsHighContrast(true);
      document.body.classList.add('high-contrast');
    }

    const showInitialSection = () => {
      setActiveSection("servicios");
      const hash = window.location.hash.toLowerCase();
      if (hash === '#register') {
        // Modal de registro (a implementar)
      }
      const urlParams = new URLSearchParams(window.location.search);
      if (urlParams.get('verified') === 'true') alert('¡Cuenta verificada! Ahora podés iniciar sesión y disfrutar de PEO.');
    };

    showInitialSection();

    const handleHashChange = () => {
      const hash = window.location.hash.toLowerCase();
      if (hash === '#register') {
        // Modal de registro (a implementar)
      }
    };

    window.addEventListener('hashchange', handleHashChange);

    return () => window.removeEventListener('hashchange', handleHashChange);
  }, []);

  const toggleHighContrast = () => {
    setIsHighContrast(!isHighContrast);
    document.body.classList.toggle('high-contrast');
    localStorage.setItem('highContrast', !isHighContrast);
  };

  const showSection = (sectionId: string) => {
    setActiveSection(sectionId);
    setTimeout(() => {
      document.querySelector(`#${sectionId}`)?.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }, 100);
    document.querySelectorAll('nav a').forEach((link) => link.classList.remove('active'));
    document.querySelector(`nav a[href="#${sectionId}"]`)?.classList.add('active');
  };

  return (
    <div className="min-h-screen flex flex-col bg-gray-900 text-white font-sans">
      <header className="fixed top-0 w-full bg-gradient-to-r from-gray-800 to-gray-900 shadow-lg z-50 p-4 flex justify-between items-center">
        <h1 className="text-2xl font-bold text-teal-400">Tu Plataforma Educativa Online</h1>
        <div className="flex gap-4 items-center">
          {!session ? (
            <button onClick={() => signIn()} className="bg-teal-500 hover:bg-teal-600 text-white font-semibold py-2 px-4 rounded-lg transition duration-300" aria-label="Ingresar o registrarse">
              Ingresar/Registrarse
            </button>
          ) : (
            <button onClick={() => signOut()} className="bg-red-500 hover:bg-red-600 text-white font-semibold py-2 px-4 rounded-lg transition duration-300" aria-label="Salir">
              Salir
            </button>
          )}
          <button
            onClick={toggleHighContrast}
            onKeyDown={(e) => { if (e.key === 'Enter' || e.key === ' ') toggleHighContrast(); }}
            className="bg-purple-500 hover:bg-purple-600 text-white font-semibold py-2 px-4 rounded-lg transition duration-300"
            aria-label={isHighContrast ? 'Desactivar Modo Alto Contraste' : 'Activar Modo Alto Contraste'}
          >
            {isHighContrast ? 'Desactivar' : 'Modo'} Alto Contraste
          </button>
        </div>
      </header>

      <nav className="fixed top-16 w-full bg-gray-800 shadow-md z-40 p-2">
        <ul className="flex justify-center gap-6">
          <li><Link href="#servicios" className="text-teal-400 hover:text-teal-300 transition duration-300" onClick={() => showSection('servicios')}>Servicios</Link></li>
          <li><Link href="#planes" className="text-teal-400 hover:text-teal-300 transition duration-300" onClick={() => showSection('planes')}>Planes</Link></li>
          <li><Link href="/blog" className="text-teal-400 hover:text-teal-300 transition duration-300">Blog</Link></li>
          <li><Link href="/revista-peo" className="text-teal-400 hover:text-teal-300 transition duration-300">Revista PEO</Link></li>
          <li><Link href="/herramientas" className="text-teal-400 hover:text-teal-300 transition duration-300">Herramientas</Link></li>
          <li><Link href="/laboratorios" className="text-teal-400 hover:text-teal-300 transition duration-300">Laboratorios</Link></li>
          <li><Link href="/tienda" className="text-teal-400 hover:text-teal-300 transition duration-300">Tienda</Link></li>
          <li><Link href="#sobre-nosotros" className="text-teal-400 hover:text-teal-300 transition duration-300" onClick={() => showSection('sobre-nosotros')}>Sobre Nosotros</Link></li>
          <li><Link href="#contacto" className="text-teal-400 hover:text-teal-300 transition duration-300" onClick={() => showSection('contacto')}>Contacto</Link></li>
        </ul>
      </nav>

      <main className="container mx-auto pt-24 pb-8 flex-grow">
        <section id="servicios" className={activeSection === "servicios" ? "block" : "hidden"}>
          <div className="bg-teal-500 text-white text-center py-3 px-4 rounded-lg mb-6">
            ¡Registrate en Mayo 2025 y obtené el Plan Premium gratis por todo el mes!
          </div>
          <h2 className="text-3xl font-bold text-center text-teal-400 mb-6">Servicios</h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            <div className="bg-gray-800 p-6 rounded-lg shadow-lg hover:shadow-xl transition duration-300">
              <h3 className="text-xl font-semibold text-teal-400 mb-2">TizaIA</h3>
              <p className="text-gray-300 mb-4">Resolvé dudas de 7mo a 12do con explicaciones claras.</p>
              <Link href="/tizaia" className="bg-teal-500 hover:bg-teal-600 text-white font-semibold py-2 px-4 rounded-lg inline-block transition duration-300">Probar TIZ</Link>
            </div>
            <div className="bg-gray-800 p-6 rounded-lg shadow-lg hover:shadow-xl transition duration-300">
              <h3 className="text-xl font-semibold text-teal-400 mb-2">TuProfePersonal</h3>
              <p className="text-gray-300 mb-4">Clases virtuales adaptadas a tu nivel.</p>
              <Link href="/tuprofeersonal" className="bg-teal-500 hover:bg-teal-600 text-white font-semibold py-2 px-4 rounded-lg inline-block transition duration-300">Probar TPP</Link>
            </div>
            <div className="bg-gray-800 p-6 rounded-lg shadow-lg hover:shadow-xl transition duration-300">
              <h3 className="text-xl font-semibold text-teal-400 mb-2">GeneraTusEjercicios</h3>
              <p className="text-gray-300 mb-4">Creá prácticas personalizadas.</p>
              <Link href="/generatusejercicios" className="bg-teal-500 hover:bg-teal-600 text-white font-semibold py-2 px-4 rounded-lg inline-block transition duration-300">Probar GTE</Link>
            </div>
            <div className="bg-gray-800 p-6 rounded-lg shadow-lg hover:shadow-xl transition duration-300">
              <h3 className="text-xl font-semibold text-teal-400 mb-2">TuExamenPersonal</h3>
              <p className="text-gray-300 mb-4">Exámenes con retroalimentación.</p>
              <Link href="/tuexampersonal" className="bg-teal-500 hover:bg-teal-600 text-white font-semibold py-2 px-4 rounded-lg inline-block transition duration-300">Probar TEP</Link>
            </div>
            <div className="bg-gray-800 p-6 rounded-lg shadow-lg hover:shadow-xl transition duration-300">
              <h3 className="text-xl font-semibold text-teal-400 mb-2">Probar PEO</h3>
              <p className="text-gray-300 mb-4">Explorá gratis por 24 horas.</p>
              <button onClick={tryPEO} className="bg-teal-500 hover:bg-teal-600 text-white font-semibold py-2 px-4 rounded-lg inline-block transition duration-300">Probar Ahora</button>
            </div>
          </div>
        </section>

        <section id="planes" className={activeSection === "planes" ? "block" : "hidden"}> 
          <h2 className="text-3xl font-bold text-center text-teal-400 mb-6">Planes</h2>
          <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
            <div className="bg-gray-800 p-6 rounded-lg shadow-lg hover:shadow-xl transition duration-300">
              <h3 className="text-xl font-semibold text-teal-400 mb-2">Plan DUDAS</h3>
              <p className="text-2xl font-bold mb-2">GRATIS</p>
              <p className="text-gray-300 mb-4">Consultas limitadas a TIZ y GTE.</p>
              <button className="bg-teal-500 hover:bg-teal-600 text-white font-semibold py-2 px-4 rounded-lg w-full transition duration-300" onClick={() => subscribePlan('DUDAS')}>Suscribirme</button>
            </div>
            <div className="bg-gray-800 p-6 rounded-lg shadow-lg hover:shadow-xl transition duration-300">
              <h3 className="text-xl font-semibold text-teal-400 mb-2">Plan REPASO</h3>
              <p className="text-2xl font-bold mb-2">$200 UYU</p>
              <p className="text-gray-300 mb-4">TIZ y 10 GTE.</p>
              <button className="bg-teal-500 hover:bg-teal-600 text-white font-semibold py-2 px-4 rounded-lg w-full transition duration-300" onClick={() => subscribePlan('REPASO')}>Suscribirme</button>
            </div>
            <div className="bg-gray-800 p-6 rounded-lg shadow-lg hover:shadow-xl transition duration-300">
              <h3 className="text-xl font-semibold text-teal-400 mb-2">Plan APOYO</h3>
              <p className="text-2xl font-bold mb-2">$400 UYU</p>
              <p className="text-gray-300 mb-4">Todo + 10 TEP.</p>
              <button className="bg-teal-500 hover:bg-teal-600 text-white font-semibold py-2 px-4 rounded-lg w-full transition duration-300" onClick={() => subscribePlan('APOYO')}>Suscribirme</button>
            </div>
            <div className="bg-gray-800 p-6 rounded-lg shadow-lg hover:shadow-xl transition duration-300">
              <h3 className="text-xl font-semibold text-teal-400 mb-2">Plan PREMIUM</h3>
              <p className="text-2xl font-bold mb-2">$600 UYU</p>
              <p className="text-gray-300 mb-4">Acceso ilimitado.</p>
              <button className="bg-teal-500 hover:bg-teal-600 text-white font-semibold py-2 px-4 rounded-lg w-full transition duration-300" onClick={() => subscribePlan('PREMIUM')}>Suscribirme</button>
            </div>
          </div>
        </section>

        <section id="sobre-nosotros" className={activeSection === "sobre-nosotros" ? "block" : "hidden"}> 
          <h2 className="text-3xl font-bold text-center text-teal-400 mb-6">Sobre Nosotros</h2>
          <p className="text-gray-300 text-center max-w-2xl mx-auto mb-6">Somos ProfePersonal, un equipo apasionado por transformar la educación en Uruguay con herramientas innovadoras para estudiantes de 7mo a 12do grado.</p>
        </section>

        <section id="contacto" className={activeSection === "contacto" ? "block" : "hidden"}> 
          <h2 className="text-3xl font-bold text-center text-teal-400 mb-6">Contacto</h2>
          <form className="max-w-md mx-auto bg-gray-800 p-6 rounded-lg shadow-lg flex flex-col gap-4">
            <input type="text" id="nombre" placeholder="Nombre" required aria-label="Nombre" className="p-2 bg-gray-700 text-white rounded-lg border border-gray-600" />
            <input type="text" id="apellido" placeholder="Apellido" required aria-label="Apellido" className="p-2 bg-gray-700 text-white rounded-lg border border-gray-600" />
            <input type="email" id="email" placeholder="Email" required aria-label="Correo electrónico" className="p-2 bg-gray-700 text-white rounded-lg border border-gray-600" />
            <textarea id="mensaje" placeholder="Mensaje" required aria-label="Mensaje" className="p-2 bg-gray-700 text-white rounded-lg border border-gray-600 h-24"></textarea>
            <button type="button" id="sendEmailButton" aria-label="Enviar mensaje" className="bg-teal-500 hover:bg-teal-600 text-white font-semibold py-2 px-4 rounded-lg transition duration-300">Enviar Mensaje</button>
          </form>
          <div className="thank-you hidden text-center mt-4 text-green-400" id="thankYou">
            <p>¡Gracias por tu mensaje! Te contactaremos pronto.</p>
          </div>
        </section>
      </main>

      <footer className="bg-gray-800 text-center p-4 mt-auto">
        <p className="text-gray-400">© 2025 ProfePersonal. Todos los derechos reservados.</p>
      </footer>

      <style>{`
        .hidden { display: none; }
        .active { display: block; }
        @media (max-width: 768px) {
          .neon-header { flex-direction: column; padding: 1rem; }
          nav { top: 6rem; }
          nav ul { flex-wrap: wrap; gap: 1rem; }
          main { margin-top: 8rem; }
          .grid { grid-template-columns: 1fr; }
          .neon-button { font-size: 0.9rem; padding: 0.5rem; }
        }
        @media (max-width: 480px) {
          .neon-header h1 { font-size: 1.5rem; }
          nav a { font-size: 0.9rem; }
        }
        .high-contrast {
          background: #fff !important;
          color: #000 !important;
        }
        .high-contrast input,
        .high-contrast textarea {
          background: #fff !important;
          color: #000 !important;
          border-color: #000 !important;
        }
        .high-contrast .bg-teal-500 { background: #000 !important; }
        .high-contrast .text-teal-400 { color: #000 !important; }
        .high-contrast .hover\:bg-teal-600:hover { background: #333 !important; }
      `}</style>
    </div>
  );

  async function tryPEO() {
    const tempEmail = `temp_${Date.now()}@tuplataformaeducativa.online`;
    const tempPassword = randomString(12);
    const tempUser = { email: tempEmail, password: tempPassword, curso: '7mo', plan: 'TRIAL' };
    try {
      const response = await fetch('/api/register', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(tempUser),
      });
      if (response.ok) window.location.href = '/tizaia';
      else alert('¡Ups! Error al probar PEO.');
    } catch (error) {
      alert('¡Ups! Error de conexión.');
    }
  }

  function randomString(length: number) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    let result = '';
    for (let i = 0; i < length; i++) result += chars.charAt(Math.floor(Math.random() * chars.length));
    return result;
  }

  async function subscribePlan(plan: string) {
    alert(`¡Gracias por tu interés en el ${plan}! Redirigiendo a pago.`);
    // Integrar MercadoPago/PayPal aquí
  }
}

