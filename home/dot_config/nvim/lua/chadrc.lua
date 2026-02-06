-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

-- Base46 is the REAL theme engine in NvChad
M.base46 = {
  theme = "catppuccin",

  hl_override = {
    Normal = { fg = "#839496", bg = "#1E1D2F" },
    NormalFloat = { bg = "#1E1D2F" },
  },
}

-- UI uses base46 colors automatically
M.ui = {
  theme_toggle = { "catppuccin", "one_light" },
}

return M