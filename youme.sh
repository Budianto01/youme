echo "Mengecek dependensi..."

pkg install -y mpv python ffmpeg openssl curl

pip install --upgrade pip
pip install --upgrade yt-dlp certifi


read -p "Masukkan link YouTube: " link


if [ -z "$link" ]; then
  echo "Link tidak boleh kosong."
  exit 1
fi


echo "Memutar musik dari YouTube..."
SSL_CERT_FILE=$(python -m certifi) mpv --no-video --ytdl-format=bestaudio "$link"
