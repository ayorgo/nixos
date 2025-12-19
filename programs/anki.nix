{ lib, pkgs, config, ... }:

{
  home = {
    packages = with pkgs; [
      anki
    ];
    sessionVariables = {
      ANKI_WAYLAND = "1";
      # https://github.com/ankitects/anki/issues/1767#issuecomment-1827121475
      QT_SCALE_FACTOR_ROUNDING_POLICY = "RoundPreferFloor"; 
    };
  };
}

