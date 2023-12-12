---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}

-- more keybinds!
M.nvimtree = {
  n = {
    ["<leader>to"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
    ["<leader>tt"] = { "<cmd> NvimTreeFocus <CR>", "Focus nvimtree" },
  }
}

return M
