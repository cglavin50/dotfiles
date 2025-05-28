{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.size = 10000;
    history.path = "\${XDG_DATA_HOME}/zsh/history";

    oh-my-zsh = {
      enable = true;
      plugins = [
	"git"
	"gitignore"
	"colored-man-pages"
	"command-not-found"
	"sudo"
      ];
      theme = "robbyrussell";
    };
    shellAliases = {
      ll = "${pkgs.eza}/bin/eza -lha --icons=auto --sort=name --group-directories-first"; # long list all (stole from model repo)
      rebuild-ares = "sudo nixos-rebuild switch --flake ~/dotfiles#ares";
    };
  };
}
