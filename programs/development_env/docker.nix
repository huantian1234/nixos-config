{config, pkgs, ...}:
{
  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings = {
   registry-mirrors = [
     "https://hub-mirror.c.163.com"
   ]; 
  };
}
