"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";

export default function SignIn() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const router = useRouter();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    const res = await fetch("/api/login", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ email, password }),
    });
    if (res.ok) {
      router.push("/tizaia");
    } else {
      const data = await res.json();
      setError(data.error || "Error al iniciar sesión");
    }
  };

  return (
    <div className="neon-card p-6 max-w-md mx-auto mt-20">
      <h2 className="neon-text text-2xl font-orbitron mb-4 text-center">Iniciar Sesión</h2>
      <form onSubmit={handleSubmit} className="flex flex-col gap-4">
        <input
          type="email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          placeholder="Email"
          required
          aria-label="Correo electrónico"
          className="p-2 border-2 border-[#00ccff] bg-[#1a1a1a] rounded-lg text-white"
        />
        <input
          type="password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          placeholder="Contraseña"
          required
          aria-label="Contraseña"
          className="p-2 border-2 border-[#00ccff] bg-[#1a1a1a] rounded-lg text-white"
        />
        {error && <p className="text-[#ff00ff] text-center">{error}</p>}
        <button type="submit" className="neon-button">Ingresar</button>
      </form>
      <p className="neon-link text-center mt-4" onClick={() => router.push("/auth")}>¿No tienes cuenta? Registrarse</p>
    </div>
  );
}
