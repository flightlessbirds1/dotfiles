{...}: {
  flake.templates = {
    haskell = {
      path = ../templates/haskell;
      description = "A Haskell project using haskell-flake with a library, executable, and tests";
    };
    typst = {
      path = ../templates/typst;
      description = "typst template";
    };
  };
}
