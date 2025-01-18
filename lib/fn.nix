{ lib, ... }:
{
  keymapRequire = modName: method: {
    __raw = ''
      function() require("${modName}").${method}() end
    '';
  };
  keymapRequire' = modName: method: args: {
    __raw =
      let
        isSetOrList = builtins.typeOf args == "set" || builtins.typeOf args == "list";
        params = if isSetOrList then "${lib.nixvim.toLuaObject args}" else null;
      in
      ''function() require("${modName}").${method}(${params}) end'';
  };
}
