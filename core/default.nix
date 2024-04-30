{pkgs, lib, ...}: let
  inherit (lib) mkOption types;

  wrapLua = lua: ''
    lua << EOF
    ${lua}
    EOF
  '';
in
{
  options.nvim = {
    # configRC = mkOption {
    #   description = "";
    #   type = types.lines;
    #   default = "";
    # };

    luaConfigRC = mkOption {
      description = "";
      type = types.lines;
      default = "";
    };

    startPlugins = mkOption {
      description = "";
      type = types.listOf types.package;
      default = [ ];
    };

    optPlugins = mkOption {
      description = "";
      type = types.listOf types.package;
      default = [ ];
    };
  };

  config.nvim = {
    optPlugins = [];
    startPlugins = [];
    luaConfigRC = ""; 
  };
}