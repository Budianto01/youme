
echo "Mengecek dependensi..."

pkg install -y mpv python ffmpeg openssl curl

pip install --upgrade pip
pip install --upgrade yt-dlp certifi


read -p "Masukkan link playlist YouTube: " link

if [ -z "$link" ]; then
  echo "Link tidak boleh kosong."
  exit 1
fi


tmpfile=$(mktemp)

echo "Mengambil daftar video dari playlist..."
yt-dlp -j --flat-playlist "$link" | jq -r '.url' | sed 's_^_https://www.youtube.com/watch?v=_' > "$tmpfile"


shuf "$tmpfile" -o "$tmpfile"


echo "Memutar playlist secara acak..."
while IFS= read -r video; do
  echo "Now playing: $video"
  SSL_CERT_FILE=$(python -m certifi) mpv --no-video --ytdl-format=bestaudio "$video"
done < "$tmpfile"


rm "$tmpfile"
