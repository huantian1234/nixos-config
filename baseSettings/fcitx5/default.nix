{ config, pkgs, ... }:
{
  i18n.defaultLocale = "zh_CN.UTF-8";
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.enableRimeData = true;
    fcitx5.addons = with pkgs; [
      fcitx5-rime
      fcitx5-chinese-addons
    ];
  };
}
