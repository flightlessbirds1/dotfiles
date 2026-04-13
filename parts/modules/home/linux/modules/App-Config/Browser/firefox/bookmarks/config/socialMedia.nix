let
  discordTags = [
    "disboard"
    "discord"
    "dis"
    "ds"
    "social"
  ];
  youtubeTags = [
    "youtube"
    "you"
    "tube"
    "yt"
  ];
in
{
  name = "Social Media";
  toolbar = false;
  bookmarks = [
    {
      name = "Facebook";
      url = "https://www.facebook.com/";
      tags = [
        "facebook"
        "face"
        "book"
      ];
      keyword = "Face";
    }
    {
      name = "Gmail";
      url = "https://mail.google.com/mail/u/0/#inbox";
      tags = [
        "gmail"
        "google"
        "mail"
        "gm"
        "email"
      ];
      keyword = "Gmail";
    }
    {
      name = "Instagram";
      url = "https://www.instagram.com/";
      tags = [
        "instagram"
        "insta"
      ];
      keyword = "IG";
    }
    {
      name = "Proton Mail";
      url = "https://mail.proton.me/u/1/inbox";
      tags = [
        "proton"
        "mail"
        "pr"
        "email"
      ];
      keyword = "Pro";
    }
    {
      name = "Proton Calendar";
      url = "https://calendar.proton.me";
      tags = [
        "proton"
        "calendar"
      ];
      keyword = "Cal";
    }
    {
      name = "Proton VPN";
      url = "https://account.proton.me/u/0/vpn";
      tags = [
        "proton"
        "vpn"
      ];
      keyword = "VPN";
    }
    {
      name = "Reddit";
      url = "https://www.reddit.com";
      tags = [
        "reddit"
        "social"
      ];
      keyword = "Reddit";
    }
    {
      name = "YouTube";
      url = "https://www.youtube.com";
      tags = youtubeTags;
      keyword = "You";
    }
  ];
}
