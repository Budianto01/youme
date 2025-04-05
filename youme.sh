
echo "Mengecek dan menginstal dependensi..."

pkg install mpv python ffmpeg openssl curl jq > /dev/null

pip install --upgrade pip > /dev/null
pip install --upgrade yt-dlp certifi > /dev/null


read -p "Masukkan link playlist YouTube: " link
read -p "Volume (0-130): " vol


if [ -z "$link" ]; then
  echo "Link tidak boleh kosong."
  exit 1
fi

if [ -z "$vol" ]; then
  vol=100  
fi


tmpfile=$(mktemp)

echo "Mengambil daftar video dari playlist..."
yt-dlp -j --flat-playlist "$link" | jq -r '.url' | sed 's_^_https://www.youtube.com/?v=_' > "$tmpfile"


shuf "$tmpfile" -o "$tmpfile"


echo "Memutar playlist secara acak dengan volume $vol%..."
while IFS= read -r video; do
  echo -e "\nNow playing: $video"
  SSL_CERT_FILE=$(python -m certifi) mpv --no-video --volume="$vol" --ytdl-format=bestaudio "$video"
done < "$tmpfile"


rm "$tmpfile"
