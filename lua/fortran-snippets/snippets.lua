local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node
local rep = require("luasnip.extras").rep

local function new_module_snippet()
    return s("nm", fmt([[
module {}
  implicit none
  {}
end module {}
    ]], {
        i(1, "module_name"),
        i(2, "body"),
        rep(1),
    }))
end

local function new_dt_snippet()
    return s("ndt", fmt([[
module {}
  implicit none
  private

  public :: {}

  type :: {}
  contains
    procedure :: cleanup => cleanup
    procedure :: clear => clear
  end type {}

  interface {}
    module procedure constructor
  end interface {}
contains
  function constructor() result(this)
    type({}) :: this

    call this%clear()
  end function constructor

  subroutine cleanup(this)
    class({}), intent(inout) :: this

    call this%clear()
  end subroutine cleanup

  subroutine clear(this)
    class({}), intent(inout) :: this

  end subroutine clear
end module {}
    ]], {
        i(1, "module_name"),
        i(2, "type_name"),
        rep(2),
        rep(2),
        rep(2),
        rep(2),
        rep(2),
        rep(2),
        rep(2),
        rep(1),
    }))
end

local function new_abstract_dt_snippet()
    return s("nadt", fmt([[
module {}
  implicit none
  private

  public :: {}

  type, abstract :: {}
  contains
    procedure(empty), deferred :: cleanup
  end type {}

  abstract interface
    subroutine empty(this)
      import :: {}

      class({}), intent(inout) :: this
    end subroutine empty
  end interface
end module {}
    ]], {
        i(1, "module_name"),
        i(2, "type_name"),
        rep(2),
        rep(2),
        rep(2),
        rep(2),
        rep(1),
    }))
end

local function find_class(result, class)
    for _, symbol in pairs(result[1].result) do
        if symbol.name == class and symbol.kind == 5 then
            return symbol
        end
    end
    return nil
end

local function get_symbols(base_class)
    local lresult = {}
    local params = {
        query = base_class
    }

    vim.lsp.buf_request_all(0, "workspace/symbol", params, function(result)
        if not result or vim.tbl_isempty(result) then
          table.insert(lresult, "No symbols found in the current document.")
          return
        end

        local symbol = find_class(result, base_class)
        if symbol then
            table.insert(lresult, symbol.name)
        end
    end )

    local success = vim.wait(500, function() return #lresult>0 end, 50)
    if not success then
        return "Nothing"
    end

    if #lresult > 0 then
        return table.concat(lresult, ", ")
    else
        return "No symbols"
    end
end

local function new_extended_dt_snippet()
    return s("nedt", fmt([[
module {}
  implicit none
  private

  public :: {}

  type, extends({}) :: {}
  contains
    procedure :: cleanup => cleanup
    procedure :: clear => clear
  end type {}

  interface {}
    module procedure constructor
  end interface {}
contains
  function constructor() result(this)
    type({}) :: this

    call this%clear()
  end function constructor

  subroutine cleanup(this)
    class({}), intent(inout) :: this

    call this%clear()
  end subroutine cleanup

  subroutine clear(this)
    class({}), intent(inout) :: this

  end subroutine clear

  {}
end module {}
    ]], {
        i(1, "module_name"),
        i(2, "type_name"),
        i(3, "base_class"),
        rep(2),
        rep(2),
        rep(2),
        rep(2),
        rep(2),
        rep(2),
        rep(2),
        f(function() return get_symbols("string") end),
        rep(1),
    }))
end

local snippets = {
    new_module_snippet,
    new_dt_snippet,
    new_abstract_dt_snippet,
    new_extended_dt_snippet,
}

local function get_snippets()
    local evaluated_snippets = {}
    for _, snippet_func in ipairs(snippets) do
        table.insert(evaluated_snippets, snippet_func())
    end
    return evaluated_snippets
end

return {
    get_snippets = get_snippets
}
