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
   ```

2. Run the following command in Neovim to install the plugin:

   ```vim
   :PackerSync
   ```

---

## Usage

1. Open a Fortran file (`*.f90`, `*.f95`, etc.).
2. Trigger snippets using your LuaSnip keybindings (usually `<Tab>` or `<C-l>` for expansion).
3. Example:
   - Type `ndt` and expand it to insert a derived type skeleton.

---

## Example Snippets

### `ndt`

Expands into:

```fortran
module module_name
  implicit none
  private

  public :: type_name

  type :: type_name
  contains
    procedure :: cleanup => cleanup
    procedure :: clear => clear
  end type type_name

  interface type_name
    module procedure constructor
  end interface constructor
contains
  function constructor() result(this)
    type(type_name) :: this

    call this%clear()
  end function constructor

  subroutine cleanup(this)
    class(type_name), intent(inout) :: this

    call this%clear()
  end subroutine cleanup

  subroutine clear(this)
    class(type_name), intent(inout) :: this

  end subroutine clear
end module module_name
```

---

## Adding More Snippets

To extend or customize the snippets:
1. Open the `snippets.lua` file in the plugin directory (`lua/fortran_snippets/snippets.lua`).
2. Add new snippet definitions as separate functions.

---

## Contributing

Contributions are welcome! Feel free to submit a pull request or open an issue for feature requests or bug fixes.

---

## License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.
