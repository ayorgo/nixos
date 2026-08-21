{
  config,
  lib,
  pkgs,
  ...
}:

let
  headerTex = "pandoc/header.tex";
  codeTheme = "pandoc/code.theme";
  dataPath = name: "${config.xdg.dataHome}/${name}";
in
{
  xdg.dataFile.${headerTex}.source = ./header.tex;
  xdg.dataFile.${codeTheme}.source = ./code.theme;

  programs.pandoc = {
    enable = true;
    defaults = {
      pdf-engine = "lualatex";
      toc = true;
      highlight-style = dataPath codeTheme;
      include-in-header = [ (dataPath headerTex) ];
      variables = {
        mainfont = "Libertinus Serif";
        sansfont = "Libertinus Sans";
        mathfont = "Libertinus Math";
        monofont = "Source Code Pro";
        monofontoptions = [ "Weight=Medium" ];
        fontsize = "11pt";
        geometry = [ "margin=2.5cm" ];
        colorlinks = true;
        linkcolor = "[RGB]{30,100,190}";
        urlcolor = "[RGB]{30,100,190}";
        citecolor = "[RGB]{30,100,190}";
        filecolor = "[RGB]{30,100,190}";
        hyperrefoptions = [ "breaklinks=true" "linktoc=all" ];
      };
    };
  };
}
