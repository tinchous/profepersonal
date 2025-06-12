for page in tizaia tuprofeersonal generatusejercicios tuexampersonal servicios planes sobre-nosotros contacto blog revista-peo herramientas laboratorios tienda; do
  if [ ! -f app/$page/page.tsx ]; then
    cat <<EOL > app/$page/page.tsx
export default function $page() {
  return <div>$page - En desarrollo</div>;
}
EOL
  else
    print_message "WARNING" $YELLOW "La página $page/page.tsx ya existe, saltando..."
  fi
done
