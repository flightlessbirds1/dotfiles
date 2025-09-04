{
  inputs,
  pkgs,
  config,
  ...
}: {
  programs.zsh = {
    enable = true;

    plugins = [
      {
        name = "titles";
        src = inputs.zsh-titles;
      }
    ];
  };
}
