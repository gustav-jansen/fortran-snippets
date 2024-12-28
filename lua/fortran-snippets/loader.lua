local ls = require("luasnip")

local function load_snippets()
    local snippet_defs = require("fortran_snippets.snippets").get_snippets()
    ls.add_snippets("fortran", snippet_defs)
end

return {
    load_snippets = load_snippets
}
