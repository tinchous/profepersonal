#!/bin/bash

# 1. Mover archivos a la estructura correcta
mkdir -p public/{css,js,images}

# Mover solo si los archivos existen
[ -f "prope.html" ] && mv prope.html public/index.html
[ -f "css/styles.css" ] && mv css/styles.css public/css/
[ -d "js" ] && mv js/* public/js/

# 2. Crear vercel.json optimizado
cat > vercel.json <<EOL
{
  "version": 2,
  "builds": [
    {
      "src": "public/**",
      "use": "@vercel/static"
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "/public/index.html"
    },
    {
      "src": "/css/(.*)",
      "dest": "/public/css/\$1"
    },
    {
      "src": "/js/(.*)",
      "dest": "/public/js/\$1"
    }
  ]
}
EOL

# 3. Actualizar package.json para Vercel
if [ -f "package.json" ]; then
  jq '.scripts += {
    "start": "serve public",
    "build": "echo \"Build completo\" && cp -R css/ public/ && cp -R js/ public/",
    "dev": "live-server public"
  }' package.json > tmp.json && mv tmp.json package.json
else
  cat > package.json <<EOL
{
  "name": "profe-personal",
  "version": "1.0.0",
  "scripts": {
    "start": "serve public",
    "build": "echo \"Build completo\" && cp -R css/ public/ && cp -R js/ public/",
    "dev": "live-server public"
  },
  "dependencies": {
    "serve": "^14.2.0"
  },
  "devDependencies": {
    "live-server": "^1.2.2"
  }
}
EOL
fi

# 4. Instalar dependencias
npm install

# 5. Crear archivos de respaldo si no existen
[ ! -f "public/index.html" ] && cp prope.html public/index.html

echo "✅ Estructura optimizada para Vercel:"
tree -L 3
