#!/bin/bash

# Crea estructura básica
mkdir -p public/{css,js,images}

# Mueve archivos existentes a sus ubicaciones correctas
mv css/styles.css public/css/
mv js/* public/js/

# Crea index.html base si no existe
if [ ! -f "index.html" ]; then
  cat > index.html <<EOL
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>ProfePersonal</title>
  <link rel="stylesheet" href="/public/css/styles.css">
</head>
<body>
  <div id="app"></div>
  <script src="/public/js/main.js" type="module"></script>
</body>
</html>
EOL
fi

# Crea package.json básico si no existe
if [ ! -f "package.json" ]; then
  cat > package.json <<EOL
{
  "name": "prope-personal",
  "version": "1.0.0",
  "scripts": {
    "start": "serve public",
    "build": "echo 'Build complete'"
  },
  "dependencies": {
    "serve": "^14.2.0"
  }
}
EOL
fi

# Crea vercel.json si no existe
if [ ! -f "vercel.json" ]; then
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
    }
  ]
}
EOL
fi

# Instala dependencias si hay package.json
if [ -f "package.json" ]; then
  npm install
fi

echo "✅ Estructura completada:"
tree -L 3
