"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";

export default function Register() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [curso, setCurso] = useState("");
  const [error, setError] = useState("");
  const router = useRouter();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    const res = await fetch("/api/auth/[...nextauth]/register", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ email, password, curso, plan: "TRIAL" }),
    });
    if (res.ok) {
      router.push("/auth/signin");
    } else {
      const data = await res.json();
      setError(data.error || "Error al registrarse");
    }
  };

  return (
    <div className="neon-card p-6 max-w-md mx-auto mt-20">
      <h2 className="neon-text text-2xl font-orbitron mb-4 text-center">Registrarse</h2>
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
        <select
          value={curso}
          onChange={(e) => setCurso(e.target.value)}
          required
          aria-label="Curso"
          className="p-2 border-2 border-[#00ccff] bg-[#1a1a1a] rounded-lg text-white"
        >
          <option value="" disabled>Selecciona tu curso</option>
          <option value="7mo">7mo Grado</option>
          <option value="8vo">8vo Grado</option>
          <option value="9no">9no Grado</option>
          <option value="10mo">10mo Grado</option>
          <option value="11vo">11vo Grado</option>
          <option value="12do">12do Grado</option>
        </select>
        {error && <p className="text-[#ff00ff] text-center">{error}</p>}
        <button type="submit" className="neon-button">Registrarse</button>
      </form>
      <p className="neon-link text-center mt-4" onClick={() => router.push("/auth/signin")}>¿Ya tienes cuenta? Ingresar</p>
    </div>
  );
}
