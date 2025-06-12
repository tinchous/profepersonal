import { NextResponse } from 'next/server';

export async function POST(request: Request) {
  const { text, voice = 'es-US-Neural2-A' } = await request.json();
  try {
    const response = await fetch('https://texttospeech.googleapis.com/v1/text:synthesize', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${process.env.GOOGLE_CLOUD_API_KEY}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        input: { text },
        voice: { languageCode: 'es-US', name: voice },
        audioConfig: { audioEncoding: 'MP3' },
      }),
    });
    if (!response.ok) throw new Error('Error en TTS');
    const { audioContent } = await response.json();
    return NextResponse.json({ audio: audioContent });
  } catch (error) {
    console.error('Error en TTS:', error);
    return NextResponse.json({ error: 'Error al generar audio' }, { status: 500 });
  }
}
