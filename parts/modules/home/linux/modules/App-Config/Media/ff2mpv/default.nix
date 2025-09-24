_: {
  home.file.".mozilla/native-messaging-hosts/ff2mpv.json".text = builtins.toJSON {
    name = "ff2mpv";
    description = "ff2mpv's external manifest";
    path = "/tmp/ff2mpv-debug";
    type = "stdio";
    allowed_extensions = ["ff2mpv@yossarian.net"];
  };
}
