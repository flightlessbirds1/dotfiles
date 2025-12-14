{ lib, ... }:
{
  options = {
    environment = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Change my environment. Use noctalia or mine.";
    };
  };
  config = {
    environment = "mine";
  };
}
