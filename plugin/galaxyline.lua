if vim.fn.has("nvim-0.5") ~= 1 then
    error("Sorry this plugin only works with versions of Neovim that supports Lua")
    return
end

vim.g.loaded_galaxyline = 1

require("galaxyline").galaxyline_augroup()
