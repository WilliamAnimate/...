local M = {}

M.ui = {
  tabufline = {
    order = { "treeOffset", "buffers", "tabs" },
  },

  theme = "catppuccin",
  statusline = {
    theme = "default", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "arrow",
    overriden_modules = nil,
  },
}
return M

