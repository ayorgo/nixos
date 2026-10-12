{
  config,
  lib,
  pkgs,
  ...
}:

let
  headerTex = "pandoc/header.tex";
  codeTheme = "pandoc/code.theme";
  snippetLua = "pandoc/git-snippet.lua";
  stylesHTML = "pandoc/templates/common/styles.html";
  templateHTML = "pandoc/templates/html/template.html";
  templatePDF = "pandoc/templates/pdf/template.tex";
  dataPath = name: "${config.xdg.dataHome}/${name}";
in
{
  xdg.dataFile.${headerTex}.source = ./templates/pdf/header.tex;
  xdg.dataFile.${codeTheme}.source = ./code.theme;
  xdg.dataFile.${snippetLua}.source = ./git-snippet.lua;
  xdg.dataFile.${stylesHTML}.source = ./templates/common/styles.html;
  xdg.dataFile.${templateHTML}.source = ./templates/html/template.html;
  xdg.dataFile.${templatePDF}.source = ./templates/pdf/template.tex;

  programs.pandoc = {
    enable = true;
    defaults = [
      {
        to = "html";
        template = dataPath templateHTML;
        variables = {
          mainfont = "Source Serif";
          monofont = "Source Code Pro";
          monofontoptions = [ "Weight=Medium" ];
        };
      }
      {
        to = "pdf";
        pdf-engine = "lualatex";
        template = dataPath templatePDF;
        include-in-header = [ (dataPath headerTex) ];
        variables = {
          mainfont = "Libertinus Serif";
          sansfont = "Libertinus Sans";
          mathfont = "Libertinus Math";
          monofont = "Source Code Pro";
          monofontoptions = [ "Weight=Regular" ];
          fontsize = "12pt";
          linestretch = "1.2";
          geometry = [ "top=2cm" "bottom=2cm" "left=2.5cm" "right=2.5cm" ];
          colorlinks = true;
          linkcolor = "[RGB]{30,100,190}";
          urlcolor = "[RGB]{30,100,190}";
          citecolor = "[RGB]{30,100,190}";
          filecolor = "[RGB]{30,100,190}";
          hyperrefoptions = [ "breaklinks=true" "linktoc=all" ];
        };
      }
      {
        toc = true;
        highlight-style = dataPath codeTheme;
        filters = [ (dataPath snippetLua) ];
      }
    ];
  };
}
