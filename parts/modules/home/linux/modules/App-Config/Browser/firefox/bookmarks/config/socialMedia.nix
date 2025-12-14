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
      name = "upRootNutrition";
      url = "https://upRootNutrition.com";
      tags = [
        "uprootnutrition"
        "up"
        "root"
        "nutrition"
      ];
      keyword = "Root";
    }
    {
      name = "Disboard";
      url = "https://disboard.org";
      tags = discordTags;
      keyword = "Disboard";
    }
    {
      name = "Discord (Web Client)";
      url = "https://discord.com/channels/@me";
      tags = discordTags;
      keyword = "Discord";
    }
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
      name = "Lemmy";
      url = "https://lemmy.world";
      tags = [
        "lemmy"
        "social"
      ];
      keyword = "Lem";
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
      name = "OnlyFans";
      url = "https://onlyfans.com";
      tags = [
        "onlyfans"
        "only"
        "fans"
      ];
      keyword = "Only";
    }
    {
      name = "Pixelfed";
      url = "https://pixelfed.social/i/web/profile/651714972141461392";
      tags = [
        "pixelfed"
        "pixel"
        "pi"
      ];
      keyword = "Pix";
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
      name = "Slack";
      url = "https://app.slack.com/";
      tags = [
        "slack"
        "social"
      ];
      keyword = "Slack";
    }
    {
      name = "StreamLabs";
      url = "https://streamlabs.com/dashboard";
      tags = [
        "streamlabs"
        "stream"
        "labs"
      ];
      keyword = "Stream";
    }
    {
      name = "Tinder";
      url = "https://tinder.com/app/recs";
      tags = [
        "tinder"
        "dating"
        "booty"
      ];
      keyword = "Tinder";
    }
    {
      name = "YouTube";
      url = "https://www.youtube.com";
      tags = youtubeTags;
      keyword = "You";
    }
    {
      name = "YouTube Studio";
      url = "https://studio.youtube.com/channel/UCy9yYcDx2XuVVgcWLJJDoxw";
      tags = [
        "studio"
      ]
      ++ youtubeTags;
      keyword = "Studio";
    }
    {
      name = "X (Twitter)";
      url = "https://x.com/upRootNutrition";
      tags = [
        "twitter"
        "x"
        "social"
      ];
      keyword = "Twitter";
    }
  ];
}
