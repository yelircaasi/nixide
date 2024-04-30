{ pkgs, inputs, ...}:

let
  inherit (pkgs.lib) evalModules;
in
{
#   withPlugins = cond: plugins: if cond then plugins else [ ];
#   writeIf = cond: msg: if cond then msg else "";

  mkNeovim = {  }:
    let
    #   inherit (nvimOpts.config) nvim;
      nvimEvaluated = (evalModules {
        modules = [{ imports = [./core ./language-independent ./languages ]; }];
        specialArgs = { inherit pkgs; }).nvim;
      };
      nvimConfig
    in
    pkgs.wrapNeovim pkgs.neovim-unwrapped {
      withNodeJs = true;
      withPython3 = true;
      configure = {
        luaCustomRC = nvimEvaluated.luaConfigRC;
        packages.myVimPackage = {
          start = nvimEvaluated.startPlugins;
          opt = nvimEvaluated.optPlugins;
        };
      };
    };
}