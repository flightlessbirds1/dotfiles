{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:
# Preferences that are not enforceable by policy
{
  # Privacy
  "privacy.partition.serviceWorkers" = true;
  "privacy.partition.always_partition_third_party_non_cookie_storage" = true;
  "privacy.partition.always_partition_non_cookie_storage.exempt_sessionstorage" = true;
  "privacy.fingerprintingProtection" = true;
  "privacy.annotate_channels.strict_list.enabled" = true;
  "privacy.query_stripping.enabled" = true;
  "privacy.trackingprotection.socialtracking.enabled" = true;
  "privacy.trackingprotection.emailtracking.enabled" = true;
  "privacy.donottrackheader.enabled" = true;
  "privacy.resistFingerprinting" = true;
  "privacy.resistFingerprinting.block_mozAddonManager" = true;

  # Containers
  "privacy.userContext.enabled" = true;

  # Security
  "security.webauth.u2f" = true;

  # Telemetry
  "beacon.enabled" = false;
  "toolkit.telemetry.enabled" = false;
  "toolkit.telemetry.unified" = false;
  "toolkit.telemetry.server" = "data:,";
  "toolkit.telemetry.newProfilePing.enabled" = false;
  "toolkit.telemetry.shutdownPingSender.enabled" = false;
  "toolkit.telemetry.updatePing.enabled" = false;
  "toolkit.telemetry.bhrPing.enabled" = false;
  "toolkit.teleemetry.firstShutdownPing.enabled" = false;
  "toolkit.telemetry.coverage.opt-out" = true;
  "toolkit.coverage.opt-out" = true;
  "toolkit.coverage.endpoint.base" = "";

  # Studies
  "app.shield.optoutstudies.enabled" = false;
  "app.normandy.enabled" = false;
  "app.normandy.api_url" = "";

  # No crash reports
  "breakpad.reportURL" = "";

  # HTTPS/SSL/TLS/OSCP/CERTS
  "security.pki.sha1_enforcement_level" = 1;
  "security.cert_pinning.enforcement_level" = 2;
  "security.remote_settings.crlite_filters.enabled" = true;
  "security.pki.crlite_mode" = 2;

  # Annoyances
  "media.autoplay.default" = 5;
}
