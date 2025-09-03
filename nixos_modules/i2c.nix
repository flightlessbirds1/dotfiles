{ ... }:
{
  hardware.i2c.enable = true;
  users.users.insomniac.extraGroups = [ "i2c" ];
}
