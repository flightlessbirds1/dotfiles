{
  embed-thumbnail = true;
  embed-subs = true;
  sub-langs = "english";
  downloader = "aria2c";
  downloader-args = "aria2c:'-c -x8 -s8 -k1M'";
  # format = "bestvideo[vcodec^=avc1][ext=mp4][height<=720]+bestaudio[ext=m4a]/best[ext=mp4]/best";
  extractor-args = "youtube:player_js_version=actual";
}
