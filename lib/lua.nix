{ lib, ... }:
{
  mkRequire = modName: method: ''
    do
      require("${modName}").${method}() 
    end
  '';

  mkRequire' =
    modName: method: args:
    let
      isSetOrList = builtins.typeOf args == "set" || builtins.typeOf args == "list";
      params = if isSetOrList then "${lib.nixvim.toLuaObject args}" else null;
    in
    ''
      do
        require("${modName}").${method}(${params})
      end
    '';
}
