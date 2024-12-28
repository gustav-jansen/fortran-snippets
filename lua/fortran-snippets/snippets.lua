local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local s = ls.snippet
local i = ls.insert_node

local function derivedtype_snippet()
    return s("derivedtype", fmt([[
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
        i(1, "module_name"),
        i(2, "type_name"),
        i(3, "base_class"),
        i(2, "type_name"),
        i(4, "procedure_bindings"),
        i(2, "type_name"),
        i(5, "implementations"),
        i(1, "module_name"),
    }))
end

local function module_snippet()
    return s("module", fmt([[
module {}
  implicit none
  {}
end module {}
    ]], {
        i(1, "module_name"),
        i(2, "body"),
        i(1),
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
