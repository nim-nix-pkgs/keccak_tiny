{
  description = ''A wrapper for the keccak-tiny C library'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."keccak_tiny-master".dir   = "master";
  inputs."keccak_tiny-master".owner = "nim-nix-pkgs";
  inputs."keccak_tiny-master".ref   = "master";
  inputs."keccak_tiny-master".repo  = "keccak_tiny";
  inputs."keccak_tiny-master".type  = "github";
  inputs."keccak_tiny-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."keccak_tiny-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}