read -p "Masukkan link YouTube: " link

echo "Memutar musik dari $link..."
mpv --no-video --ytdl-format bestaudio "$link"
