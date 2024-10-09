{
  description = "Neovim derivation";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    gen-luarc.url = "github:mrcjkb/nix-gen-luarc-json";

    # Add bleeding-edge plugins here.
    # They can be updated with `nix flake update` (make sure to commit the generated flake.lock)
    lz-n.url = "github:nvim-neorocks/lz.n";
    which-key = {
      url = "github:folke/which-key.nvim";
      flake = false;
    };
    bufonly = {
      url = "github:numToStr/BufOnly.nvim";
      flake = false;
    };
    mini-ai = {
      url = "github:echasnovski/mini.ai";
      flake = false;
    };
    mini-move = {
      url = "github:echasnovski/mini.move";
      flake = false;
    };
    mini-clue = {
      url = "github:echasnovski/mini.clue";
      flake = false;
    };
    mini-bufremove = {
      url = "github:echasnovski/mini.bufremove";
      flake = false;
    };
    rip-substitute = {
      url = "github:chrisgrieser/nvim-rip-substitute";
      flake = false;
    };
    smart-open = {
      url = "github:danielfalk/smart-open.nvim";
      flake = false;
    };
    nx = {
      url = "github:tenxsoydev/nx.nvim";
      flake = false;
    };
    fzy-lua-native = {
      url = "github:romgrk/fzy-lua-native";
      flake = false;
    };
    scrollEOF = {
      url = "github:Aasim-A/scrollEOF.nvim";
      flake = false;
    };
    nvim-cmp = {
      url = "github:yioneko/nvim-cmp/perf";
      flake = false;
    };
    scratch = {
      url = "github:cenk1cenk2/scratch.nvim";
      flake = false;
    };
    multiple-cursors = {
      url = "github:brenton-leighton/multiple-cursors.nvim";
      flake = false;
    };
    tree-pairs = {
      url = "github:yorickpeterse/nvim-tree-pairs";
      flake = false;
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-utils,
    gen-luarc,
    ...
  }: let
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    # This is where the Neovim derivation is built.
    neovim-overlay = import ./nix/neovim-overlay.nix {inherit inputs;};
  in
    flake-utils.lib.eachSystem supportedSystems (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          # Import the overlay, so that the final Neovim derivation(s) can be accessed via pkgs.<nvim-pkg>
          neovim-overlay
          # This adds a function can be used to generate a .luarc.json
          # containing the Neovim API all plugins in the workspace directory.
          # The generated file can be symlinked in the devShell's shellHook.
          gen-luarc.overlays.default
        ];
      };
      shell = pkgs.mkShell {
        name = "nvim-devShell";
        buildInputs = with pkgs; [
          # Tools for Lua and Nix development, useful for editing files in this repo
          lua-language-server
          nil
          stylua
          luajitPackages.luacheck
        ];
        shellHook = ''
          # symlink the .luarc.json generated in the overlay
          ln -fs ${pkgs.nvim-luarc-json} .luarc.json
          fish
        '';
      };
    in {
      packages = rec {
        default = nvim;
        nvim = pkgs.nvim-pkg;
      };
      devShells = {
        default = shell;
      };
    })
    // {
      # You can add this overlay to your NixOS configuration
      overlays.default = neovim-overlay;
    };
}
