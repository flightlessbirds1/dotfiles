_: {
  # Get rid of prefetching
  "network.prefetch-next" = false;
  "network.dns.disablePrefetch" = true;
  "network.predictor.enabled" = false;
  "network.http.speculative-parallel-limit" = 0;
  "browser.places.speculativeConnect.enabled" = false;
  "network.gio.supportedProtocols" = "";
  "network.file.disable_unc_paths" = true;

  # Don't cache
  "browser.cache.disk.enable" = false;
  "browser.sessionstore.privacy_level" = 2;
  "browser.sessionstore.resume_from_crash" = false;
  "browser.pagethumbnails.capturing_disabled" = true;
  "browser.helperApps.deleteTempFileOnExit" = true;

  # Restrict referals
  "network.http.referer.XOriginPolicy" = 2;
  "network.http.referer.XOriginTrimmingPolicy" = 2;

  # Media
  "media.peerconnection.enabled" = false;
  "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
  "media.peerconnection.ice.default_address_only" = true;
  "media.peerconnection.ice.no_host" = true;
  "webgl.disabled" = true;
  "media.autoplay.default" = 5;
  "media.eme.enabled" = false;

  # Do not exempt session storage from isolation
  "privacy.partition.always_partition_non_cookie_storage.exempt_sessionstorage" = false;

  # Delete data
  "network.cookie.lifetimePolicy" = 2;
  "privacy.sanitize.sanitizeOnShutdown" = true;
  "privacy.clearOnShutdown.cache" = true;
  "privacy.clearOnShutdown.cookies" = false;
  "privacy.clearOnShutdown.downloads" = true;
  "privacy.clearOnShutdown.formdata" = true;
  "privacy.clearOnShutdown.history" = false;
  "privacy.clearOnShutdown.offlineApps" = true;
  "privacy.clearOnShutdown.sessions" = true;
  "privacy.clearOnShutdown.sitesettings" = true;
  "privacy.sanitize.timeSpan" = 0;
}
