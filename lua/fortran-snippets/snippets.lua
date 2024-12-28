local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local s = ls.snippet
local i = ls.insert_node
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

local function new_class_snippet()
    return s("nc", fmt([[
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

local function new_abstract_class_snippet()
    return s("nabc", fmt([[
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

local function new_extended_class_snippet()
    return s("nec", fmt([[
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
        rep(1),
    }))
end

local snippets = {
    new_module_snippet,
    new_class_snippet,
    new_abstract_class_snippet,
    new_extended_class_snippet,
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
