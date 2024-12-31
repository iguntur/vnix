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
        isSet = builtins.typeOf args == "set";
        params = if isSet then "${lib.nixvim.toLuaObject args}" else null;
      in
      ''function() require("${modName}").${method}(${params}) end'';
  };
}
