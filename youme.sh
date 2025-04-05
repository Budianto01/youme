#!/data/data/com.termux/files/usr/bin/bash

# Cek dan install dependensi
echo "Mengecek dependensi..."

pkg install -y mpv python ffmpeg openssl curl

pip install --upgrade pip
pip install --upgrade yt-dlp certifi

# Baca input link YouTube
read -p "Masukkan link YouTube: " link

# Cek apakah link kosong
if [ -z "$link" ]; then
  echo "Link tidak boleh kosong."
  exit 1
fi

# Jalankan mpv dengan sertifikat yang valid
echo "Memutar musik dari YouTube..."
SSL_CERT_FILE=$(python -m certifi) mpv --no-video --ytdl-format bestaudio "$link"
