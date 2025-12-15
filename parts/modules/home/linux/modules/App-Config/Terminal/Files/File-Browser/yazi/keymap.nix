{ ... }:
{
  programs.yazi.keymap.mgr.prepend_keymap = [
    {
      on = [
        "Q"
      ];
      run = "quit";
    }
    {
      on = [
        "q"
      ];
      run = "quit --no-cwd-file";
    }
    {
      on = [
        "c"
        "m"
      ];
      run = "plugin chmod";
    }
    {
      on = [
        "C"
      ];
      run = "plugin ouch";
    }
    {
      on = [
        "g"
        "i"
      ];
      run = "plugin lazygit";
    }
    {
      on = [
        "l"
      ];
      run = "plugin bypass";
    }
    {
      on = [
        "h"
      ];
      run = "plugin bypass reverse";
    }
    {
      on = [
        "u"
      ];
      run = "plugin restore";
    }
    {
      on = [
        "D"
        "u"
      ];
      run = "plugin restore -- --interactive --interactive-overwrite";
    }
  ];
}
