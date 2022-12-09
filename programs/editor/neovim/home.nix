{config, pkgs, ...}:
let
  install_lsp = pkgs.writeShellScriptBin "install_lsp" ''
      #!/bin/bash 
    if [ ! -d ~/.npm-global ]; then  
             mkdir ~/.npm-global
             npm set prefix ~/.npm-global
      else 
             npm set prefix ~/.npm-global
    fi
    npm i -g npm vscode-langservers-extracted typescript typescript-language-server 
  '';
in
{
  home = {
    packages = with pkgs;[
      install_lsp
    ];
  };
  home.file.".config/nvim/init.vim".source = ./nvim/init.vim;
  home.file.".config/nvim/lua"=./nvim/lua;
  home.file.".plugin"=./nvim/plugin;
}
