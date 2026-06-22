_: {
  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", ATTRS{idVendor}=="feed", ATTRS{idProduct}=="1212", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
  '';
}
