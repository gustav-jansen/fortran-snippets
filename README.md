# nvim-fortran-snippets

A Neovim plugin providing LuaSnip snippets for Fortran programming. These
snippets are designed to help you quickly create boilerplate code for modules,
derived types, and more.

---

## Features

- **Fortran-specific snippets**:
  - Snippets to streamline modern Fortran development.
- **Integration with LuaSnip**:
  - Uses [LuaSnip](https://github.com/L3MON4D3/LuaSnip) for snippet management.
- **Easy installation**:
  - Compatible with `packer.nvim`.

---

## Installation

### Prerequisites

- **Neovim 0.10+**: Required for Lua-based configuration and plugins.
- **LuaSnip**: This plugin relies on LuaSnip. Ensure it is installed.

### Installing with `packer.nvim`

1. Add the plugin to your `packer.nvim` configuration:

   ```lua
   require("packer").startup(function(use)
       -- Install LuaSnip (dependency)
       use "L3MON4D3/LuaSnip"

       -- Install nvim-fortran-snippets
       use {
           "gustav-jansen/nvim-fortran-snippets",
           config = function()
               require("fortran_snippets").setup()
           end,
       }
   end)

2. Run the following command in Neovim to install the plugin:
    ```
    :PackerSync

