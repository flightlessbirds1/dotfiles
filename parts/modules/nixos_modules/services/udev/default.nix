_: {
  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", \
      ATTRS{idVendor}=="feed", ATTRS{idProduct}=="1212", \
      MODE="0660", TAG+="uaccess"
  '';
}
