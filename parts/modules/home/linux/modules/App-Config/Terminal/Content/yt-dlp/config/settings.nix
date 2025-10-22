{
  embed-thumbnail = true;
  embed-subs = true;
  sub-langs = "english";
  downloader = "aria2c";
  downloader-args = "aria2c:'-c -x8 -s8 -k1M'";
  format = "bv*[protocol=m3u8_native]+ba[protocol=m3u8_native]/bv*+ba/bv+ba/b/worst";
  extractor-args = "youtube:player_js_version=actual";
}
