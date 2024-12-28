local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local s = ls.snippet
local i = ls.insert_node
local rep = require("luasnip.extras").rep

local function derivedtype_snippet()
    return s("nc", fmt([[
module {}
  implicit none
  private
  public :: {}
  
  type, extends({}) :: {}
    ! Add components here
  contains
    {}
  end type {}

contains

{}

end module {}
    ]], {
        i(1),
        i(2),
        i(3),
        rep(2),
        i(4, "procedure_bindings"),
        rep(2),
        i(5, "implementations"),
        rep(1),
    }))
end

local function module_snippet()
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

local snippets = {
    derivedtype_snippet,
    module_snippet,
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
